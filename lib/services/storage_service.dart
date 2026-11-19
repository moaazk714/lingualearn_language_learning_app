import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static StorageService? _instance;
  static SharedPreferences? _prefs;

  StorageService._();

  static Future<StorageService> getInstance() async {
    _instance ??= StorageService._();
    _prefs ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  // Keys
  static const String keyOnboardingCompleted = 'll_onboarding_completed';
  static const String keySelectedLanguage = 'll_selected_language';
  static const String keySelectedTranslationLanguage =
      'll_selected_translation_language';
  static const String keySelectedLevel = 'll_selected_level';
  static const String keyDarkMode = 'll_dark_mode';
  static const String keyDailyGoalMinutes = 'll_daily_goal_minutes';
  static const String keyTodayMinutes = 'll_today_minutes';
  static const String keyStudyMinutesByDate = 'll_study_minutes_by_date';
  static const String keyStreakDays = 'll_streak_days';
  static const String keyLastActiveDate = 'll_last_active_date';
  static const String keyLearnedWordIds = 'll_learned_word_ids';
  static const String keyFavoriteWordIds = 'll_favorite_word_ids';
  static const String keyUnlearnedWordIds = 'll_unlearned_word_ids';
  static const String keyUnfavoritedWordIds = 'll_unfavorited_word_ids';
  static const String keyCompletedLessonIds = 'll_completed_lesson_ids';
  static const String keyQuizScores = 'll_quiz_scores';
  static const String keyUnlockedBadgeIds = 'll_unlocked_badge_ids';
  static const String keyBadgeUnlockDates = 'll_badge_unlock_dates';
  static const String keySoundEnabled = 'll_sound_enabled';
  static const String keyNotificationsEnabled = 'll_notifications_enabled';
  static const String keyNotificationHistory = 'll_notification_history';
  static const String keyUserName = 'll_user_name';

  // Onboarding
  bool isOnboardingCompleted() =>
      _prefs?.getBool(keyOnboardingCompleted) ?? false;
  Future<bool> setOnboardingCompleted(bool value) async =>
      await _prefs?.setBool(keyOnboardingCompleted, value) ?? false;

  // Language & Level
  String getSelectedLanguage() =>
      _prefs?.getString(keySelectedLanguage) ?? 'es';
  Future<bool> setSelectedLanguage(String code) async =>
      await _prefs?.setString(keySelectedLanguage, code) ?? false;

  String getSelectedTranslationLanguage() =>
      _prefs?.getString(keySelectedTranslationLanguage) ?? 'ur';
  Future<bool> setSelectedTranslationLanguage(String code) async =>
      await _prefs?.setString(keySelectedTranslationLanguage, code) ?? false;

  String getSelectedLevel() =>
      _prefs?.getString(keySelectedLevel) ?? 'Beginner';
  Future<bool> setSelectedLevel(String level) async =>
      await _prefs?.setString(keySelectedLevel, level) ?? false;

  // Theme & Settings
  bool isDarkMode() => _prefs?.getBool(keyDarkMode) ?? false;
  Future<bool> setDarkMode(bool isDark) async =>
      await _prefs?.setBool(keyDarkMode, isDark) ?? false;

  bool isSoundEnabled() => _prefs?.getBool(keySoundEnabled) ?? true;
  Future<bool> setSoundEnabled(bool value) async =>
      await _prefs?.setBool(keySoundEnabled, value) ?? false;

  bool areNotificationsEnabled() =>
      _prefs?.getBool(keyNotificationsEnabled) ?? true;
  Future<bool> setNotificationsEnabled(bool value) async =>
      await _prefs?.setBool(keyNotificationsEnabled, value) ?? false;

  List<String> getNotificationHistory() =>
      _prefs?.getStringList(keyNotificationHistory) ?? [];
  Future<bool> setNotificationHistory(List<String> records) async =>
      await _prefs?.setStringList(keyNotificationHistory, records) ?? false;

  String getUserName() => _prefs?.getString(keyUserName) ?? 'Alex';
  Future<bool> setUserName(String name) async =>
      await _prefs?.setString(keyUserName, name) ?? false;

  // Learning Progress
  int getDailyGoalMinutes() => _prefs?.getInt(keyDailyGoalMinutes) ?? 20;
  Future<bool> setDailyGoalMinutes(int mins) async =>
      await _prefs?.setInt(keyDailyGoalMinutes, mins) ?? false;

  int getTodayMinutes() => _prefs?.getInt(keyTodayMinutes) ?? 0;
  Future<bool> setTodayMinutes(int mins) async =>
      await _prefs?.setInt(keyTodayMinutes, mins) ?? false;

  int getStreakDays() => _prefs?.getInt(keyStreakDays) ?? 0;
  Future<bool> setStreakDays(int days) async =>
      await _prefs?.setInt(keyStreakDays, days) ?? false;

  Map<String, int> getStudyMinutesByDate() {
    final serialized = _prefs?.getString(keyStudyMinutesByDate);
    if (serialized == null) return {};

    try {
      final decoded = jsonDecode(serialized);
      if (decoded is! Map) return {};

      return {
        for (final entry in decoded.entries)
          if (entry.key is String &&
              entry.value is num &&
              (entry.value as num) >= 0)
            entry.key as String: (entry.value as num).toInt(),
      };
    } catch (_) {
      return {};
    }
  }

  Future<bool> recordStudyMinutes(String date, int minutes) async {
    if (minutes <= 0) return false;
    final prefs = _prefs;
    if (prefs == null) return false;
    final activity = getStudyMinutesByDate();
    activity[date] = (activity[date] ?? 0) + minutes;
    final activitySaved = await prefs.setString(
      keyStudyMinutesByDate,
      jsonEncode(activity),
    );
    final todaySaved = await prefs.setInt(keyTodayMinutes, activity[date]!);
    final lastActiveSaved = await prefs.setString(keyLastActiveDate, date);
    return activitySaved && todaySaved && lastActiveSaved;
  }

  List<String> getUnlockedBadgeIds() =>
      _prefs?.getStringList(keyUnlockedBadgeIds) ?? [];
  Future<bool> setUnlockedBadgeIds(List<String> ids) async =>
      await _prefs?.setStringList(keyUnlockedBadgeIds, ids) ?? false;

  Map<String, String> getBadgeUnlockDates() {
    final serialized = _prefs?.getString(keyBadgeUnlockDates);
    if (serialized == null) return {};

    try {
      final decoded = jsonDecode(serialized);
      if (decoded is! Map) return {};

      return {
        for (final entry in decoded.entries)
          if (entry.key is String && entry.value is String)
            entry.key as String: entry.value as String,
      };
    } catch (_) {
      return {};
    }
  }

  Future<bool> setBadgeUnlockDates(Map<String, String> dates) async =>
      await _prefs?.setString(keyBadgeUnlockDates, jsonEncode(dates)) ?? false;

  String? getLastActiveDate() => _prefs?.getString(keyLastActiveDate);
  Future<bool> setLastActiveDate(String dateIso) async =>
      await _prefs?.setString(keyLastActiveDate, dateIso) ?? false;

  // Learned Words
  List<String> getLearnedWordIds() =>
      _prefs?.getStringList(keyLearnedWordIds) ?? [];
  Future<bool> setLearnedWordIds(List<String> ids) async =>
      await _prefs?.setStringList(keyLearnedWordIds, ids) ?? false;
  List<String> getUnlearnedWordIds() =>
      _prefs?.getStringList(keyUnlearnedWordIds) ?? [];
  Future<bool> setUnlearnedWordIds(List<String> ids) async =>
      await _prefs?.setStringList(keyUnlearnedWordIds, ids) ?? false;

  // Favorites
  List<String> getFavoriteWordIds() =>
      _prefs?.getStringList(keyFavoriteWordIds) ?? [];
  Future<bool> setFavoriteWordIds(List<String> ids) async =>
      await _prefs?.setStringList(keyFavoriteWordIds, ids) ?? false;
  List<String> getUnfavoritedWordIds() =>
      _prefs?.getStringList(keyUnfavoritedWordIds) ?? [];
  Future<bool> setUnfavoritedWordIds(List<String> ids) async =>
      await _prefs?.setStringList(keyUnfavoritedWordIds, ids) ?? false;

  // Completed Lessons
  List<String> getCompletedLessonIds() =>
      _prefs?.getStringList(keyCompletedLessonIds) ?? [];
  Future<bool> setCompletedLessonIds(List<String> ids) async =>
      await _prefs?.setStringList(keyCompletedLessonIds, ids) ?? false;

  // Quiz Scores
  List<Map<String, dynamic>> getQuizScores() {
    final list = _prefs?.getStringList(keyQuizScores) ?? [];
    return list.map((item) {
      try {
        return jsonDecode(item) as Map<String, dynamic>;
      } catch (_) {
        return <String, dynamic>{};
      }
    }).toList();
  }

  Future<bool> saveQuizScore(Map<String, dynamic> scoreData) async {
    final list = _prefs?.getStringList(keyQuizScores) ?? [];
    list.add(jsonEncode(scoreData));
    return await _prefs?.setStringList(keyQuizScores, list) ?? false;
  }

  // Clear / Reset All Data
  Future<bool> clearAllData() async {
    return await _prefs?.clear() ?? false;
  }
}
