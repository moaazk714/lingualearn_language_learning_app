import '../../models/course_model.dart';
import '../../models/lesson_model.dart';
import '../../models/quiz_model.dart';
import '../../models/vocabulary_model.dart';
import '../../models/user_progress_model.dart';
import 'vocabulary_catalog.dart';

class AppMockData {
  AppMockData._();

  // Spanish Vocabulary
  static const List<VocabularyModel> _spanishVocabularyBase = [
    VocabularyModel(
      id: 'es_vocab_1',
      languageCode: 'es',
      word: 'El Desayuno',
      phonetic: '/el desaˈʝuno/',
      translation: 'The Breakfast',
      urduTranslation: 'ناشتہ',
      partOfSpeech: 'noun, m',
      exampleSentence: 'Siempre tomo café con leche durante el desayuno.',
      exampleTranslation: 'I always drink coffee with milk during breakfast.',
      exampleUrduTranslation: 'میں ناشتے میں ہمیشہ دودھ والی کافی پیتا ہوں۔',
      category: 'Food & Dining',
      isFavorite: true,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'es_vocab_2',
      languageCode: 'es',
      word: 'Hola',
      phonetic: '/ˈola/',
      translation: 'Hello / Hi',
      urduTranslation: 'سلام',
      partOfSpeech: 'interjection',
      exampleSentence: '¡Hola! ¿Cómo estás hoy?',
      exampleTranslation: 'Hello! How are you today?',
      exampleUrduTranslation: 'سلام! آج آپ کیسے ہیں؟',
      category: 'Greetings',
      isFavorite: false,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'es_vocab_3',
      languageCode: 'es',
      word: 'Por favor',
      phonetic: '/poɾ faˈβoɾ/',
      translation: 'Please',
      urduTranslation: 'براہ کرم',
      partOfSpeech: 'phrase',
      exampleSentence: 'Un café solo, por favor.',
      exampleTranslation: 'A black coffee, please.',
      exampleUrduTranslation: 'ایک سادہ کافی، براہ کرم۔',
      category: 'Food & Dining',
      isFavorite: true,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'es_vocab_4',
      languageCode: 'es',
      word: 'Gracias',
      phonetic: '/ˈɡɾasjas/',
      translation: 'Thank you',
      urduTranslation: 'شکریہ',
      partOfSpeech: 'interjection',
      exampleSentence: 'Muchas gracias por tu ayuda.',
      exampleTranslation: 'Thank you very much for your help.',
      exampleUrduTranslation: 'آپ کی مدد کے لیے بہت شکریہ۔',
      category: 'Greetings',
      isFavorite: false,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'es_vocab_5',
      languageCode: 'es',
      word: 'La Cuenta',
      phonetic: '/la ˈkwenta/',
      translation: 'The Bill / Check',
      urduTranslation: 'بل',
      partOfSpeech: 'noun, f',
      exampleSentence: '¿Nos trae la cuenta, por favor?',
      exampleTranslation: 'Could you bring us the bill, please?',
      exampleUrduTranslation: 'کیا آپ ہمارے لیے بل لا سکتے ہیں، براہ کرم؟',
      category: 'Food & Dining',
      isFavorite: false,
      isLearned: false,
    ),
    VocabularyModel(
      id: 'es_vocab_6',
      languageCode: 'es',
      word: 'Buenos Días',
      phonetic: '/ˈbwenos ˈdias/',
      translation: 'Good Morning',
      urduTranslation: 'صبح بخیر',
      partOfSpeech: 'phrase',
      exampleSentence: '¡Buenos días! ¿Qué desea tomar?',
      exampleTranslation: 'Good morning! What would you like to drink?',
      exampleUrduTranslation: 'صبح بخیر! آپ کیا پینا پسند کریں گے؟',
      category: 'Greetings',
      isFavorite: true,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'es_vocab_7',
      languageCode: 'es',
      word: '¿Dónde está...?',
      phonetic: '/ˈdonde esˈta/',
      translation: 'Where is...?',
      urduTranslation: 'کہاں ہے؟',
      partOfSpeech: 'phrase',
      exampleSentence: '¿Dónde está la estación de metro?',
      exampleTranslation: 'Where is the subway station?',
      exampleUrduTranslation: 'میٹرو اسٹیشن کہاں ہے؟',
      category: 'Travel',
      isFavorite: true,
      isLearned: false,
    ),
    VocabularyModel(
      id: 'es_vocab_8',
      languageCode: 'es',
      word: 'El Agua',
      phonetic: '/el ˈaɡwa/',
      translation: 'The Water',
      urduTranslation: 'پانی',
      partOfSpeech: 'noun, f',
      exampleSentence: 'Quisiera un vaso de agua mineral.',
      exampleTranslation: 'I would like a glass of mineral water.',
      exampleUrduTranslation: 'مجھے معدنی پانی کا ایک گلاس چاہیے۔',
      category: 'Food & Dining',
      isFavorite: false,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'es_vocab_9',
      languageCode: 'es',
      word: 'Mucho Gusto',
      phonetic: '/ˈmutʃo ˈɡusto/',
      translation: 'Nice to meet you',
      urduTranslation: 'آپ سے مل کر خوشی ہوئی',
      partOfSpeech: 'phrase',
      exampleSentence: 'Me llamo Sofia. ¡Mucho gusto!',
      exampleTranslation: 'My name is Sofia. Nice to meet you!',
      exampleUrduTranslation: 'میرا نام صوفیہ ہے۔ آپ سے مل کر خوشی ہوئی!',
      category: 'Greetings',
      isFavorite: false,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'es_vocab_10',
      languageCode: 'es',
      word: 'El Billete',
      phonetic: '/el biˈʝete/',
      translation: 'The Ticket',
      urduTranslation: 'ٹکٹ',
      partOfSpeech: 'noun, m',
      exampleSentence: 'Necesito comprar dos billetes de tren.',
      exampleTranslation: 'I need to buy two train tickets.',
      exampleUrduTranslation: 'مجھے ٹرین کے دو ٹکٹ خریدنے ہیں۔',
      category: 'Travel',
      isFavorite: false,
      isLearned: false,
    ),
    VocabularyModel(
      id: 'es_vocab_11',
      languageCode: 'es',
      word: 'Uno, Dos, Tres',
      phonetic: '/ˈuno dos tɾes/',
      translation: 'One, Two, Three',
      urduTranslation: 'ایک، دو، تین',
      partOfSpeech: 'number',
      exampleSentence: 'Tengo uno, dos, tres hermanos.',
      exampleTranslation: 'I have one, two, three brothers.',
      exampleUrduTranslation: 'میرے ایک، دو، تین بھائی ہیں۔',
      category: 'Numbers',
      isFavorite: false,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'es_vocab_12',
      languageCode: 'es',
      word: '¿Cuánto cuesta?',
      phonetic: '/ˈkwanto ˈkwesta/',
      translation: 'How much does it cost?',
      urduTranslation: 'اس کی قیمت کتنی ہے؟',
      partOfSpeech: 'phrase',
      exampleSentence: 'Disculpe, ¿cuánto cuesta este libro?',
      exampleTranslation: 'Excuse me, how much does this book cost?',
      exampleUrduTranslation: 'معاف کیجیے، اس کتاب کی قیمت کتنی ہے؟',
      category: 'Travel',
      isFavorite: true,
      isLearned: false,
    ),
  ];

