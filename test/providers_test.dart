import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lingualearn_app/core/data/app_mock_data.dart';
import 'package:lingualearn_app/models/language_model.dart';
import 'package:lingualearn_app/models/vocabulary_model.dart';
import 'package:lingualearn_app/providers/course_provider.dart';
import 'package:lingualearn_app/providers/language_provider.dart';
import 'package:lingualearn_app/providers/progress_provider.dart';
import 'package:lingualearn_app/providers/quiz_provider.dart';
import 'package:lingualearn_app/providers/settings_provider.dart';
import 'package:lingualearn_app/providers/vocabulary_provider.dart';
import 'package:lingualearn_app/screens/vocabulary/vocabulary_screen.dart';
import 'package:lingualearn_app/services/storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late StorageService storageService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    storageService = await StorageService.getInstance();
    await storageService.clearAllData();
  });

  group('LanguageProvider Tests', () {
    test('Default language is Spanish', () {
      final provider = LanguageProvider(storageService);
      expect(provider.selectedLanguage.id, 'es');
      expect(provider.selectedLanguage.name, 'Spanish');
    });

    test('Change language updates state and persists', () async {
      final provider = LanguageProvider(storageService);
      final french =
          LanguageModel.supportedLanguages.firstWhere((l) => l.id == 'fr');
      await provider.setLanguage(french);

      expect(provider.selectedLanguage.id, 'fr');
      expect(storageService.getSelectedLanguage(), 'fr');
    });

    test('Change proficiency level updates state and persists', () async {
      final provider = LanguageProvider(storageService);
      await provider.setLevel('Intermediate');

      expect(provider.selectedLevel, 'Intermediate');
      expect(storageService.getSelectedLevel(), 'Intermediate');
    });
  });

  group('CourseProvider Tests', () {
    test('Initializes with default Spanish course matching Stitch AI', () {
      final provider = CourseProvider(storageService);
      expect(provider.currentUnit.title, 'Unit 2: Ordering at a Café');
      expect(provider.currentLesson.title, 'Basic Greetings');
      expect(provider.currentCourse.units.length, greaterThanOrEqualTo(2));
    });

    test('Marking lesson completed updates progress and unlocks next lesson',
        () async {
      final provider = CourseProvider(storageService);
      final initialCompleted = provider.currentCourse.completedLessons;

      await provider.markLessonCompleted('es_u2_l5');
      expect(provider.currentCourse.completedLessons, initialCompleted + 1);
      expect(storageService.getCompletedLessonIds(), contains('es_u2_l5'));

      // Check that lesson 6 is now unlocked
      final lesson6 = provider.getLessonById('es_u2_l6');
      expect(lesson6?.isLocked, isFalse);
    });

    test('Course reset restores persisted lessons and cross-unit locking',
        () async {
      await storageService.setCompletedLessonIds([
        'es_u1_l1',
        'es_u1_l2',
        'es_u1_l3',
      ]);
      final provider = CourseProvider(storageService);

      expect(provider.currentCourse.completedLessons, 3);
      expect(provider.getLessonById('es_u2_l1')?.isLocked, isFalse);

      provider.reset();
      expect(provider.getLessonById('es_u2_l1')?.isLocked, isFalse);
    });
  });

  group('VocabularyProvider Tests', () {
    test('All language datasets are complete and have unique vocabulary', () {
      final datasets = <String, List<VocabularyModel>>{
        'es': AppMockData.spanishVocabulary,
        'fr': AppMockData.frenchVocabulary,
        'de': AppMockData.germanVocabulary,
        'ja': AppMockData.japaneseVocabulary,
        'en': AppMockData.englishVocabulary,
        'ar': AppMockData.arabicVocabulary,
      };
      final allIds = <String>{};
      const categories = {
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
      };

      for (final entry in datasets.entries) {
        expect(entry.value.length, greaterThanOrEqualTo(100));
        final words = <String>{};
        final examples = <String>{};

        for (final word in entry.value) {
          expect(word.languageCode, entry.key);
          expect(allIds.add(word.id), isTrue);
          expect(words.add(word.word.toLowerCase().trim()), isTrue);
          expect(word.partOfSpeech.trim(), isNotEmpty);
          expect(categories, contains(word.category));
          expect(word.translation.trim(), isNotEmpty);
          expect(word.urduTranslation.trim(), isNotEmpty);
          expect(word.phonetic.trim(), isNotEmpty);
          expect(word.exampleSentence.trim(), isNotEmpty);
          expect(word.exampleTranslation.trim(), isNotEmpty);
          expect(word.exampleUrduTranslation.trim(), isNotEmpty);
          expect(word.phonetic, isNot(startsWith('[')));
          expect(word.phonetic, isNot('[${word.word}]'));
          expect(
            word.exampleTranslation.toLowerCase(),
            isNot(contains('very useful')),
          );
          expect(
            word.exampleTranslation.toLowerCase(),
            isNot(startsWith('the word')),
          );
          expect(examples.add(word.exampleSentence), isTrue);
        }
      }

      expect(
        AppMockData.spanishVocabulary.take(12).map((word) => word.id).toList(),
        List.generate(12, (index) => 'es_vocab_${index + 1}'),
      );
      expect(
        AppMockData.spanishVocabulary
            .singleWhere((word) => word.word == 'el agua potable')
            .partOfSpeech,
        'noun, f',
      );
      expect(
        AppMockData.germanVocabulary
            .singleWhere((word) => word.word == 'das Haus')
            .partOfSpeech,
        'noun, n',
      );
      expect(
        AppMockData.frenchVocabulary
            .singleWhere((word) => word.word == 'le pain')
            .phonetic,
        '/lə pɛ̃/',
      );
      expect(
        AppMockData.germanVocabulary
            .singleWhere((word) => word.word == 'das Brot')
            .phonetic,
        '/das bʁot/',
      );
      expect(
        AppMockData.japaneseVocabulary
            .singleWhere((word) => word.word == 'さようなら')
            .phonetic,
        'sayōnara',
      );
      expect(
        AppMockData.arabicVocabulary
            .singleWhere((word) => word.word == 'إلى اللقاء')
            .phonetic,
        "ilā al-liqā'",
      );
    });

    test('Provider and flashcard queue load each language dataset', () {
      final provider = VocabularyProvider(storageService);
      final datasets = <String, List<VocabularyModel>>{
        'es': AppMockData.spanishVocabulary,
        'fr': AppMockData.frenchVocabulary,
        'de': AppMockData.germanVocabulary,
        'ja': AppMockData.japaneseVocabulary,
        'en': AppMockData.englishVocabulary,
        'ar': AppMockData.arabicVocabulary,
      };

      for (final entry in datasets.entries) {
        provider.updateLanguage(entry.key);
        expect(provider.allWords.length, entry.value.length);
        expect(provider.flashcardsQueue.length, entry.value.length);
        expect(
          provider.allWords.every((word) => word.languageCode == entry.key),
          isTrue,
        );
      }
    });

    test('Cross-language favorite and learned edits persist', () async {
      await storageService.setFavoriteWordIds(['es_vocab_2']);
      final provider = VocabularyProvider(storageService);

      expect(
        provider
            .wordsForLanguage('fr')
            .singleWhere((word) => word.id == 'fr_vocab_1')
            .isFavorite,
        isTrue,
      );
      await provider.toggleFavorite('fr_vocab_1');
      await provider.toggleLearned('fr_vocab_1');

      final reloadedProvider = VocabularyProvider(storageService);
      final frenchBreakfast = reloadedProvider.wordsForLanguage('fr').first;
      expect(frenchBreakfast.isFavorite, isFalse);
      expect(frenchBreakfast.isLearned, isTrue);
      expect(storageService.getFavoriteWordIds(), contains('es_vocab_2'));
      expect(reloadedProvider.allWords.first.languageCode, 'es');
    });

    testWidgets(
        'Vocabulary search stays usable with keyboard and opens details',
        (tester) async {
      tester.view.physicalSize = const Size(390, 600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetViewInsets);

      final languageProvider = LanguageProvider(storageService);
      final vocabularyProvider = VocabularyProvider(storageService);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<LanguageProvider>.value(
              value: languageProvider,
            ),
            ChangeNotifierProvider<VocabularyProvider>.value(
              value: vocabularyProvider,
            ),
          ],
          child: const MaterialApp(home: VocabularyScreen()),
        ),
      );

      final vocabularySearch = find.byType(TextField).first;
      await tester.tap(vocabularySearch);
      await tester.pump();
      tester.view.viewInsets = const FakeViewPadding(bottom: 360);
      await tester.pumpAndSettle();
      final layoutException = tester.takeException();
      expect(layoutException, isNull);
      expect(tester.getRect(vocabularySearch).bottom, lessThan(240));

      await tester.enterText(vocabularySearch, 'gracias');
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      final vocabularyScroll = find.byType(CustomScrollView).first;
      await tester.drag(vocabularyScroll, const Offset(0, -400));
      await tester.pumpAndSettle();
      expect(find.text('Gracias'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.drag(vocabularyScroll, const Offset(0, 400));
      await tester.pumpAndSettle();
      FocusManager.instance.primaryFocus?.unfocus();
      tester.view.resetViewInsets();
      await tester.pumpAndSettle();

      tester.view.physicalSize = const Size(320, 560);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.tap(vocabularySearch);
      await tester.pump();
      tester.view.viewInsets = const FakeViewPadding(bottom: 320);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      FocusManager.instance.primaryFocus?.unfocus();
      tester.view.resetViewInsets();
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('allVocabularyButton')));
      await tester.pumpAndSettle();
      expect(find.text('All Vocabulary Words'), findsOneWidget);

      await tester.enterText(find.byType(TextField).last, 'gracias');
      await tester.pumpAndSettle();
      expect(find.text('Gracias'), findsOneWidget);

      await tester.tap(find.text('Gracias'));
      await tester.pumpAndSettle();
      expect(find.text('EXAMPLE'), findsOneWidget);
      expect(find.text('Add favorite'), findsOneWidget);

      await tester.ensureVisible(find.text('Add favorite'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add favorite'));
      await tester.pumpAndSettle();
      expect(find.text('Favorited'), findsOneWidget);
    });

    test('Search matches Urdu words and example translations', () {
      final provider = VocabularyProvider(storageService);

      provider.setSearchQuery('کتاب');
      expect(
        provider.filteredWords.any((word) => word.translation == 'Book'),
        isTrue,
      );

      provider.setSearchQuery('الوداع کہا');
      expect(provider.filteredWords, isNotEmpty);
      expect(
        provider.filteredWords.every(
          (word) => word.exampleUrduTranslation.contains('الوداع کہا'),
        ),
        isTrue,
      );

      provider.setSearchQuery('THANK YOU VERY MUCH FOR YOUR HELP');
      expect(provider.filteredWords.single.id, 'es_vocab_4');

      provider.setSearchQuery('muchas gracias');
      expect(provider.filteredWords.single.id, 'es_vocab_4');

      provider.setSearchQuery('آپ کی مدد کے لیے');
      expect(provider.filteredWords.single.id, 'es_vocab_4');
    });

    test('Spanish lesson vocabulary references remain valid', () {
      final vocabularyIds =
          AppMockData.spanishVocabulary.map((word) => word.id).toSet();
      final course = AppMockData.getSpanishCourse('Beginner');

      for (final unit in course.units) {
        for (final lesson in unit.lessons) {
          expect(vocabularyIds, containsAll(lesson.vocabularyIds));
        }
      }
    });

    test('Word of the Day matches El Desayuno', () {
      final provider = VocabularyProvider(storageService);
      expect(provider.wordOfTheDay.word, 'El Desayuno');
      expect(provider.wordOfTheDay.phonetic, '/el desaˈʝuno/');
      expect(provider.wordOfTheDay.translation, 'The Breakfast');
    });

    test('Filtering by category returns only matching words', () {
      final provider = VocabularyProvider(storageService);
      provider.setCategory('Travel');

      for (final word in provider.filteredWords) {
        expect(word.category, 'Travel');
      }
    });

    test('Searching words filters by query', () {
      final provider = VocabularyProvider(storageService);
      provider.setSearchQuery('Gracias');

      expect(
        provider.filteredWords.any((word) => word.word == 'Gracias'),
        isTrue,
      );
    });

    test('Toggle favorite persists to storage', () async {
      final provider = VocabularyProvider(storageService);
      final targetId = 'es_vocab_2';

      await provider.toggleFavorite(targetId);
      expect(storageService.getFavoriteWordIds(), contains(targetId));

      await provider.toggleFavorite(targetId);
      expect(storageService.getFavoriteWordIds(), isNot(contains(targetId)));
    });
  });

  group('QuizProvider Tests', () {
    testWidgets(
        'Each language has quick and lesson quizzes and language changes reset state',
        (tester) async {
      late LanguageProvider languageProvider;
      late QuizProvider quizProvider;
      const sampleQuestions = {
        'en': 'Which word names the first meal of the day?',
        'es': 'What is the correct Spanish translation for "The Breakfast"?',
        'fr': 'Quel mot désigne le premier repas de la journée ?',
        'de': 'Welches Wort bezeichnet die erste Mahlzeit des Tages?',
        'ja': '一日の最初の食事を表す言葉はどれですか。',
        'ar': 'ما الكلمة التي تدل على أول وجبة في اليوم؟',
      };
      const correctAnswers = {
        'en': 'Breakfast',
        'es': 'El Desayuno',
        'fr': 'Le petit-déjeuner',
        'de': 'Frühstück',
        'ja': '朝食',
        'ar': 'الفطور',
      };

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) =>
                  languageProvider = LanguageProvider(storageService),
            ),
            ChangeNotifierProxyProvider<LanguageProvider, QuizProvider>(
              create: (_) => QuizProvider(storageService),
              update: (_, language, quiz) {
                final current = quiz ?? QuizProvider(storageService);
                current.updateLanguage(language.selectedLanguage.id);
                return current;
              },
            ),
          ],
          child: Builder(
            builder: (context) {
              quizProvider = context.watch<QuizProvider>();
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      quizProvider.startQuickQuiz();
      expect(quizProvider.activeQuiz?.id, 'quiz_es_1');
      final spanishQuestion = quizProvider.currentQuestion!;
      expect(spanishQuestion.correctIndex, 0);
      expect(
        spanishQuestion.options[spanishQuestion.correctIndex],
        'El Desayuno',
      );
      quizProvider.selectOption(0);
      quizProvider.checkAnswer();
      for (var index = 1; index < quizProvider.totalQuestions; index++) {
        quizProvider.nextQuestion();
        final question = quizProvider.currentQuestion!;
        quizProvider.selectOption(question.correctIndex);
        quizProvider.checkAnswer();
      }
      await quizProvider.finishQuiz();
      final savedScoreCount = storageService.getQuizScores().length;
      expect(savedScoreCount, 1);

      await languageProvider.setLanguage(
        LanguageModel.supportedLanguages.firstWhere(
          (language) => language.id == 'fr',
        ),
      );
      await tester.pump();

      for (final language in LanguageModel.supportedLanguages) {
        if (language.id != quizProvider.selectedLanguageCode) {
          await languageProvider.setLanguage(language);
          await tester.pump();
        }

        expect(quizProvider.selectedLanguageCode, language.id);
        expect(quizProvider.activeQuiz, isNull);
        expect(quizProvider.currentQuestionIndex, 0);
        expect(quizProvider.selectedOptionIndex, isNull);
        expect(quizProvider.isAnswerChecked, isFalse);
        expect(quizProvider.isQuizFinished, isFalse);
        expect(quizProvider.lastResult, isNull);
        expect(quizProvider.availableQuizzes, hasLength(3));
        expect(
          quizProvider.availableQuizzes.map((quiz) => quiz.questions.length),
          [5, 3, 3],
        );

        for (final quiz in quizProvider.availableQuizzes) {
          for (final question in quiz.questions) {
            expect(question.questionText.trim(), isNotEmpty);
            expect(question.options, hasLength(4));
            expect(question.options.toSet(), hasLength(4));
            expect(
              question.correctIndex,
              inInclusiveRange(0, question.options.length - 1),
            );
            expect(question.explanation.trim(), isNotEmpty);
          }
        }

        quizProvider.startQuickQuiz();
        final question = quizProvider.currentQuestion!;
        expect(question.questionText, sampleQuestions[language.id]);
        expect(
          question.options[question.correctIndex],
          correctAnswers[language.id],
        );
        expect(
          question.explanation,
          contains(correctAnswers[language.id]!),
        );

        for (var index = 0;
            index < quizProvider.availableQuizzes.length;
            index++) {
          final lessonQuizId = 'quiz_es_${index + 1}';
          quizProvider.startQuizById(lessonQuizId);
          expect(quizProvider.activeQuiz?.id, lessonQuizId);
          expect(
            quizProvider.activeQuiz?.title,
            quizProvider.availableQuizzes[index].title,
          );
        }

        expect(storageService.getQuizScores(), hasLength(savedScoreCount));
      }

      await tester.pumpWidget(const SizedBox.shrink());
    });

    test('Quiz scoring and calculation works dynamically', () async {
      final provider = QuizProvider(storageService);
      final quiz = AppMockData.allQuizzes.first;

      provider.startQuiz(quiz);
      expect(provider.totalQuestions, 5);
      expect(provider.currentQuestionIndex, 0);

      // Question 1: correct index is 0 ("El Desayuno")
      provider.selectOption(0);
      provider.checkAnswer();
      expect(provider.isAnswerChecked, isTrue);

      provider.nextQuestion();
      expect(provider.currentQuestionIndex, 1);

      // Question 2: select wrong option
      provider.selectOption(0); // correct is 1 ("Por favor")
      provider.checkAnswer();

      // Finish remaining questions
      provider.nextQuestion();
      provider.selectOption(2); // q3 correct is 2
      provider.checkAnswer();

      provider.nextQuestion();
      provider.selectOption(1); // q4 correct is 1
      provider.checkAnswer();

      provider.nextQuestion();
      provider.selectOption(3); // q5 correct is 3
      provider.checkAnswer();

      await provider.finishQuiz();

      expect(provider.isQuizFinished, isTrue);
      expect(provider.lastResult?.correctAnswers, 4);
      expect(provider.lastResult?.incorrectAnswers, 1);
      expect(provider.lastResult?.scorePercentage, 80.0);
    });
  });

  group('ProgressProvider Tests', () {
    test('Progress starts from real activity and selected-language data', () {
      final provider = ProgressProvider(storageService);
      expect(provider.streakDays, 0);
      expect(provider.streakFreezes, 0);
      expect(provider.maxStreakFreezes, 2);
      expect(provider.todayMinutes, 0);
      expect(provider.goalMinutes, 20);
      expect(provider.goalPercent, 0);
      expect(provider.remainingMinutes, 20);
      expect(provider.masteredWords, 0);
      expect(provider.totalVocabulary, AppMockData.spanishVocabulary.length);
      expect(provider.vocabularyCompletionPercent, 0);
      expect(provider.badges.where((badge) => badge.isUnlocked), isEmpty);
    });

    test('Learned words update selected-language progress and persist',
        () async {
      final languageProvider = LanguageProvider(storageService);
      final vocabularyProvider = VocabularyProvider(storageService);
      final quizProvider = QuizProvider(storageService);
      final courseProvider = CourseProvider(storageService);
      final provider = ProgressProvider(storageService);
      provider.updateSources(
        languageProvider,
        vocabularyProvider,
        quizProvider,
        courseProvider,
      );

      expect(provider.masteredWords, 0);
      await vocabularyProvider.toggleLearned('es_vocab_5');
      provider.updateSources(
        languageProvider,
        vocabularyProvider,
        quizProvider,
        courseProvider,
      );
      expect(provider.masteredWords, 1);
      expect(provider.vocabularyCompletionPercent, 1);

      await vocabularyProvider.toggleLearned('es_vocab_5');
      provider.updateSources(
        languageProvider,
        vocabularyProvider,
        quizProvider,
        courseProvider,
      );
      expect(provider.masteredWords, 0);

      await vocabularyProvider.toggleLearned('es_vocab_5');
      provider.updateSources(
        languageProvider,
        vocabularyProvider,
        quizProvider,
        courseProvider,
      );
      expect(provider.masteredWords, 1);

      await languageProvider.setLanguage(
        LanguageModel.supportedLanguages
            .firstWhere((language) => language.id == 'fr'),
      );
      vocabularyProvider.updateLanguage('fr');
      provider.updateSources(
        languageProvider,
        vocabularyProvider,
        quizProvider,
        courseProvider,
      );
      expect(provider.masteredWords, 0);
      expect(provider.totalVocabulary, AppMockData.frenchVocabulary.length);

      final reloadedVocabulary = VocabularyProvider(storageService);
      expect(
        reloadedVocabulary
            .wordsForLanguage('es')
            .singleWhere((word) => word.id == 'es_vocab_5')
            .isLearned,
        isTrue,
      );

      final restoredProgress = ProgressProvider(storageService);
      restoredProgress.updateSources(
        languageProvider,
        reloadedVocabulary,
        quizProvider,
        courseProvider,
      );
      await languageProvider.setLanguage(
        LanguageModel.supportedLanguages
            .firstWhere((language) => language.id == 'es'),
      );
      restoredProgress.updateSources(
        languageProvider,
        reloadedVocabulary,
        quizProvider,
        courseProvider,
      );
      expect(restoredProgress.masteredWords, 1);
    });

    test('Daily activity and streak persist across provider restarts',
        () async {
      final provider = ProgressProvider(storageService);
      expect(provider.remainingMinutes, 20);
      await provider.addStudyMinutes(8);

      expect(provider.todayMinutes, 8);
      expect(provider.goalPercent, 40);
      expect(provider.remainingMinutes, 12);
      expect(provider.weeklyActivity.last.minutes, 8);
      expect(provider.streakDays, 1);

      final reloadedProvider = ProgressProvider(storageService);
      expect(reloadedProvider.todayMinutes, 8);
      expect(reloadedProvider.totalStudyMinutes, 8);
      expect(reloadedProvider.streakDays, 1);

      await reloadedProvider.addStudyMinutes(12);
      expect(reloadedProvider.todayMinutes, 20);
      expect(reloadedProvider.goalPercent, 100);
      expect(reloadedProvider.remainingMinutes, 0);
      expect(storageService.getTodayMinutes(), 20);
    });

    test('Quiz completion updates progress and awards a badge once', () async {
      final languageProvider = LanguageProvider(storageService);
      final vocabularyProvider = VocabularyProvider(storageService);
      final quizProvider = QuizProvider(storageService);
      final courseProvider = CourseProvider(storageService);
      final progressProvider = ProgressProvider(storageService);
      progressProvider.updateSources(
        languageProvider,
        vocabularyProvider,
        quizProvider,
        courseProvider,
      );

      final quiz = AppMockData.allQuizzes.first;
      quizProvider.startQuiz(quiz);
      for (var index = 0; index < quiz.questions.length; index++) {
        quizProvider.selectOption(quiz.questions[index].correctIndex);
        quizProvider.checkAnswer();
        if (index < quiz.questions.length - 1) {
          quizProvider.nextQuestion();
        }
      }
      await quizProvider.finishQuiz();
      await quizProvider.finishQuiz();
      progressProvider.updateSources(
        languageProvider,
        vocabularyProvider,
        quizProvider,
        courseProvider,
      );

      expect(progressProvider.quizAttempts, 1);
      expect(progressProvider.bestQuizScore, 100);
      expect(
        progressProvider.badges
            .singleWhere((badge) => badge.id == 'b_perfect_quiz')
            .isUnlocked,
        isTrue,
      );
      await Future<void>.delayed(Duration.zero);
      expect(
        storageService
            .getUnlockedBadgeIds()
            .where((id) => id == 'b_perfect_quiz')
            .length,
        1,
      );

      final restoredProgress = ProgressProvider(storageService);
      expect(
        restoredProgress.badges
            .singleWhere((badge) => badge.id == 'b_perfect_quiz')
            .isUnlocked,
        isTrue,
      );
    });

    test('Vocabulary and course badges unlock only after real progress',
        () async {
      final learnedIds = AppMockData.spanishVocabulary
          .take(100)
          .map((word) => word.id)
          .toList();
      await storageService.setLearnedWordIds(learnedIds);

      final languageProvider = LanguageProvider(storageService);
      final vocabularyProvider = VocabularyProvider(storageService);
      final quizProvider = QuizProvider(storageService);
      final courseProvider = CourseProvider(storageService);
      final progressProvider = ProgressProvider(storageService);
      progressProvider.updateSources(
        languageProvider,
        vocabularyProvider,
        quizProvider,
        courseProvider,
      );

      expect(progressProvider.masteredWords, 100);
      expect(
        progressProvider.badges
            .singleWhere((badge) => badge.id == 'b_vocab_100')
            .isUnlocked,
        isTrue,
      );

      final cafeUnit = courseProvider.currentCourse.units.singleWhere(
        (unit) => unit.title.toLowerCase().contains('café'),
      );
      final lessonsToComplete = (cafeUnit.lessons.length / 2).ceil();
      for (final lesson in cafeUnit.lessons.take(lessonsToComplete)) {
        await courseProvider.markLessonCompleted(lesson.id);
      }
      progressProvider.updateSources(
        languageProvider,
        vocabularyProvider,
        quizProvider,
        courseProvider,
      );

      expect(
        progressProvider.badges
            .singleWhere((badge) => badge.id == 'b_cafe_master')
            .isUnlocked,
        isTrue,
      );
      await Future<void>.delayed(Duration.zero);
      expect(
        storageService.getUnlockedBadgeIds().toSet().length,
        storageService.getUnlockedBadgeIds().length,
      );
    });
  });

  group('SettingsProvider Tests', () {
    test('Toggle dark mode updates state and persists', () async {
      final provider = SettingsProvider(storageService);
      expect(provider.isDarkMode, isFalse);

      await provider.toggleDarkMode(true);
      expect(provider.isDarkMode, isTrue);
      expect(storageService.isDarkMode(), isTrue);
    });

    test('Updating user name updates state and persists', () async {
      final provider = SettingsProvider(storageService);
      await provider.updateUserName('Elena');

      expect(provider.userName, 'Elena');
      expect(storageService.getUserName(), 'Elena');
    });
  });
}
