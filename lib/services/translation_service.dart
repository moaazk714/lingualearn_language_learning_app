import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/translation_language.dart';

class TranslationException implements Exception {
  final String message;

  const TranslationException(this.message);

  @override
  String toString() => message;
}

abstract class TranslationService {
  Future<String> translate({
    required String text,
    required String sourceLanguageCode,
    required String targetLanguageCode,
  });

  void close() {}
}

class MyMemoryTranslationService implements TranslationService {
  static const int _maxRequestBytes = 450;
  static const Duration _requestTimeout = Duration(seconds: 20);
  static final Set<String> _supportedCodes = TranslationLanguage
      .supportedLanguages
      .map((language) => language.code)
      .toSet();

  final http.Client _client;
  final Uri _endpoint;

  MyMemoryTranslationService({
    http.Client? client,
    Uri? endpoint,
  })  : _client = client ?? http.Client(),
        _endpoint =
            endpoint ?? Uri.https('api.mymemory.translated.net', '/get');

  @override
  Future<String> translate({
    required String text,
    required String sourceLanguageCode,
    required String targetLanguageCode,
  }) async {
    if (!_supportedCodes.contains(sourceLanguageCode) ||
        !_supportedCodes.contains(targetLanguageCode)) {
      throw const TranslationException(
        'One of the selected languages is not supported.',
      );
    }
    if (sourceLanguageCode == targetLanguageCode) {
      throw const TranslationException(
        'Choose two different languages to translate.',
      );
    }
    if (text.trim().isEmpty) {
      throw const TranslationException('Enter text to translate.');
    }

    final translated = StringBuffer();
    for (final segment in _splitText(text)) {
      if (segment.trim().isEmpty) {
        translated.write(segment);
        continue;
      }
      translated.write(
        await _translateSegment(
          segment,
          sourceLanguageCode,
          targetLanguageCode,
        ),
      );
    }

    final result = translated.toString();
    if (result.trim().isEmpty || result.trim() == text.trim()) {
      throw const TranslationException(
        'The translation service did not return a translated result. Please try again.',
      );
    }
    return result;
  }

  Future<String> _translateSegment(
    String text,
    String sourceLanguageCode,
    String targetLanguageCode,
  ) async {
    final uri = _endpoint.replace(
      queryParameters: {
        'q': text,
        'langpair': '$sourceLanguageCode|$targetLanguageCode',
        'mt': '1',
      },
    );

    late final http.Response response;
    try {
      response = await _client.get(uri).timeout(_requestTimeout);
    } on TimeoutException {
      throw const TranslationException(
        'The translation service timed out. Check your connection and retry.',
      );
    } on SocketException {
      throw const TranslationException(
        'Could not reach the translation service. Check your internet connection and retry.',
      );
    } on http.ClientException {
      throw const TranslationException(
        'Could not reach the translation service. Check your internet connection and retry.',
      );
    }

    if (response.statusCode == 429 || response.statusCode == 403) {
      throw const TranslationException(
        'The free translation limit may have been reached. Please try again later.',
      );
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw TranslationException(
        'The translation service returned an error (${response.statusCode}). Please retry.',
      );
    }

    final Object? decoded;
    try {
      decoded = jsonDecode(utf8.decode(response.bodyBytes));
    } on FormatException {
      throw const TranslationException(
        'The translation service returned an unreadable response. Please retry.',
      );
    }
    if (decoded is! Map<String, dynamic>) {
      throw const TranslationException(
        'The translation service returned an unexpected response. Please retry.',
      );
    }

    final status = int.tryParse('${decoded['responseStatus']}');
    if (status != 200) {
      final details = decoded['responseDetails'];
      if (status == 403 || status == 429) {
        throw const TranslationException(
          'The free translation limit may have been reached. Please try again later.',
        );
      }
      throw TranslationException(
        details is String && details.isNotEmpty
            ? 'Translation unavailable: $details'
            : 'The translation service could not translate this text. Please retry.',
      );
    }

    final data = decoded['responseData'];
    final result = data is Map<String, dynamic> ? data['translatedText'] : null;
    if (result is! String || result.trim().isEmpty) {
      throw const TranslationException(
        'The translation service returned no translated text. Please retry.',
      );
    }
    return _decodeCommonEntities(result);
  }

  List<String> _splitText(String text) {
    final sentences = text.split(RegExp(r'(?<=[.!?。！？\n])'));
    final chunks = <String>[];
    var pending = StringBuffer();
    var pendingBytes = 0;

    void flushPending() {
      if (pendingBytes == 0) return;
      chunks.add(pending.toString());
      pending = StringBuffer();
      pendingBytes = 0;
    }

    for (final sentence in sentences) {
      final sentenceBytes = utf8.encode(sentence).length;
      if (sentenceBytes > _maxRequestBytes) {
        flushPending();
        var oversized = StringBuffer();
        var oversizedBytes = 0;
        for (final rune in sentence.runes) {
          final character = String.fromCharCode(rune);
          final characterBytes = utf8.encode(character).length;
          if (oversizedBytes + characterBytes > _maxRequestBytes) {
            chunks.add(oversized.toString());
            oversized = StringBuffer();
            oversizedBytes = 0;
          }
          oversized.write(character);
          oversizedBytes += characterBytes;
        }
        if (oversizedBytes > 0) chunks.add(oversized.toString());
      } else if (pendingBytes + sentenceBytes <= _maxRequestBytes) {
        pending.write(sentence);
        pendingBytes += sentenceBytes;
      } else {
        flushPending();
        pending.write(sentence);
        pendingBytes = sentenceBytes;
      }
    }
    flushPending();
    return chunks;
  }

  String _decodeCommonEntities(String value) => value
      .replaceAll('&amp;', '&')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>');

  @override
  void close() => _client.close();
}
