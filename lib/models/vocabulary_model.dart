class VocabularyModel {
  final String id;
  final String languageCode;
  final String word;
  final String phonetic;

  // English and Urdu translations
  final String translation;
  final String urduTranslation;
  final Map<String, String> localizedMeanings;

  final String partOfSpeech;
  final String exampleSentence;
  final String exampleTranslation;
  final String exampleUrduTranslation;
  final String category;

  final bool isFavorite;
  final bool isLearned;

  const VocabularyModel({
    required this.id,
    required this.languageCode,
    required this.word,
    required this.phonetic,
    required this.translation,
    this.urduTranslation = '',
    this.localizedMeanings = const {},
    required this.partOfSpeech,
    required this.exampleSentence,
    required this.exampleTranslation,
    this.exampleUrduTranslation = '',
    required this.category,
    this.isFavorite = false,
    this.isLearned = false,
  });

  VocabularyModel copyWith({
    String? id,
    String? languageCode,
    String? word,
    String? phonetic,
    String? translation,
    String? urduTranslation,
    Map<String, String>? localizedMeanings,
    String? partOfSpeech,
    String? exampleSentence,
    String? exampleTranslation,
    String? exampleUrduTranslation,
    String? category,
    bool? isFavorite,
    bool? isLearned,
  }) {
    return VocabularyModel(
      id: id ?? this.id,
      languageCode: languageCode ?? this.languageCode,
      word: word ?? this.word,
      phonetic: phonetic ?? this.phonetic,
      translation: translation ?? this.translation,
      urduTranslation: urduTranslation ?? this.urduTranslation,
      localizedMeanings: localizedMeanings ?? this.localizedMeanings,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      exampleSentence: exampleSentence ?? this.exampleSentence,
      exampleTranslation: exampleTranslation ?? this.exampleTranslation,
      exampleUrduTranslation:
          exampleUrduTranslation ?? this.exampleUrduTranslation,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      isLearned: isLearned ?? this.isLearned,
    );
  }

  String meaningFor(String languageCode) {
    final localized = localizedMeanings[languageCode];
    if (localized != null && localized.trim().isNotEmpty) return localized;
    return switch (languageCode) {
      'en' => translation,
      'ur' => urduTranslation,
      _ => '',
    };
  }

  String exampleTranslationFor(String languageCode) {
    return switch (languageCode) {
      'en' => exampleTranslation,
      'ur' => exampleUrduTranslation,
      _ => '',
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'languageCode': languageCode,
      'word': word,
      'phonetic': phonetic,
      'translation': translation,
      'urduTranslation': urduTranslation,
      'localizedMeanings': localizedMeanings,
      'partOfSpeech': partOfSpeech,
      'exampleSentence': exampleSentence,
      'exampleTranslation': exampleTranslation,
      'exampleUrduTranslation': exampleUrduTranslation,
      'category': category,
      'isFavorite': isFavorite,
      'isLearned': isLearned,
    };
  }
}