  static final List<VocabularyModel> spanishVocabulary = [
    ..._withoutSampleLearningProgress(_spanishVocabularyBase),
    ...VocabularyCatalog.forLanguage('es', _spanishVocabularyBase.length),
  ];

  // French Vocabulary
  static const List<VocabularyModel> _frenchVocabularyBase = [
    VocabularyModel(
      id: 'fr_vocab_1',
      languageCode: 'fr',
      word: 'Le Petit-déjeuner',
      phonetic: '/lə pəti deʒœne/',
      translation: 'The Breakfast',
      urduTranslation: 'ناشتہ',
      partOfSpeech: 'noun, m',
      exampleSentence: 'Je prends un croissant pour le petit-déjeuner.',
      exampleTranslation: 'I take a croissant for breakfast.',
      exampleUrduTranslation: 'میں ناشتے میں ایک کروسون کھاتا ہوں۔',
      category: 'Food & Dining',
      isFavorite: true,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'fr_vocab_2',
      languageCode: 'fr',
      word: 'Bonjour',
      phonetic: '/bɔ̃ʒuʁ/',
      translation: 'Hello / Good morning',
      urduTranslation: 'سلام / صبح بخیر',
      partOfSpeech: 'interjection',
      exampleSentence: 'Bonjour, comment allez-vous?',
      exampleTranslation: 'Good morning, how are you?',
      exampleUrduTranslation: 'صبح بخیر، آپ کیسے ہیں؟',
      category: 'Greetings',
      isFavorite: false,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'fr_vocab_3',
      languageCode: 'fr',
      word: 'S\'il vous plaît',
      phonetic: '/sil vu plɛ/',
      translation: 'Please (formal)',
      urduTranslation: 'براہ کرم',
      partOfSpeech: 'phrase',
      exampleSentence: 'L\'addition, s\'il vous plaît.',
      exampleTranslation: 'The check, please.',
      exampleUrduTranslation: 'بل، براہ کرم۔',
      category: 'Food & Dining',
      isFavorite: true,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'fr_vocab_4',
      languageCode: 'fr',
      word: 'Merci beaucoup',
      phonetic: '/mɛʁsi boku/',
      translation: 'Thank you very much',
      urduTranslation: 'بہت شکریہ',
      partOfSpeech: 'interjection',
      exampleSentence: 'Merci beaucoup pour votre hospitalité.',
      exampleTranslation: 'Thank you very much for your hospitality.',
      exampleUrduTranslation: 'آپ کی مہمان نوازی کے لیے بہت شکریہ۔',
      category: 'Greetings',
      isFavorite: false,
      isLearned: true,
    ),
  ];

