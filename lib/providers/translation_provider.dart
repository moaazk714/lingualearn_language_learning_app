import 'package:flutter/foundation.dart';

import '../models/translation_language.dart';
import '../services/translation_service.dart';

class TranslationProvider extends ChangeNotifier {
  final TranslationService _service;

  TranslationProvider(this._service);

  String _sourceLanguageCode = 'en';
  String _targetLanguageCode = 'ur';
  String _inputText = '';
  String? _translatedText;
  String? _errorMessage;
  bool _isLoading = false;
  bool _canRetry = false;
  int _requestVersion = 0;
  final Map<String, String> _contentTranslationCache = {};
  final Map<String, Future<String>> _contentTranslationRequests = {};
  final Map<String, Object> _contentTranslationErrors = {};

  String get sourceLanguageCode => _sourceLanguageCode;
  String get targetLanguageCode => _targetLanguageCode;
  String get inputText => _inputText;
  String? get translatedText => _translatedText;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get canRetry => _canRetry;

  TranslationLanguage get sourceLanguage =>
      TranslationLanguage.findByCode(_sourceLanguageCode)!;
  TranslationLanguage get targetLanguage =>
      TranslationLanguage.findByCode(_targetLanguageCode)!;
  bool get canTranslate =>
      _inputText.trim().isNotEmpty &&
      _sourceLanguageCode != _targetLanguageCode &&
      !_isLoading;

  Future<String> translateLearningContent({
    required String text,
    required String sourceLanguageCode,
    required String targetLanguageCode,
  }) {
    if (text.trim().isEmpty) {
      return Future.error(
        const TranslationException('There is no text available to translate.'),
      );
    }
    if (sourceLanguageCode == targetLanguageCode) {
      return Future.value(text);
    }

    final key = '$sourceLanguageCode|$targetLanguageCode|$text';
    final cached = _contentTranslationCache[key];
    if (cached != null) return Future.value(cached);

    final previousError = _contentTranslationErrors[key];
    if (previousError != null) return Future.error(previousError);

    final pending = _contentTranslationRequests[key];
    if (pending != null) return pending;

    final request = _service
        .translate(
      text: text,
      sourceLanguageCode: sourceLanguageCode,
      targetLanguageCode: targetLanguageCode,
    )
        .then((result) {
      _contentTranslationCache[key] = result;
      _contentTranslationErrors.remove(key);
      if (_contentTranslationCache.length > 500) {
        _contentTranslationCache.remove(_contentTranslationCache.keys.first);
      }
      return result;
    }).catchError((Object error) {
      _contentTranslationErrors[key] = error;
      throw error;
    }).whenComplete(() {
      _contentTranslationRequests.remove(key);
    });
    _contentTranslationRequests[key] = request;
    return request;
  }

  void setSourceLanguage(String code) {
    if (TranslationLanguage.findByCode(code) == null) {
      _setValidationError('That source language is not supported.');
      return;
    }
    if (_sourceLanguageCode == code) return;
    _sourceLanguageCode = code;
    _clearTranslationState();
  }

  void setTargetLanguage(String code) {
    if (TranslationLanguage.findByCode(code) == null) {
      _setValidationError('That target language is not supported.');
      return;
    }
    if (_targetLanguageCode == code) return;
    _targetLanguageCode = code;
    _clearTranslationState();
  }

  void setInputText(String text) {
    if (_inputText == text) return;
    _inputText = text;
    _clearTranslationState();
  }

  void swapLanguages() {
    final source = _sourceLanguageCode;
    _sourceLanguageCode = _targetLanguageCode;
    _targetLanguageCode = source;
    _clearTranslationState();
  }

  void clearText() {
    _inputText = '';
    _clearTranslationState();
  }

  Future<void> translate() async {
    final requestVersion = ++_requestVersion;
    _translatedText = null;
    _errorMessage = null;
    _canRetry = false;

    if (_inputText.trim().isEmpty) {
      _isLoading = false;
      _errorMessage = 'Enter text to translate.';
      notifyListeners();
      return;
    }
    if (_sourceLanguageCode == _targetLanguageCode) {
      _isLoading = false;
      _errorMessage = 'Choose two different languages to translate.';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final result = await _service.translate(
        text: _inputText.trim(),
        sourceLanguageCode: _sourceLanguageCode,
        targetLanguageCode: _targetLanguageCode,
      );
      if (requestVersion != _requestVersion) return;
      if (result.trim().isEmpty || result.trim() == _inputText.trim()) {
        throw const TranslationException(
          'The service did not return a translated result. Please retry.',
        );
      }
      _translatedText = result;
      _isLoading = false;
    } on TranslationException catch (error) {
      if (requestVersion != _requestVersion) return;
      _errorMessage = error.message;
      _canRetry = true;
      _isLoading = false;
    } on Exception catch (error) {
      if (requestVersion != _requestVersion) return;
      _errorMessage = 'Translation failed: $error';
      _canRetry = true;
      _isLoading = false;
    }
    notifyListeners();
  }

  void _setValidationError(String message) {
    _invalidatePendingRequest();
    _translatedText = null;
    _errorMessage = message;
    _canRetry = false;
    notifyListeners();
  }

  void _clearTranslationState() {
    _invalidatePendingRequest();
    _translatedText = null;
    _errorMessage = null;
    _canRetry = false;
    notifyListeners();
  }

  void _invalidatePendingRequest() {
    _requestVersion++;
    _isLoading = false;
  }

  @override
  void dispose() {
    _requestVersion++;
    _service.close();
    super.dispose();
  }
}
