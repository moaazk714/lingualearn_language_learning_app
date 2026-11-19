enum NotificationCategory {
  reminder,
  learning,
  achievement,
  system;

  String get label => switch (this) {
        NotificationCategory.reminder => 'Reminder',
        NotificationCategory.learning => 'Learning',
        NotificationCategory.achievement => 'Achievement',
        NotificationCategory.system => 'System',
      };

  String get storageValue => name;

  static NotificationCategory fromStorage(String value) {
    return NotificationCategory.values.firstWhere(
      (category) => category.name == value,
      orElse: () => throw FormatException(
        'Unknown notification category: $value',
      ),
    );
  }
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final DateTime createdAt;
  final NotificationCategory category;
  final bool isRead;

  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.category,
    this.isRead = false,
  });

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      title: title,
      message: message,
      createdAt: createdAt,
      category: category,
      isRead: isRead ?? this.isRead,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'message': message,
        'createdAt': createdAt.toIso8601String(),
        'category': category.storageValue,
        'isRead': isRead,
      };

  factory AppNotification.fromMap(Map<String, dynamic> map) {
    final id = map['id'];
    final title = map['title'];
    final message = map['message'];
    final createdAtValue = map['createdAt'];
    final categoryValue = map['category'];
    final isRead = map['isRead'];
    final createdAt =
        createdAtValue is String ? DateTime.tryParse(createdAtValue) : null;

    if (id is! String ||
        title is! String ||
        message is! String ||
        categoryValue is! String ||
        isRead is! bool ||
        createdAt == null) {
      throw const FormatException('Invalid stored notification.');
    }

    return AppNotification(
      id: id,
      title: title,
      message: message,
      createdAt: createdAt,
      category: NotificationCategory.fromStorage(categoryValue),
      isRead: isRead,
    );
  }
}
