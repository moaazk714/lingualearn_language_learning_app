import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lingualearn_app/core/data/app_mock_data.dart';
import 'package:lingualearn_app/core/data/quiz_catalog.dart';
import 'package:lingualearn_app/models/language_model.dart';
import 'package:lingualearn_app/models/translation_language.dart';
import 'package:lingualearn_app/providers/course_provider.dart';
import 'package:lingualearn_app/providers/language_provider.dart';
import 'package:lingualearn_app/providers/quiz_provider.dart';
import 'package:lingualearn_app/providers/translation_provider.dart';
import 'package:lingualearn_app/providers/vocabulary_provider.dart';
import 'package:lingualearn_app/services/storage_service.dart';
import 'package:lingualearn_app/services/translation_service.dart';
import 'package:lingualearn_app/widgets/learning_translation_text.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late StorageService storage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    storage = await StorageService.getInstance();
    await storage.clearAllData();
  });

  test('learning and translation preferences persist independently', () async {
    final provider = LanguageProvider(storage);
    final english = LanguageModel.supportedLanguages
        .firstWhere((language) => language.id == 'en');
    final french = LanguageModel.supportedLanguages
        .firstWhere((language) => language.id == 'fr');
    final urdu = TranslationLanguage.supportedLanguages
        .firstWhere((language) => language.code == 'ur');
    final arabic = TranslationLanguage.supportedLanguages
        .firstWhere((language) => language.code == 'ar');

    await provider.setLanguage(english);
    await provider.setTranslationLanguage(urdu);
    expect(provider.selectedLanguage.id, 'en');
    expect(provider.selectedTranslationLanguage.code, 'ur');

    await provider.setLanguage(french);
    expect(provider.selectedTranslationLanguage.code, 'ur');
    await provider.setTranslationLanguage(arabic);
    expect(provider.selectedLanguage.id, 'fr');

    final restored = LanguageProvider(storage);
    expect(restored.selectedLanguage.id, 'fr');
    expect(restored.selectedTranslationLanguage.code, 'ar');
    expect(storage.getSelectedLanguage(), 'fr');
    expect(storage.getSelectedTranslationLanguage(), 'ar');
  });

  test(
      'learning language selects matching vocabulary, course, and quizzes without losing progress',
      () async {
    final languageProvider = LanguageProvider(storage);
    final courseProvider = CourseProvider(storage);
    final vocabularyProvider = VocabularyProvider(storage);
    final quizProvider = QuizProvider(storage);
    await courseProvider.markLessonCompleted('es_u1_l1');
    await storage.saveQuizScore({
      'quizId': 'saved-score',
      'quizTitle': 'Saved score',
      'totalQuestions': 1,
      'correctAnswers': 1,
      'incorrectAnswers': 0,
      'scorePercentage': 100,
      'dateTaken': DateTime.now().toIso8601String(),
      'userSelectedIndices': [0],
    });
    final savedScoreCount = storage.getQuizScores().length;

    const combinations = [
      ('en', 'ur', 'سیب'),
      ('de', 'ur', 'سیب'),
      ('ja', 'en', 'Apple'),
      ('es', 'ur', 'سیب'),
      ('fr', 'ar', 'تفاحة'),
      ('ar', 'en', 'Apple'),
    ];

    for (final (learningCode, translationCode, expectedMeaning)
        in combinations) {
      final learningLanguage = LanguageModel.supportedLanguages
          .firstWhere((language) => language.id == learningCode);
      final translationLanguage = TranslationLanguage.supportedLanguages
          .firstWhere((language) => language.code == translationCode);
      await languageProvider.setLanguage(learningLanguage);
      await languageProvider.setTranslationLanguage(translationLanguage);

      vocabularyProvider.updateLanguage(learningCode);
      courseProvider.updateForLanguage(learningCode, 'Beginner');
      quizProvider.updateLanguage(learningCode);

      final apple = vocabularyProvider.allWords.firstWhere(
        (word) => word.localizedMeanings['en'] == 'Apple',
      );
      expect(apple.languageCode, learningCode);
      expect(apple.meaningFor(translationCode), expectedMeaning);
      expect(courseProvider.currentCourse.languageCode, learningCode);
      expect(
        courseProvider.currentCourse.units.first.lessons.first.vocabularyIds,
        isNotEmpty,
      );

      quizProvider.startQuickQuiz();
      expect(
        quizProvider.currentQuestion?.questionText,
        QuizCatalog.forLanguage(learningCode)
            .first
            .questions
            .first
            .questionText,
      );

      if (learningCode == 'en') {
        final activeQuestion = quizProvider.currentQuestion;
        await languageProvider.setTranslationLanguage(
          TranslationLanguage.supportedLanguages
              .firstWhere((language) => language.code == 'es'),
        );
        expect(languageProvider.selectedLanguage.id, 'en');
        expect(courseProvider.currentCourse.languageCode, 'en');
        expect(quizProvider.currentQuestion, same(activeQuestion));
      }

      expect(
        storage.getCompletedLessonIds(),
        contains('es_u1_l1'),
      );
      expect(storage.getQuizScores(), hasLength(savedScoreCount));
    }
  });

  testWidgets(
      'missing local meanings use the service and never show English as translated',
      (tester) async {
    final languageProvider = LanguageProvider(storage);
    await languageProvider.setLanguage(
      LanguageModel.supportedLanguages
          .firstWhere((language) => language.id == 'fr'),
    );
    await languageProvider.setTranslationLanguage(
      TranslationLanguage.supportedLanguages
          .firstWhere((language) => language.code == 'ar'),
    );
    final service = _ControlledTranslationService();
    final translationProvider = TranslationProvider(service);
    final frenchApple = AppMockData.frenchVocabulary.firstWhere(
      (word) => word.localizedMeanings['en'] == 'Apple',
    );

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<LanguageProvider>.value(
            value: languageProvider,
          ),
          ChangeNotifierProvider<TranslationProvider>.value(
            value: translationProvider,
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: LearningTranslationText(
              text: frenchApple.translation,
              urduTranslation: frenchApple.urduTranslation,
              localizedTranslations: frenchApple.localizedMeanings,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('تفاحة'), findsOneWidget);
    expect(service.callCount, 0);

    final frenchBaseWord = AppMockData.frenchVocabulary.first;
    final unavailableService = _ControlledTranslationService(throwError: true);
    final unavailableTranslationProvider =
        TranslationProvider(unavailableService);
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<LanguageProvider>.value(
            value: languageProvider,
          ),
          ChangeNotifierProvider<TranslationProvider>.value(
            value: unavailableTranslationProvider,
          ),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: LearningTranslationText(
              text: frenchBaseWord.translation,
              urduTranslation: frenchBaseWord.urduTranslation,
              localizedTranslations: frenchBaseWord.localizedMeanings,
            ),
          ),
        ),
      ),
    );
    unavailableService.fail();
    await tester.pump();
    await tester.pump();

    expect(unavailableService.callCount, 1);
    expect(find.text('Translation unavailable in Arabic.'), findsOneWidget);
    expect(find.text(frenchBaseWord.translation), findsNothing);
  });
}

class _ControlledTranslationService implements TranslationService {
  final bool throwError;
  final Completer<String> _failure = Completer<String>();
  int callCount = 0;

  _ControlledTranslationService({this.throwError = false});

  @override
  Future<String> translate({
    required String text,
    required String sourceLanguageCode,
    required String targetLanguageCode,
  }) async {
    callCount++;
    if (throwError) {
      return _failure.future;
    }
    return 'متاح $targetLanguageCode';
  }

  void fail() {
    _failure.completeError(
      const TranslationException('Network unavailable'),
    );
  }

  @override
  void close() {}
}