  static final List<VocabularyModel> frenchVocabulary = [
    ..._withoutSampleLearningProgress(_frenchVocabularyBase),
    ...VocabularyCatalog.forLanguage('fr', _frenchVocabularyBase.length),
  ];

  // German Vocabulary
  static const List<VocabularyModel> _germanVocabularyBase = [
    VocabularyModel(
      id: 'de_vocab_1',
      languageCode: 'de',
      word: 'Das Frühstück',
      phonetic: '/das ˈfʁyːˌʃtʏk/',
      translation: 'The Breakfast',
      urduTranslation: 'ناشتہ',
      partOfSpeech: 'noun, n',
      exampleSentence: 'Das Frühstück ist die wichtigste Mahlzeit.',
      exampleTranslation: 'Breakfast is the most important meal.',
      exampleUrduTranslation: 'ناشتہ سب سے اہم کھانا ہے۔',
      category: 'Food & Dining',
      isFavorite: true,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'de_vocab_2',
      languageCode: 'de',
      word: 'Guten Morgen',
      phonetic: '/ˈɡuːtn̩ ˈmɔʁɡn̩/',
      translation: 'Good Morning',
      urduTranslation: 'صبح بخیر',
      partOfSpeech: 'phrase',
      exampleSentence: 'Guten Morgen! Wie geht es Ihnen?',
      exampleTranslation: 'Good morning! How are you?',
      exampleUrduTranslation: 'صبح بخیر! آپ کیسے ہیں؟',
      category: 'Greetings',
      isFavorite: false,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'de_vocab_3',
      languageCode: 'de',
      word: 'Bitte',
      phonetic: '/ˈbɪtə/',
      translation: 'Please / You\'re welcome',
      urduTranslation: 'براہ کرم / کوئی بات نہیں',
      partOfSpeech: 'interjection',
      exampleSentence: 'Ein Glas Wasser, bitte.',
      exampleTranslation: 'A glass of water, please.',
      exampleUrduTranslation: 'ایک گلاس پانی، براہ کرم۔',
      category: 'Food & Dining',
      isFavorite: true,
      isLearned: true,
    ),
  ];

  static final List<VocabularyModel> germanVocabulary = [
    ..._withoutSampleLearningProgress(_germanVocabularyBase),
    ...VocabularyCatalog.forLanguage('de', _germanVocabularyBase.length),
  ];

  // Japanese Vocabulary
  static const List<VocabularyModel> _japaneseVocabularyBase = [
    VocabularyModel(
      id: 'ja_vocab_1',
      languageCode: 'ja',
      word: '朝食 (Chōshoku)',
      phonetic: 'chōshoku',
      translation: 'Breakfast',
      urduTranslation: 'ناشتہ',
      partOfSpeech: 'noun',
      exampleSentence: '毎朝、和食の朝食を食べます。',
      exampleTranslation: 'Every morning, I eat a Japanese-style breakfast.',
      exampleUrduTranslation: 'میں ہر صبح جاپانی طرز کا ناشتہ کھاتا ہوں۔',
      category: 'Food & Dining',
      isFavorite: true,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'ja_vocab_2',
      languageCode: 'ja',
      word: 'おはようございます',
      phonetic: 'ohayō gozaimasu',
      translation: 'Good morning (polite)',
      urduTranslation: 'صبح بخیر (باادب)',
      partOfSpeech: 'phrase',
      exampleSentence: '先生、おはようございます。',
      exampleTranslation: 'Teacher, good morning.',
      exampleUrduTranslation: 'استاد محترم، صبح بخیر۔',
      category: 'Greetings',
      isFavorite: true,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'ja_vocab_3',
      languageCode: 'ja',
      word: 'ありがとうございます',
      phonetic: 'arigatō gozaimasu',
      translation: 'Thank you very much',
      urduTranslation: 'بہت شکریہ',
      partOfSpeech: 'phrase',
      exampleSentence: 'ご親切にありがとうございます。',
      exampleTranslation: 'Thank you very much for your kindness.',
      exampleUrduTranslation: 'آپ کی مہربانی کے لیے بہت شکریہ۔',
      category: 'Greetings',
      isFavorite: false,
      isLearned: true,
    ),
  ];

