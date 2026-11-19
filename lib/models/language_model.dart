class LanguageModel {
  final String id;
  final String name;
  final String nativeName;
  final String flagEmoji;
  final String learnersCount;
  final bool isPopular;

  const LanguageModel({
    required this.id,
    required this.name,
    required this.nativeName,
    required this.flagEmoji,
    required this.learnersCount,
    this.isPopular = false,
  });

  static const List<LanguageModel> supportedLanguages = [
    LanguageModel(
      id: 'es',
      name: 'Spanish',
      nativeName: 'Español',
      flagEmoji: '🇪🇸',
      learnersCount: '2.4M learners',
      isPopular: true,
    ),
    LanguageModel(
      id: 'fr',
      name: 'French',
      nativeName: 'Français',
      flagEmoji: '🇫🇷',
      learnersCount: '1.8M learners',
    ),
    LanguageModel(
      id: 'de',
      name: 'German',
      nativeName: 'Deutsch',
      flagEmoji: '🇩🇪',
      learnersCount: '940k learners',
    ),
    LanguageModel(
      id: 'ja',
      name: 'Japanese',
      nativeName: '日本語',
      flagEmoji: '🇯🇵',
      learnersCount: '1.2M learners',
    ),
    LanguageModel(
      id: 'en',
      name: 'English',
      nativeName: 'UK/US',
      flagEmoji: '🇬🇧',
      learnersCount: '3.1M learners',
    ),
    LanguageModel(
      id: 'ar',
      name: 'Arabic',
      nativeName: 'العربية',
      flagEmoji: '🇦🇪',
      learnersCount: '780k learners',
    ),
  ];
}
