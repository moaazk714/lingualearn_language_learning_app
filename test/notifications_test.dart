import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingualearn_app/app/routes.dart';
import 'package:lingualearn_app/models/app_notification.dart';
import 'package:lingualearn_app/providers/course_provider.dart';
import 'package:lingualearn_app/providers/language_provider.dart';
import 'package:lingualearn_app/providers/notifications_provider.dart';
import 'package:lingualearn_app/providers/progress_provider.dart';
import 'package:lingualearn_app/providers/quiz_provider.dart';
import 'package:lingualearn_app/providers/settings_provider.dart';
import 'package:lingualearn_app/providers/vocabulary_provider.dart';
import 'package:lingualearn_app/screens/home/home_screen.dart';
import 'package:lingualearn_app/screens/notifications/notifications_screen.dart';
import 'package:lingualearn_app/services/storage_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late StorageService storage;
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    storage = await StorageService.getInstance();
  });

  setUp(() async {
    await storage.setNotificationHistory([]);
  });

  test('notification history persists and sorts newest first', () async {
    final provider = NotificationsProvider(storage);
    await provider.addNotification(
      title: 'Older lesson',
      message: 'A lesson reminder.',
      category: NotificationCategory.reminder,
      createdAt: DateTime(2026, 11, 17, 8),
    );
    await provider.addNotification(
      title: 'New achievement',
      message: 'You earned a badge.',
      category: NotificationCategory.achievement,
      createdAt: DateTime(2026, 11, 18, 8),
    );

    final restored = NotificationsProvider(storage);
    expect(
      restored.notifications.map((notification) => notification.title),
      ['New achievement', 'Older lesson'],
    );
    expect(restored.unreadCount, 2);

    await restored.markAsRead(restored.notifications.first.id);
    expect(restored.unreadCount, 1);

    final afterRead = NotificationsProvider(storage);
    expect(afterRead.notifications.first.isRead, isTrue);
    expect(afterRead.unreadCount, 1);
    provider.dispose();
    restored.dispose();
    afterRead.dispose();
  });

  testWidgets('empty state, read actions, and confirmed clearing work',
      (tester) async {
    final provider = NotificationsProvider(storage);
    await tester.pumpWidget(_notificationsApp(provider));
    expect(find.text('No notifications yet'), findsOneWidget);

    await provider.addNotification(
      title: 'Lesson reminder',
      message: 'Continue your lesson.',
      category: NotificationCategory.reminder,
      createdAt: DateTime(2026, 11, 18, 9),
    );
    await provider.addNotification(
      title: 'Achievement unlocked',
      message: 'You finished your first lesson.',
      category: NotificationCategory.achievement,
      createdAt: DateTime(2026, 11, 18, 10),
    );
    await tester.pumpAndSettle();

    expect(find.text('2 unread'), findsOneWidget);
    expect(find.text('Achievement unlocked'), findsOneWidget);
    expect(find.text('Lesson reminder'), findsOneWidget);
    expect(find.text('Achievement'), findsOneWidget);
    final localizations = MaterialLocalizations.of(
        tester.element(find.byType(NotificationsScreen)));
    final displayedDate =
        localizations.formatMediumDate(DateTime(2026, 11, 18, 10));
    final displayedTime = localizations.formatTimeOfDay(
      const TimeOfDay(hour: 10, minute: 0),
    );
    expect(find.text('$displayedDate · $displayedTime'), findsOneWidget);

    await tester.tap(
      find.byKey(ValueKey('notification-${provider.notifications.first.id}')),
    );
    await tester.pumpAndSettle();
    expect(provider.unreadCount, 1);
    expect(find.text('1 unread'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('mark-all-notifications-read')));
    await tester.pumpAndSettle();
    expect(provider.unreadCount, 0);
    expect(find.text('You’re all caught up'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('clear-notifications')));
    await tester.pumpAndSettle();
    expect(find.text('Clear all notifications?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(provider.notifications, hasLength(2));

    await tester.tap(find.byKey(const ValueKey('clear-notifications')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Clear all'));
    await tester.pumpAndSettle();
    expect(provider.notifications, isEmpty);
    expect(find.text('No notifications yet'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Home bell shows unread count and opens Notifications',
      (tester) async {
    final provider = NotificationsProvider(storage);
    await provider.addNotification(
      title: 'New lesson',
      message: 'A new lesson is ready.',
      category: NotificationCategory.learning,
    );

    await tester.pumpWidget(_homeApp(storage, provider));
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('notification-count-badge')),
        matching: find.text('1'),
      ),
      findsOneWidget,
    );

    await tester.tap(find.byIcon(Icons.notifications_none_rounded).first);
    await tester.pumpAndSettle();
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('New lesson'), findsOneWidget);

    await tester.tap(find.text('New lesson'));
    await tester.pumpAndSettle();
    expect(provider.unreadCount, 0);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('notification-count-badge')),
        matching: find.text('1'),
      ),
      findsNothing,
    );
    expect(tester.takeException(), isNull);
  });
}

Widget _notificationsApp(NotificationsProvider provider) {
  return ChangeNotifierProvider<NotificationsProvider>.value(
    value: provider,
    child: const MaterialApp(home: NotificationsScreen()),
  );
}

Widget _homeApp(StorageService storage, NotificationsProvider notifications) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SettingsProvider(storage)),
      ChangeNotifierProvider<NotificationsProvider>.value(value: notifications),
      ChangeNotifierProvider(create: (_) => LanguageProvider(storage)),
      ChangeNotifierProvider(create: (_) => CourseProvider(storage)),
      ChangeNotifierProvider(create: (_) => VocabularyProvider(storage)),
      ChangeNotifierProvider(create: (_) => QuizProvider(storage)),
      ChangeNotifierProvider(create: (_) => ProgressProvider(storage)),
    ],
    child: MaterialApp(
      home: const HomeScreen(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    ),
  );
}