  static final List<VocabularyModel> japaneseVocabulary = [
    ..._withoutSampleLearningProgress(_japaneseVocabularyBase),
    ...VocabularyCatalog.forLanguage('ja', _japaneseVocabularyBase.length),
  ];

  // English Vocabulary
  static const List<VocabularyModel> _englishVocabularyBase = [
    VocabularyModel(
      id: 'en_vocab_1',
      languageCode: 'en',
      word: 'Breakfast',
      phonetic: '/ˈbrɛkfəst/',
      translation: 'The morning meal',
      urduTranslation: 'ناشتہ',
      partOfSpeech: 'noun',
      exampleSentence: 'I always have scrambled eggs for breakfast.',
      exampleTranslation: 'I always have scrambled eggs for breakfast.',
      exampleUrduTranslation:
          'میں ناشتے میں ہمیشہ بھُرْجی والے انڈے کھاتا ہوں۔',
      category: 'Food & Dining',
      isFavorite: true,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'en_vocab_2',
      languageCode: 'en',
      word: 'Good Morning',
      phonetic: '/ɡʊd ˈmɔːrnɪŋ/',
      translation: 'Greeting used in the morning',
      urduTranslation: 'صبح کے وقت کہا جانے والا سلام',
      partOfSpeech: 'phrase',
      exampleSentence: 'Good morning! It is a beautiful sunny day.',
      exampleTranslation: 'Good morning! It is a beautiful sunny day.',
      exampleUrduTranslation: 'صبح بخیر! آج دھوپ والا خوبصورت دن ہے۔',
      category: 'Greetings',
      isFavorite: false,
      isLearned: true,
    ),
  ];

  static final List<VocabularyModel> englishVocabulary = [
    ..._withoutSampleLearningProgress(_englishVocabularyBase),
    ...VocabularyCatalog.forLanguage('en', _englishVocabularyBase.length),
  ];

  // Arabic Vocabulary
  static const List<VocabularyModel> _arabicVocabularyBase = [
    VocabularyModel(
      id: 'ar_vocab_1',
      languageCode: 'ar',
      word: 'الفطور (Al-Futur)',
      phonetic: 'al-fuṭūr',
      translation: 'The Breakfast',
      urduTranslation: 'ناشتہ',
      partOfSpeech: 'noun, m',
      exampleSentence: 'أتناول الفطور مع عائلتي كل صباح.',
      exampleTranslation: 'I eat breakfast with my family every morning.',
      exampleUrduTranslation: 'میں ہر صبح اپنے خاندان کے ساتھ ناشتہ کرتا ہوں۔',
      category: 'Food & Dining',
      isFavorite: true,
      isLearned: true,
    ),
    VocabularyModel(
      id: 'ar_vocab_2',
      languageCode: 'ar',
      word: 'صباح الخير (Sabah Al-Khair)',
      phonetic: 'ṣabāḥ al-khayr',
      translation: 'Good Morning',
      urduTranslation: 'صبح بخیر',
      partOfSpeech: 'phrase',
      exampleSentence: 'صباح الخير يا صديقي العزيز.',
      exampleTranslation: 'Good morning, my dear friend.',
      exampleUrduTranslation: 'صبح بخیر، میرے عزیز دوست۔',
      category: 'Greetings',
      isFavorite: true,
      isLearned: true,
    ),
  ];

  static final List<VocabularyModel> arabicVocabulary = [
    ..._withoutSampleLearningProgress(_arabicVocabularyBase),
    ...VocabularyCatalog.forLanguage('ar', _arabicVocabularyBase.length),
  ];

  static List<VocabularyModel> vocabularyForLanguage(String languageCode) {
    return switch (languageCode) {
      'es' => spanishVocabulary,
      'fr' => frenchVocabulary,
      'de' => germanVocabulary,
      'ja' => japaneseVocabulary,
      'en' => englishVocabulary,
      'ar' => arabicVocabulary,
      _ => const [],
    };
  }

