class DailyActivityModel {
  final String dayLabel; // M, T, W, T, F, S, S
  final int minutes;
  final bool isCompleted;
  final bool isCurrentDay;

  const DailyActivityModel({
    required this.dayLabel,
    required this.minutes,
    required this.isCompleted,
    this.isCurrentDay = false,
  });
}

class BadgeModel {
  final String id;
  final String title;
  final String description;
  final String iconEmoji;
  final bool isUnlocked;
  final DateTime? unlockedAt;

  const BadgeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconEmoji,
    this.isUnlocked = false,
    this.unlockedAt,
  });

  BadgeModel copyWith({
    String? id,
    String? title,
    String? description,
    String? iconEmoji,
    bool? isUnlocked,
    DateTime? unlockedAt,
  }) {
    return BadgeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      iconEmoji: iconEmoji ?? this.iconEmoji,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }
}

class UserProgressModel {
  final int streakDays;
  final int streakFreezes;
  final int maxStreakFreezes;
  final int todayMinutes;
  final int goalMinutes;
  final int masteredWords;
  final List<DailyActivityModel> weeklyActivity;
  final List<BadgeModel> badges;

  const UserProgressModel({
    required this.streakDays,
    required this.streakFreezes,
    required this.maxStreakFreezes,
    required this.todayMinutes,
    required this.goalMinutes,
    required this.masteredWords,
    required this.weeklyActivity,
    required this.badges,
  });

  double get goalProgress {
    if (goalMinutes == 0) return 0.0;
    final progress = todayMinutes / goalMinutes;
    return progress > 1.0 ? 1.0 : progress;
  }

  int get remainingMinutes =>
      todayMinutes >= goalMinutes ? 0 : goalMinutes - todayMinutes;
}
