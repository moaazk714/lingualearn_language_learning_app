import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingualearn_app/providers/course_provider.dart';
import 'package:lingualearn_app/providers/language_provider.dart';
import 'package:lingualearn_app/providers/notifications_provider.dart';
import 'package:lingualearn_app/providers/progress_provider.dart';
import 'package:lingualearn_app/providers/quiz_provider.dart';
import 'package:lingualearn_app/providers/settings_provider.dart';
import 'package:lingualearn_app/providers/vocabulary_provider.dart';
import 'package:lingualearn_app/screens/home/home_screen.dart';
import 'package:lingualearn_app/services/storage_service.dart';
import 'package:lingualearn_app/widgets/word_of_the_day_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Home dashboard has no overflow at 320px and 360px',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await StorageService.getInstance();
    await storage.setUnfavoritedWordIds(['es_vocab_1']);

    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final width in [320.0, 360.0]) {
      tester.view.physicalSize = Size(width, 800);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => SettingsProvider(storage),
            ),
            ChangeNotifierProvider(
              create: (_) => NotificationsProvider(storage),
            ),
            ChangeNotifierProvider(
              create: (_) => LanguageProvider(storage),
            ),
            ChangeNotifierProvider(
              create: (_) => CourseProvider(storage),
            ),
            ChangeNotifierProvider(
              create: (_) => VocabularyProvider(storage),
            ),
            ChangeNotifierProvider(
              create: (_) => QuizProvider(storage),
            ),
            ChangeNotifierProvider(
              create: (_) => ProgressProvider(storage),
            ),
          ],
          child: const MaterialApp(home: HomeScreen()),
        ),
      );
      await tester.pumpAndSettle();

      final card = find.byType(WordOfTheDayCard);
      final addButtonText = find.text('Add to Flashcards');
      expect(card, findsOneWidget);
      expect(addButtonText, findsOneWidget);
      expect(
        tester.getRect(addButtonText).right,
        lessThanOrEqualTo(tester.getRect(card).right),
      );
      expect(tester.takeException(), isNull);
    }
  });
}
