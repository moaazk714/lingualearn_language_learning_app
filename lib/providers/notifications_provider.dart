import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/app_notification.dart';
import '../services/storage_service.dart';

class NotificationsProvider extends ChangeNotifier {
  final StorageService _storageService;
  final List<AppNotification> _notifications = [];
  Future<void> _operationQueue = Future<void>.value();
  int _idSequence = 0;

  NotificationsProvider(this._storageService) {
    for (final record in _storageService.getNotificationHistory()) {
      try {
        final decoded = jsonDecode(record);
        if (decoded is! Map<String, dynamic>) {
          throw const FormatException('Invalid stored notification record.');
        }
        _notifications.add(AppNotification.fromMap(decoded));
      } on FormatException catch (error, stackTrace) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: error,
            stack: stackTrace,
            library: 'LinguaLearn notifications',
            context: ErrorDescription('while reading saved notification data'),
          ),
        );
      }
    }
    _sortNewestFirst();
  }

  List<AppNotification> get notifications =>
      List<AppNotification>.unmodifiable(_notifications);

  int get unreadCount =>
      _notifications.where((notification) => !notification.isRead).length;

  Future<void> addNotification({
    required String title,
    required String message,
    required NotificationCategory category,
    DateTime? createdAt,
  }) {
    if (title.trim().isEmpty) {
      throw ArgumentError.value(title, 'title', 'Must not be empty.');
    }
    if (message.trim().isEmpty) {
      throw ArgumentError.value(message, 'message', 'Must not be empty.');
    }

    return _runSerialized(() async {
      final timestamp = createdAt ?? DateTime.now();
      final notification = AppNotification(
        id: '${timestamp.microsecondsSinceEpoch}-${_idSequence++}',
        title: title.trim(),
        message: message.trim(),
        createdAt: timestamp,
        category: category,
      );
      final updated = [notification, ..._notifications];
      _sortNotifications(updated);
      await _save(updated);
      _notifications
        ..clear()
        ..addAll(updated);
      notifyListeners();
    });
  }

  Future<void> markAsRead(String id) {
    return _runSerialized(() async {
      final index = _notifications.indexWhere(
        (notification) => notification.id == id,
      );
      if (index == -1 || _notifications[index].isRead) return;

      final updated = List<AppNotification>.of(_notifications);
      updated[index] = updated[index].copyWith(isRead: true);
      await _save(updated);
      _notifications
        ..clear()
        ..addAll(updated);
      notifyListeners();
    });
  }

  Future<void> markAllAsRead() {
    return _runSerialized(() async {
      if (unreadCount == 0) return;
      final updated = _notifications
          .map((notification) => notification.copyWith(isRead: true))
          .toList();
      await _save(updated);
      _notifications
        ..clear()
        ..addAll(updated);
      notifyListeners();
    });
  }

  Future<void> clearAll() {
    return _runSerialized(() async {
      if (_notifications.isEmpty) return;
      if (!await _storageService.setNotificationHistory(const [])) {
        throw StateError('Unable to clear saved notifications.');
      }
      _notifications.clear();
      notifyListeners();
    });
  }

  Future<void> _save(List<AppNotification> notifications) async {
    final records = notifications
        .map((notification) => jsonEncode(notification.toMap()))
        .toList();
    if (!await _storageService.setNotificationHistory(records)) {
      throw StateError('Unable to save notification history.');
    }
  }

  Future<void> _runSerialized(Future<void> Function() operation) {
    final previous = _operationQueue;
    final completion = Completer<void>();
    _operationQueue = completion.future;

    return _runAfter(previous, completion, operation);
  }

  Future<void> _runAfter(
    Future<void> previous,
    Completer<void> completion,
    Future<void> Function() operation,
  ) async {
    await previous;
    try {
      await operation();
    } finally {
      completion.complete();
    }
  }

  void _sortNewestFirst() => _sortNotifications(_notifications);

  void _sortNotifications(List<AppNotification> notifications) {
    notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}
