import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:lingualearn_app/app/app.dart';
import 'package:lingualearn_app/core/constants/app_strings.dart';
import 'package:lingualearn_app/providers/course_provider.dart';
import 'package:lingualearn_app/providers/language_provider.dart';
import 'package:lingualearn_app/providers/progress_provider.dart';
import 'package:lingualearn_app/providers/quiz_provider.dart';
import 'package:lingualearn_app/providers/settings_provider.dart';
import 'package:lingualearn_app/providers/vocabulary_provider.dart';
import 'package:lingualearn_app/services/storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('LinguaLearn App smoke test and splash initialization',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final storageService = await StorageService.getInstance();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => SettingsProvider(storageService),
          ),
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(storageService),
          ),
          ChangeNotifierProvider(
            create: (_) => CourseProvider(storageService),
          ),
          ChangeNotifierProvider(
            create: (_) => VocabularyProvider(storageService),
          ),
          ChangeNotifierProvider(
            create: (_) => QuizProvider(storageService),
          ),
          ChangeNotifierProvider(
            create: (_) => ProgressProvider(storageService),
          ),
        ],
        child: const LinguaLearnApp(),
      ),
    );

    // Initial frame
    await tester.pump();

    // Verify splash screen elements render
    expect(find.byType(RichText), findsWidgets);
    expect(find.text(AppStrings.appTagline), findsOneWidget);
    expect(find.text(AppStrings.immersionPathways), findsOneWidget);

    // Advance past the 2.6s splash timer and settle animations
    await tester.pump(const Duration(milliseconds: 2700));
    await tester.pumpAndSettle();

    // After splash timer, should navigate to Onboarding screen
    expect(find.text(AppStrings.onboardingTitle1), findsOneWidget);
  });
}
