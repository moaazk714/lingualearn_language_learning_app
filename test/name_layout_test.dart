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
import 'package:lingualearn_app/screens/profile/profile_screen.dart';
import 'package:lingualearn_app/services/storage_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _names = [
  'Alex',
  'Muhammad Moaaz',
  'Muhammad Moaaz Khan',
  'ExtremelyLongUserNameThatTakesUpMuchMoreSpace',
];
const _widths = [320.0, 360.0, 400.0, 600.0];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late StorageService storage;
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    storage = await StorageService.getInstance();
  });

  for (final screen in ['Home', 'Profile']) {
    testWidgets('$screen name fits across supported widths', (tester) async {
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      for (final width in _widths) {
        tester.view.physicalSize = Size(width, 1000);
        for (final name in _names) {
          final settings = SettingsProvider(storage);
          await settings.updateUserName(name);
          await tester.pumpWidget(_buildApp(
            storage,
            screen == 'Home' ? const HomeScreen() : const ProfileScreen(),
            settings,
          ));
          await tester.pumpAndSettle();

          final nameFinder = screen == 'Home'
              ? find.byWidgetPredicate(
                  (widget) =>
                      widget is Text && (widget.data?.contains(name) ?? false),
                )
              : find.text(name);
          expect(nameFinder, findsOneWidget);

          final nameText = tester.widget<Text>(nameFinder);
          expect(nameText.maxLines, isNull);
          expect(nameText.softWrap, isTrue);
          final nameRect = tester.getRect(nameFinder);
          expect(nameRect.left, greaterThanOrEqualTo(0));
          expect(nameRect.right, lessThanOrEqualTo(width));

          expect(
            tester.takeException(),
            isNull,
            reason: '$screen rendered with "$name" at $width px',
          );
        }
      }
    });
  }

  testWidgets('Profile saves the complete long name', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(320, 900);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final settings = SettingsProvider(storage);
    await settings.updateUserName('Alex');
    await tester
        .pumpWidget(_buildApp(storage, const ProfileScreen(), settings));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.edit_rounded));
    await tester.pumpAndSettle();
    const longName = 'ExtremelyLongUserNameThatTakesUpMuchMoreSpace';
    await tester.enterText(find.byType(TextField), longName);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(settings.userName, longName);
    expect(storage.getUserName(), longName);
    expect(find.text(longName), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Widget _buildApp(
  StorageService storage,
  Widget screen,
  SettingsProvider settings,
) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<SettingsProvider>.value(value: settings),
      ChangeNotifierProvider(create: (_) => NotificationsProvider(storage)),
      ChangeNotifierProvider(create: (_) => LanguageProvider(storage)),
      ChangeNotifierProvider(create: (_) => CourseProvider(storage)),
      ChangeNotifierProvider(create: (_) => VocabularyProvider(storage)),
      ChangeNotifierProvider(create: (_) => QuizProvider(storage)),
      ChangeNotifierProvider(create: (_) => ProgressProvider(storage)),
    ],
    child: MaterialApp(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.3)),
        child: child!,
      ),
      home: screen,
    ),
  );
}
