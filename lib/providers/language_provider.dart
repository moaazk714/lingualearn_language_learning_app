import 'package:flutter/foundation.dart';
import '../models/language_model.dart';
import '../models/translation_language.dart';
import '../services/storage_service.dart';

class LanguageProvider with ChangeNotifier {
  final StorageService _storageService;

  late LanguageModel _selectedLanguage;
  late TranslationLanguage _selectedTranslationLanguage;
  late String _selectedLevel;

  LanguageProvider(this._storageService) {
    _init();
  }

  void reset() {
    _init();
    notifyListeners();
  }

  void _init() {
    final savedCode = _storageService.getSelectedLanguage();
    _selectedLanguage = LanguageModel.supportedLanguages.firstWhere(
      (lang) => lang.id == savedCode,
      orElse: () => LanguageModel.supportedLanguages.first,
    );
    _selectedTranslationLanguage = TranslationLanguage.findByCode(
          _storageService.getSelectedTranslationLanguage(),
        ) ??
        TranslationLanguage.supportedLanguages.firstWhere(
          (language) => language.code == 'ur',
        );
    _selectedLevel = _storageService.getSelectedLevel();
  }

  LanguageModel get selectedLanguage => _selectedLanguage;
  TranslationLanguage get selectedTranslationLanguage =>
      _selectedTranslationLanguage;
  String get selectedLevel => _selectedLevel;
  List<LanguageModel> get languages => LanguageModel.supportedLanguages;
  List<TranslationLanguage> get translationLanguages =>
      TranslationLanguage.supportedLanguages;

  String get fullLanguageDisplay =>
      '${_selectedLanguage.flagEmoji} ${_selectedLanguage.name} (${_selectedLevel == 'Beginner' ? 'Beginner A1' : _selectedLevel})';

  Future<void> setLanguage(LanguageModel language) async {
    if (_selectedLanguage.id == language.id) {
      if (!await _storageService.setSelectedLanguage(language.id)) {
        throw StateError('Unable to persist the selected language.');
      }
      return;
    }
    final previous = _selectedLanguage;
    _selectedLanguage = language;
    notifyListeners();
    if (!await _storageService.setSelectedLanguage(language.id)) {
      _selectedLanguage = previous;
      notifyListeners();
      throw StateError('Unable to persist the selected language.');
    }
  }

  Future<void> setTranslationLanguage(
    TranslationLanguage language,
  ) async {
    if (_selectedTranslationLanguage.code == language.code) {
      if (!await _storageService
          .setSelectedTranslationLanguage(language.code)) {
        throw StateError('Unable to persist the translation language.');
      }
      return;
    }
    final previous = _selectedTranslationLanguage;
    _selectedTranslationLanguage = language;
    notifyListeners();
    if (!await _storageService.setSelectedTranslationLanguage(language.code)) {
      _selectedTranslationLanguage = previous;
      notifyListeners();
      throw StateError('Unable to persist the translation language.');
    }
  }

  Future<void> setLevel(String level) async {
    if (_selectedLevel == level) return;
    _selectedLevel = level;
    await _storageService.setSelectedLevel(level);
    notifyListeners();
  }
}
