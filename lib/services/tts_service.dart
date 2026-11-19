import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  TtsService._();

  static final TtsService instance = TtsService._();

  final FlutterTts _flutterTts = FlutterTts();

  static const Map<String, String> _languageCodes = {
    'es': 'es-ES',
    'fr': 'fr-FR',
    'de': 'de-DE',
    'ja': 'ja-JP',
    'en': 'en-US',
    'ar': 'ar-SA',
  };

  Future<void> speak(
    String text, {
    required String languageId,
  }) async {
    if (text.trim().isEmpty) return;

    final languageCode = _languageCodes[languageId];

    if (languageCode == null) {
      throw Exception('Unsupported language.');
    }

    await _flutterTts.stop();

    final isAvailable = await _flutterTts.isLanguageAvailable(languageCode);

    if (isAvailable != true) {
      throw Exception(
        'The voice for $languageCode is not installed on this device.',
      );
    }

    await _flutterTts.setLanguage(languageCode);
    await _flutterTts.setSpeechRate(0.45);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