  static CourseModel getCourseForLanguage(String languageCode, String level) {
    if (languageCode == 'es') return getSpanishCourse(level);

    final words = vocabularyForLanguage(languageCode);
    if (words.isEmpty) {
      throw ArgumentError.value(languageCode, 'languageCode');
    }

    const languageNames = {
      'en': 'English',
      'fr': 'French',
      'de': 'German',
      'ja': 'Japanese',
      'ar': 'Arabic',
    };
    const categoryOrder = [
      'Greetings',
      'Food & Dining',
      'Travel',
      'Numbers',
      'Family',
      'Home',
      'Education',
      'Animals',
      'Weather',
      'Shopping',
      'Work',
      'Daily Activities',
      'Health',
      'Nature',
      'Technology',
    ];
    final categories = categoryOrder
        .where((category) => words.any((word) => word.category == category))
        .toList();
    final languageName = languageNames[languageCode] ?? languageCode;
    final units = <UnitModel>[];

    for (var unitIndex = 0; unitIndex * 3 < categories.length; unitIndex++) {
      final unitId = '${languageCode}_u${unitIndex + 1}';
      final unitCategories = categories.skip(unitIndex * 3).take(3).toList();
      final lessons = <LessonModel>[];
      for (var categoryIndex = 0;
          categoryIndex < unitCategories.length;
          categoryIndex++) {
        final category = unitCategories[categoryIndex];
        final lessonNumber = unitIndex * 3 + categoryIndex + 1;
        final lessonWords =
            words.where((word) => word.category == category).toList();
        lessons.add(
          LessonModel(
            id: '${languageCode}_u${unitIndex + 1}_l${categoryIndex + 1}',
            unitId: unitId,
            lessonNumber: lessonNumber,
            title: category,
            description:
                'Learn useful $category words and phrases in $languageName.',
            durationMinutes: 5,
            objectives: [
              'Recognize and practice ${lessonWords.length} $category words.',
              'Use the new words in everyday situations.',
            ],
            vocabularyIds: lessonWords.map((word) => word.id).toList(),
            quizId: 'quiz_es_${((lessonNumber - 1) % 3) + 1}',
          ),
        );
      }
      units.add(
        UnitModel(
          id: unitId,
          courseId: 'course_${languageCode}_$level',
          unitNumber: unitIndex + 1,
          title: 'Unit ${unitIndex + 1}: ${unitCategories.first}',
          description: 'Build vocabulary across ${unitCategories.join(', ')}.',
          lessons: lessons,
        ),
      );
    }

    return CourseModel(
      id: 'course_${languageCode}_$level',
      languageCode: languageCode,
      level: level,
      title: 'Complete $languageName Foundations ($level)',
      description:
          'Build practical $languageName vocabulary through everyday topics.',
      units: units,
    );
  }

  // Courses & Lessons for Spanish (Matching Stitch AI UI)
  static List<VocabularyModel> _withoutSampleLearningProgress(
    List<VocabularyModel> words,
  ) {
    return words.map((word) => word.copyWith(isLearned: false)).toList();
  }

