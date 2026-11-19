import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'providers/course_provider.dart';
import 'providers/language_provider.dart';
import 'providers/progress_provider.dart';
import 'providers/quiz_provider.dart';
import 'providers/notifications_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/translation_provider.dart';
import 'providers/vocabulary_provider.dart';
import 'services/storage_service.dart';
import 'services/translation_service.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations for polished mobile experience
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize offline persistent local storage
  final storageService = await StorageService.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(storageService),
        ),
        ChangeNotifierProvider(
          create: (_) => TranslationProvider(MyMemoryTranslationService()),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationsProvider(storageService),
        ),
        ChangeNotifierProvider(
          create: (_) => LanguageProvider(storageService),
        ),
        ChangeNotifierProxyProvider<LanguageProvider, CourseProvider>(
          create: (_) => CourseProvider(storageService),
          update: (_, language, course) {
            final current = course ?? CourseProvider(storageService);
            current.updateForLanguage(
              language.selectedLanguage.id,
              language.selectedLevel,
            );
            return current;
          },
        ),
        ChangeNotifierProxyProvider<LanguageProvider, VocabularyProvider>(
          create: (_) => VocabularyProvider(storageService),
          update: (_, language, vocabulary) {
            final current = vocabulary ?? VocabularyProvider(storageService);
            current.updateLanguage(language.selectedLanguage.id);
            return current;
          },
        ),
        ChangeNotifierProxyProvider<LanguageProvider, QuizProvider>(
          create: (_) => QuizProvider(storageService),
          update: (_, language, quiz) {
            final current = quiz ?? QuizProvider(storageService);
            current.updateLanguage(language.selectedLanguage.id);
            return current;
          },
        ),
        ChangeNotifierProxyProvider4<LanguageProvider, VocabularyProvider,
            QuizProvider, CourseProvider, ProgressProvider>(
          create: (_) => ProgressProvider(storageService),
          update: (_, language, vocabulary, quiz, course, progress) {
            final current = progress ?? ProgressProvider(storageService);
            current.updateSources(language, vocabulary, quiz, course);
            return current;
          },
        ),
      ],
      child: const LinguaLearnApp(),
    ),
  );
}
