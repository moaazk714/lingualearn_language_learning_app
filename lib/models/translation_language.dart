class TranslationLanguage {
  final String code;
  final String name;
  final String nativeName;
  final bool isRightToLeft;

  const TranslationLanguage({
    required this.code,
    required this.name,
    required this.nativeName,
    this.isRightToLeft = false,
  });

  static const List<TranslationLanguage> supportedLanguages = [
    TranslationLanguage(code: 'en', name: 'English', nativeName: 'English'),
    TranslationLanguage(code: 'es', name: 'Spanish', nativeName: 'Español'),
    TranslationLanguage(code: 'fr', name: 'French', nativeName: 'Français'),
    TranslationLanguage(code: 'de', name: 'German', nativeName: 'Deutsch'),
    TranslationLanguage(code: 'ja', name: 'Japanese', nativeName: '日本語'),
    TranslationLanguage(
      code: 'ar',
      name: 'Arabic',
      nativeName: 'العربية',
      isRightToLeft: true,
    ),
    TranslationLanguage(
      code: 'ur',
      name: 'Urdu',
      nativeName: 'اردو',
      isRightToLeft: true,
    ),
  ];

  static TranslationLanguage? findByCode(String code) {
    for (final language in supportedLanguages) {
      if (language.code == code) return language;
    }
    return null;
  }
}