  static CourseModel getSpanishCourse(String level) {
    return CourseModel(
      id: 'course_es_$level',
      languageCode: 'es',
      level: level,
      title: 'Complete Spanish Immersion ($level)',
      description:
          'Master conversational fluency through natural sentence structures.',
      units: [
        UnitModel(
          id: 'es_u1',
          courseId: 'course_es_$level',
          unitNumber: 1,
          title: 'Unit 1: Essential Foundations',
          description: 'Basic sounds, letters, and everyday greetings.',
          lessons: [
            LessonModel(
              id: 'es_u1_l1',
              unitId: 'es_u1',
              lessonNumber: 1,
              title: 'Basic Greetings',
              description:
                  'Learn how to say hello, goodbye, and introduce your name.',
              durationMinutes: 4,
              objectives: [
                'Greet others politely in informal and formal settings',
                'Introduce your name and ask someone else\'s name',
                'Say goodbye using common idioms'
              ],
              vocabularyIds: [
                'es_vocab_2',
                'es_vocab_4',
                'es_vocab_6',
                'es_vocab_9'
              ],
              quizId: 'quiz_es_1',
              isCompleted: true,
              isLocked: false,
            ),
            LessonModel(
              id: 'es_u1_l2',
              unitId: 'es_u1',
              lessonNumber: 2,
              title: 'Introducing Yourself',
              description:
                  'Share your profession, where you are from, and your hobbies.',
              durationMinutes: 5,
              objectives: [
                'State your nationality and native country',
                'Express your age and occupation',
                'Use the verbs "Ser" and "Estar" accurately'
              ],
              vocabularyIds: ['es_vocab_2', 'es_vocab_9'],
              quizId: 'quiz_es_2',
              isCompleted: true,
              isLocked: false,
            ),
            LessonModel(
              id: 'es_u1_l3',
              unitId: 'es_u1',
              lessonNumber: 3,
              title: 'Numbers and Counting (1-20)',
              description:
                  'Count objects, exchange phone numbers, and tell the time.',
              durationMinutes: 4,
              objectives: [
                'Count fluently from 1 to 20',
                'Say and understand prices and telephone numbers',
                'Ask "How much?" using "¿Cuánto?"'
              ],
              vocabularyIds: ['es_vocab_11', 'es_vocab_12'],
              quizId: 'quiz_es_3',
              isCompleted: true,
              isLocked: false,
            ),
          ],
        ),
        UnitModel(
          id: 'es_u2',
          courseId: 'course_es_$level',
          unitNumber: 2,
          title:
              'Unit 2: Ordering at a Café', // Exact match to Stitch AI screenshot!
          description: 'Food, beverages, polite ordering, and paying the bill.',
          lessons: [
            LessonModel(
              id: 'es_u2_l1',
              unitId: 'es_u2',
              lessonNumber: 1,
              title: 'Morning Breakfast & Coffee',
              description:
                  'Order breakfast specialties, coffee with milk, and toast.',
              durationMinutes: 4,
              objectives: [
                'Name common breakfast food items in Spanish',
                'Order coffee with different types of milk and sugar',
                'Ask for the table or chair politely'
              ],
              vocabularyIds: ['es_vocab_1', 'es_vocab_3', 'es_vocab_8'],
              quizId: 'quiz_es_1',
              isCompleted: true,
              isLocked: false,
            ),
            LessonModel(
              id: 'es_u2_l2',
              unitId: 'es_u2',
              lessonNumber: 2,
              title: 'Reading the Café Menu',
              description:
                  'Identify beverages, tapas, desserts, and daily specials.',
              durationMinutes: 5,
              objectives: [
                'Read appetizers and dessert sections effortlessly',
                'Inquire about dietary restrictions and allergies',
                'Choose items using demonstratives "este" and "ese"'
              ],
              vocabularyIds: ['es_vocab_3', 'es_vocab_5'],
              quizId: 'quiz_es_2',
              isCompleted: true,
              isLocked: false,
            ),
            LessonModel(
              id: 'es_u2_l3',
              unitId: 'es_u2',
              lessonNumber: 3,
              title: 'Polite Requests & Questions',
              description:
                  'Use "quisiera", "por favor", and courteous phrasing.',
              durationMinutes: 4,
              objectives: [
                'Express desire politely with subjunctive / conditional verbs',
                'Clarify order details with café staff',
                'Ask for an extra napkin, fork, or cup'
              ],
              vocabularyIds: ['es_vocab_3', 'es_vocab_4'],
              quizId: 'quiz_es_3',
              isCompleted: true,
              isLocked: false,
            ),
            LessonModel(
              id: 'es_u2_l4',
              unitId: 'es_u2',
              lessonNumber: 4,
              title:
                  'Basic Greetings', // Exact match to Stitch AI screenshot (Lesson 4 of 8 • Basic Greetings)!
              description:
                  'Master warm conversational openings with café owners.',
              durationMinutes: 4,
              objectives: [
                'Engage in authentic small talk with baristas',
                'Comment politely on weather and morning vibes',
                'Practice fast colloquial responses'
              ],
              vocabularyIds: ['es_vocab_1', 'es_vocab_2', 'es_vocab_6'],
              quizId: 'quiz_es_1',
              isCompleted: true,
              isLocked: false,
            ),
            LessonModel(
              id: 'es_u2_l5',
              unitId: 'es_u2',
              lessonNumber: 5,
              title: 'Paying the Check & Tipping',
              description:
                  'Ask for the bill, split checks, and understand payment options.',
              durationMinutes: 5,
              objectives: [
                'Request the bill using "La cuenta, por favor"',
                'Pay with cash or contactless card',
                'Understand local Spanish tipping customs'
              ],
              vocabularyIds: ['es_vocab_5', 'es_vocab_12'],
              quizId: 'quiz_es_2',
              isCompleted: false, // In progress!
              isLocked: false,
            ),
            LessonModel(
              id: 'es_u2_l6',
              unitId: 'es_u2',
              lessonNumber: 6,
              title: 'Tapas & Small Bites',
              description:
                  'Order patatas bravas, jamón, and traditional pinchos.',
              durationMinutes: 4,
              objectives: [
                'Explore regional Spanish tapas culture',
                'Share dishes family-style among companions',
                'State food preferences and compliments'
              ],
              vocabularyIds: ['es_vocab_1', 'es_vocab_8'],
              quizId: 'quiz_es_3',
              isCompleted: false,
              isLocked: false,
            ),
            LessonModel(
              id: 'es_u2_l7',
              unitId: 'es_u2',
              lessonNumber: 7,
              title: 'Dietary Preferences',
              description:
                  'Explain vegetarian, gluten-free, and vegan requests.',
              durationMinutes: 5,
              objectives: [
                'Explain personal culinary preferences clearly',
                'Ask if ingredients contain dairy or seafood',
                'Receive customized orders with confidence'
              ],
              vocabularyIds: ['es_vocab_8', 'es_vocab_3'],
              quizId: 'quiz_es_1',
              isCompleted: false,
              isLocked: true,
            ),
            LessonModel(
              id: 'es_u2_l8',
              unitId: 'es_u2',
              lessonNumber: 8,
              title: 'Review & Real-Life Café Dialogue',
              description:
                  'Put everything together in a comprehensive cafe simulation.',
              durationMinutes: 6,
              objectives: [
                'Complete an entire ordering simulation from entrance to exit',
                'Resolve a simple mix-up in an order',
                'Earn the Unit 2 Barista Master badge'
              ],
              vocabularyIds: [
                'es_vocab_1',
                'es_vocab_3',
                'es_vocab_5',
                'es_vocab_6'
              ],
              quizId: 'quiz_es_2',
              isCompleted: false,
              isLocked: true,
            ),
          ],
        ),
        UnitModel(
          id: 'es_u3',
          courseId: 'course_es_$level',
          unitNumber: 3,
          title: 'Unit 3: Travel and Directions',
          description:
              'Navigating city streets, metro, trains, and asking directions.',
          lessons: [
            LessonModel(
              id: 'es_u3_l1',
              unitId: 'es_u3',
              lessonNumber: 1,
              title: 'Asking for Directions',
              description:
                  'Ask where places are and understand left, right, and straight.',
              durationMinutes: 5,
              objectives: [
                'Ask "¿Dónde está...?" with accurate inflection',
                'Understand "a la izquierda", "a la derecha", and "todo recto"',
                'Identify landmarks like squares, bridges, and cathedrals'
              ],
              vocabularyIds: ['es_vocab_7', 'es_vocab_10'],
              quizId: 'quiz_es_3',
              isCompleted: false,
              isLocked: true,
            ),
            LessonModel(
              id: 'es_u3_l2',
              unitId: 'es_u3',
              lessonNumber: 2,
              title: 'At the Train Station',
              description:
                  'Buy tickets, find your platform, and check departure schedules.',
              durationMinutes: 5,
              objectives: [
                'Purchase round-trip and one-way tickets',
                'Locate platform numbers and departure boards',
                'Understand delay announcements'
              ],
              vocabularyIds: ['es_vocab_10', 'es_vocab_12'],
              quizId: 'quiz_es_1',
              isCompleted: false,
              isLocked: true,
            ),
          ],
        ),
      ],
    );
  }

