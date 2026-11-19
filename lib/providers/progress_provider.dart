import 'dart:async';
import 'package:flutter/foundation.dart';
import '../core/data/app_mock_data.dart';
import '../models/user_progress_model.dart';
import '../models/vocabulary_model.dart';
import '../models/quiz_model.dart';
import '../providers/course_provider.dart';
import '../providers/language_provider.dart';
import '../providers/quiz_provider.dart';
import '../providers/vocabulary_provider.dart';
import '../services/storage_service.dart';

class ProgressProvider with ChangeNotifier {
  final StorageService _storageService;

  LanguageProvider? _languageProvider;
  VocabularyProvider? _vocabularyProvider;
  QuizProvider? _quizProvider;
  CourseProvider? _courseProvider;

  late int _todayMinutes;
  late int _goalMinutes;
  late int _masteredWords;
  late int _totalVocabulary;
  late int _quizAttempts;
  late double _bestQuizScore;
  late int _streakDays;
  late int _streakFreezes;
  late List<DailyActivityModel> _weeklyActivity;
  late List<BadgeModel> _badges;
  late Map<String, int> _activityByDate;
  late Set<String> _unlockedBadgeIds;
  late Map<String, String> _badgeUnlockDates;

  static const int _maxStreakFreezes = 2;
  static const _languageCodes = ['es', 'fr', 'de', 'ja', 'en', 'ar'];

  ProgressProvider(this._storageService) {
    _init();
  }

  void reset() {
    _languageProvider = null;
    _vocabularyProvider = null;
    _quizProvider = null;
    _courseProvider = null;
    _init();
    notifyListeners();
  }

  void _init() {
    final storedGoal = _storageService.getDailyGoalMinutes();
    _goalMinutes = storedGoal > 0 ? storedGoal : 20;
    _activityByDate = _storageService.getStudyMinutesByDate();
    _unlockedBadgeIds = _storageService.getUnlockedBadgeIds().toSet();
    _badgeUnlockDates = _storageService.getBadgeUnlockDates();
    _streakFreezes = 0;
    _refreshDailyActivity();
    _refreshDerivedStats();
    _refreshBadges();
  }

  int get streakDays => _streakDays;
  int get streakFreezes => _streakFreezes;
  int get maxStreakFreezes => _maxStreakFreezes;
  int get todayMinutes => _todayMinutes;
  int get totalStudyMinutes =>
      _activityByDate.values.fold(0, (total, minutes) => total + minutes);
  int get goalMinutes => _goalMinutes;
  int get masteredWords => _masteredWords;
  int get totalVocabulary => _totalVocabulary;
  double get vocabularyProgress =>
      _totalVocabulary == 0 ? 0 : _masteredWords / _totalVocabulary;
  int get vocabularyCompletionPercent => (vocabularyProgress * 100).round();
  int get quizAttempts => _quizAttempts;
  double get bestQuizScore => _bestQuizScore;
  List<DailyActivityModel> get weeklyActivity =>
      List.unmodifiable(_weeklyActivity);
  List<BadgeModel> get badges => List.unmodifiable(_badges);

  double get goalProgress {
    if (_goalMinutes <= 0) return 0;
    return (_todayMinutes / _goalMinutes).clamp(0.0, 1.0);
  }

  int get goalPercent => (goalProgress * 100).toInt();

  int get remainingMinutes =>
      _todayMinutes >= _goalMinutes ? 0 : _goalMinutes - _todayMinutes;

  void updateSources(
    LanguageProvider languageProvider,
    VocabularyProvider vocabularyProvider,
    QuizProvider quizProvider,
    CourseProvider courseProvider,
  ) {
    _languageProvider = languageProvider;
    _vocabularyProvider = vocabularyProvider;
    _quizProvider = quizProvider;
    _courseProvider = courseProvider;

    final oldLanguageTotal = _totalVocabulary;
    final oldMastered = _masteredWords;
    final oldQuizAttempts = _quizAttempts;
    final oldBestQuizScore = _bestQuizScore;
    _refreshDerivedStats();
    final badgesChanged = _refreshBadges();

    if (oldLanguageTotal != _totalVocabulary ||
        oldMastered != _masteredWords ||
        oldQuizAttempts != _quizAttempts ||
        oldBestQuizScore != _bestQuizScore ||
        badgesChanged) {
      notifyListeners();
    }
  }

  Future<void> addStudyMinutes(int minutes) async {
    if (minutes <= 0) {
      throw ArgumentError.value(minutes, 'minutes', 'Must be greater than 0');
    }

    final today = _dateKey(DateTime.now());
    if (!await _storageService.recordStudyMinutes(today, minutes)) {
      throw StateError("Unable to persist today's study activity.");
    }

    _activityByDate[today] = (_activityByDate[today] ?? 0) + minutes;
    _refreshDailyActivity();
    _refreshBadges();
    notifyListeners();
  }

  Future<void> setDailyGoal(int minutes) async {
    if (minutes <= 0) {
      throw ArgumentError.value(minutes, 'minutes', 'Must be greater than 0');
    }
    if (minutes == _goalMinutes) return;
    if (!await _storageService.setDailyGoalMinutes(minutes)) {
      throw StateError('Unable to persist the daily learning goal.');
    }

    _goalMinutes = minutes;
    _refreshDailyActivity();
    notifyListeners();
  }