  // Quizzes
  static const List<QuizModel> allQuizzes = [
    QuizModel(
      id: 'quiz_es_1',
      title: 'Greetings & Café Essentials',
      description:
          'Test your vocabulary on everyday Spanish café phrases and greetings.',
      questions: [
        QuizQuestionModel(
          id: 'q1',
          questionText:
              'What is the correct Spanish translation for "The Breakfast"?',
          options: [
            'El Desayuno',
            'La Cena',
            'El Almuerzo',
            'La Merienda',
          ],
          correctIndex: 0,
          explanation:
              '"El Desayuno" means breakfast in Spanish. "El Almuerzo" is lunch and "La Cena" is dinner.',
        ),
        QuizQuestionModel(
          id: 'q2',
          questionText: 'How do you say "Please" politely in Spanish?',
          options: [
            'De nada',
            'Por favor',
            'Muchas gracias',
            'Con permiso',
          ],
          correctIndex: 1,
          explanation:
              '"Por favor" means please. "De nada" means you are welcome.',
        ),
        QuizQuestionModel(
          id: 'q3',
          questionText: 'Which phrase means "Good Morning"?',
          options: [
            'Buenas tardes',
            'Buenas noches',
            'Buenos días',
            'Hasta luego',
          ],
          correctIndex: 2,
          explanation: '"Buenos días" is used in the morning until midday.',
        ),
        QuizQuestionModel(
          id: 'q4',
          questionText: 'When asking for the check at a restaurant, you say:',
          options: [
            '¿Dónde está el baño?',
            'La cuenta, por favor',
            'Mucho gusto',
            'Un billete, por favor',
          ],
          correctIndex: 1,
          explanation:
              '"La cuenta, por favor" translates to "The bill / check, please".',
        ),
        QuizQuestionModel(
          id: 'q5',
          questionText: 'What does "El Agua" mean in English?',
          options: [
            'The Coffee',
            'The Milk',
            'The Bread',
            'The Water',
          ],
          correctIndex: 3,
          explanation:
              '"El Agua" means The Water. Note that even though water is feminine (el agua fresca), it takes "el" in the singular to prevent hiatus.',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_es_2',
      title: 'Introducing Yourself & Common Conversations',
      description: 'Verify your conversational and polite introduction skills.',
      questions: [
        QuizQuestionModel(
          id: 'q2_1',
          questionText:
              'What is the customary reply after someone says "Mucho gusto"?',
          options: [
            'Por favor',
            'Igualmente (Likewise)',
            'No entiendo',
            'Buenas noches',
          ],
          correctIndex: 1,
          explanation:
              '"Igualmente" means "Likewise" or "Same to you", a standard polite response to "Mucho gusto".',
        ),
        QuizQuestionModel(
          id: 'q2_2',
          questionText: 'Which of the following means "How much does it cost?"',
          options: [
            '¿A qué hora?',
            '¿Cómo te llamas?',
            '¿Cuánto cuesta?',
            '¿De dónde eres?',
          ],
          correctIndex: 2,
          explanation:
              '"¿Cuánto cuesta?" is used to inquire about the price of an item.',
        ),
        QuizQuestionModel(
          id: 'q2_3',
          questionText: 'How would you say "Thank you very much"?',
          options: [
            'Por supuesto',
            'Muchas gracias',
            'Lo siento',
            'Hasta pronto',
          ],
          correctIndex: 1,
          explanation: '"Muchas gracias" means "Thank you very much".',
        ),
      ],
    ),
    QuizModel(
      id: 'quiz_es_3',
      title: 'Travel, Numbers & Directions',
      description:
          'Test your understanding of directional phrases and numbers.',
      questions: [
        QuizQuestionModel(
          id: 'q3_1',
          questionText: 'What does "¿Dónde está la estación de metro?" mean?',
          options: [
            'When does the train arrive?',
            'Where is the subway station?',
            'How much is the bus ticket?',
            'Is the hotel open today?',
          ],
          correctIndex: 1,
          explanation:
              '"¿Dónde está...?" means "Where is...?", and "la estación de metro" is the subway station.',
        ),
        QuizQuestionModel(
          id: 'q3_2',
          questionText:
              'Which sequence correctly represents "1, 2, 3" in Spanish?',
          options: [
            'Diez, veinte, treinta',
            'Uno, dos, tres',
            'Primero, segundo, tercero',
            'Cuatro, cinco, seis',
          ],
          correctIndex: 1,
          explanation: '"Uno, dos, tres" corresponds to one, two, three.',
        ),
        QuizQuestionModel(
          id: 'q3_3',
          questionText: '"El Billete" refers to:',
          options: [
            'The Ticket',
            'The Luggage',
            'The Airplane',
            'The Passport',
          ],
          correctIndex: 0,
          explanation: '"El Billete" is the ticket for travel or admission.',
        ),
      ],
    ),
  ];

  // Badges & Achievements
  static const List<BadgeModel> sampleBadges = [
    BadgeModel(
      id: 'b_streak_5',
      title: '5-Day Streak Master',
      description: 'Maintained a consistent daily learning habit for 5 days.',
      iconEmoji: '🔥',
      isUnlocked: false,
    ),
    BadgeModel(
      id: 'b_vocab_100',
      title: 'Word Collector (100+)',
      description: 'Mastered over 100 new vocabulary words.',
      iconEmoji: '📚',
      isUnlocked: false,
    ),
    BadgeModel(
      id: 'b_perfect_quiz',
      title: 'Sharp Mind',
      description: 'Scored 100% accuracy on an interactive lesson quiz.',
      iconEmoji: '🎯',
      isUnlocked: false,
    ),
    BadgeModel(
      id: 'b_cafe_master',
      title: 'Barista Connoisseur',
      description: 'Completed 50% of the Café & Restaurant Unit.',
      iconEmoji: '☕',
      isUnlocked: false,
    ),
    BadgeModel(
      id: 'b_polyglot',
      title: 'Polyglot Explorer',
      description: 'Learned vocabulary in 3 or more distinct languages.',
      iconEmoji: '🌍',
      isUnlocked: false,
    ),
    BadgeModel(
      id: 'b_streak_30',
      title: 'Unstoppable (30 Days)',
      description: 'Reach a legendary 30-day continuous learning streak.',
      iconEmoji: '👑',
      isUnlocked: false,
    ),
  ];

  // Weekly Activity (Matching the Stitch AI Chart: M, T, W, T, F, S, S)
  // Mon: check, Tue: check, Wed: check, Thu: check, Fri: lightning active, Sat/Sun: empty
  static List<DailyActivityModel> get sampleWeeklyActivity => const [
        DailyActivityModel(dayLabel: 'M', minutes: 22, isCompleted: true),
        DailyActivityModel(dayLabel: 'T', minutes: 28, isCompleted: true),
        DailyActivityModel(dayLabel: 'W', minutes: 18, isCompleted: true),
        DailyActivityModel(dayLabel: 'T', minutes: 25, isCompleted: true),
        DailyActivityModel(
            dayLabel: 'F', minutes: 12, isCompleted: false, isCurrentDay: true),
        DailyActivityModel(dayLabel: 'S', minutes: 0, isCompleted: false),
        DailyActivityModel(dayLabel: 'S', minutes: 0, isCompleted: false),
      ];
}