  void _refreshDerivedStats() {
    final languageCode = _languageProvider?.selectedLanguage.id ??
        _storageService.getSelectedLanguage();
    final words = _wordsForLanguage(languageCode);
    _totalVocabulary = words.length;
    _masteredWords = words
        .where((word) => word.isLearned)
        .length
        .clamp(0, words.length)
        .toInt();

    final quizResults =
        _storageService.getQuizScores().map(QuizResultModel.fromMap).toList();
    _quizAttempts = quizResults.length;
    _bestQuizScore = quizResults.fold<double>(
      0,
      (best, result) => result.scorePercentage > best
          ? result.scorePercentage.clamp(0, 100).toDouble()
          : best,
    );
    final latestResult = _quizProvider?.lastResult;
    if (latestResult != null && latestResult.scorePercentage > _bestQuizScore) {
      _bestQuizScore = latestResult.scorePercentage.clamp(0, 100).toDouble();
    }
  }

  List<VocabularyModel> _wordsForLanguage(String languageCode) {
    final provider = _vocabularyProvider;
    if (provider != null) return provider.wordsForLanguage(languageCode);

    final source = switch (languageCode) {
      'fr' => AppMockData.frenchVocabulary,
      'de' => AppMockData.germanVocabulary,
      'ja' => AppMockData.japaneseVocabulary,
      'en' => AppMockData.englishVocabulary,
      'ar' => AppMockData.arabicVocabulary,
      _ => AppMockData.spanishVocabulary,
    };
    final learnedIds = _storageService.getLearnedWordIds().toSet();
    final unlearnedIds = _storageService.getUnlearnedWordIds().toSet();
    return source
        .map(
          (word) => word.copyWith(
            isLearned: !unlearnedIds.contains(word.id) &&
                (learnedIds.contains(word.id) || word.isLearned),
          ),
        )
        .toList();
  }

  void _refreshDailyActivity() {
    final today = DateTime.now();
    _todayMinutes = _activityByDate[_dateKey(today)] ?? 0;
    _streakDays = _calculateStreak(today);

    _weeklyActivity = List.generate(7, (index) {
      final date = DateTime(today.year, today.month, today.day)
          .subtract(Duration(days: 6 - index));
      final minutes = _activityByDate[_dateKey(date)] ?? 0;
      return DailyActivityModel(
        dayLabel: _weekdayLabels[date.weekday - 1],
        minutes: minutes,
        isCompleted: minutes >= _goalMinutes,
        isCurrentDay: index == 6,
      );
    });
  }

  int _calculateStreak(DateTime today) {
    var date = DateTime(today.year, today.month, today.day);
    if ((_activityByDate[_dateKey(date)] ?? 0) == 0) {
      date = date.subtract(const Duration(days: 1));
    }

    var streak = 0;
    while ((_activityByDate[_dateKey(date)] ?? 0) > 0) {
      streak++;
      date = date.subtract(const Duration(days: 1));
    }
    return streak;
  }

  bool _refreshBadges() {
    final definitions = AppMockData.sampleBadges;
    final learnedLanguages = _languageCodes
        .where(
          (code) => _wordsForLanguage(code).any((word) => word.isLearned),
        )
        .length;
    final earnedBadges = <String, bool>{
      'b_streak_5': _streakDays >= 5,
      'b_vocab_100': _masteredWords >= 100,
      'b_perfect_quiz': _bestQuizScore >= 100,
      'b_cafe_master': _cafeUnitProgress >= 0.5,
      'b_polyglot': learnedLanguages >= 3,
      'b_streak_30': _streakDays >= 30,
    };

    var changed = false;
    for (final badge in definitions) {
      if (earnedBadges[badge.id] == true && _unlockedBadgeIds.add(badge.id)) {
        _badgeUnlockDates[badge.id] = DateTime.now().toIso8601String();
        changed = true;
      }
    }

    _badges = definitions.map((badge) {
      final unlockedAt = DateTime.tryParse(_badgeUnlockDates[badge.id] ?? '');
      return badge.copyWith(
        isUnlocked: _unlockedBadgeIds.contains(badge.id),
        unlockedAt: unlockedAt,
      );
    }).toList();

    if (changed) unawaited(_persistBadges());
    return changed;
  }

  double get _cafeUnitProgress {
    final course = _courseProvider?.currentCourse;
    if (course == null) return 0;
    for (final unit in course.units) {
      final title = unit.title.toLowerCase();
      if (title.contains('café') || title.contains('cafe')) {
        return unit.progressPercentage;
      }
    }
    return 0;
  }

  Future<void> _persistBadges() async {
    final idsSaved =
        await _storageService.setUnlockedBadgeIds(_unlockedBadgeIds.toList());
    final datesSaved =
        await _storageService.setBadgeUnlockDates(_badgeUnlockDates);
    if (!idsSaved || !datesSaved) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: StateError('Unable to persist earned badges.'),
          library: 'LinguaLearn progress',
        ),
      );
    }
  }

  static const _weekdayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  static String _dateKey(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}
