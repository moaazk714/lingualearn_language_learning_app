import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../models/user_progress_model.dart';
import '../../providers/course_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/progress_provider.dart';
import '../../widgets/weekly_activity_chart.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progressProvider = context.watch<ProgressProvider>();
    final courseProvider = context.watch<CourseProvider>();
    final langProvider = context.watch<LanguageProvider>();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text('Learning Statistics'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: [
            // Daily Goal Hero Ring Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                gradient: AppColors.heroGradient,
                borderRadius: AppDimensions.roundedHero,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircularPercentIndicator(
                    radius: 46.0,
                    lineWidth: 8.0,
                    percent: progressProvider.goalProgress,
                    center: Text(
                      '${progressProvider.goalPercent}%',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    progressColor: AppColors.success,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  const SizedBox(width: AppDimensions.space20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Today's Habit Target",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.space4),
                        Text(
                          '${progressProvider.todayMinutes} of ${progressProvider.goalMinutes} minutes completed',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                        const SizedBox(height: AppDimensions.space8),
                        Text(
                          progressProvider.remainingMinutes == 0
                              ? '🎯 Daily target achieved!'
                              : '⏳ ${progressProvider.remainingMinutes} minutes to reach daily goal',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: progressProvider.remainingMinutes == 0
                                ? AppColors.successSoft
                                : Colors.white.withValues(alpha: 0.95),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.space20),

            // 4 Key Statistics Grid (Streak, Words, Lessons, Total Time)
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    'Current Streak',
                    '${progressProvider.streakDays} Days',
                    Icons.local_fire_department_rounded,
                    AppColors.streak,
                    isDark,
                  ),
                ),
                const SizedBox(width: AppDimensions.space12),
                Expanded(
                  child: _buildMetricTile(
                    'Words Mastered',
                    '${progressProvider.masteredWords}/${progressProvider.totalVocabulary}',
                    Icons.translate_rounded,
                    AppColors.primary,
                    isDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.space12),
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    'Lessons Done',
                    '${courseProvider.currentCourse.completedLessons}',
                    Icons.school_rounded,
                    AppColors.success,
                    isDark,
                  ),
                ),
                const SizedBox(width: AppDimensions.space12),
                Expanded(
                  child: _buildMetricTile(
                    'Total Minutes',
                    '${progressProvider.totalStudyMinutes}m',
                    Icons.timer_rounded,
                    const Color(0xFF8B5CF6),
                    isDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.space12),
            Row(
              children: [
                Expanded(
                  child: _buildMetricTile(
                    'Quiz Attempts',
                    '${progressProvider.quizAttempts}',
                    Icons.quiz_rounded,
                    AppColors.primary,
                    isDark,
                  ),
                ),
                const SizedBox(width: AppDimensions.space12),
                Expanded(
                  child: _buildMetricTile(
                    'Best Quiz Score',
                    '${progressProvider.bestQuizScore.toStringAsFixed(0)}%',
                    Icons.stars_rounded,
                    AppColors.success,
                    isDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.space24),

            // Weekly Activity Pill Chart
            // Weekly Activity Pill Chart
            WeeklyActivityChart(
              activities: progressProvider.weeklyActivity,
            ),
            const SizedBox(height: AppDimensions.space24),

            // Course Completion Overview Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: AppDimensions.roundedCard,
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
                ),
                boxShadow: isDark ? null : AppDimensions.cardShadow,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Course Progress (${langProvider.selectedLanguage.name})',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '${(courseProvider.currentCourse.overallProgress * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.space12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: courseProvider.currentCourse.overallProgress,
                      backgroundColor: isDark
                          ? AppColors.surfaceSecondaryDark
                          : const Color(0xFFE5E3F8),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.space12),
                  Text(
                    '${courseProvider.currentCourse.completedLessons} of ${courseProvider.currentCourse.totalLessons} lessons finished across ${courseProvider.currentCourse.units.length} units.',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.space24),

            // Achievement Badges Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Achievements & Badges',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${progressProvider.badges.where((b) => b.isUnlocked).length} / ${progressProvider.badges.length} Unlocked',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.space12),

            ...progressProvider.badges.map((badge) {
              return _buildBadgeTile(context, badge, isDark);
            }),

            const SizedBox(height: AppDimensions.space32),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile(
    String label,
    String value,
    IconData icon,
    Color color,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
        ),
        boxShadow: isDark ? null : AppDimensions.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: AppDimensions.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeTile(BuildContext context, BadgeModel badge, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: badge.isUnlocked
              ? AppColors.primary.withValues(alpha: 0.3)
              : (isDark ? AppColors.borderDark : AppColors.borderSubtle),
        ),
        boxShadow: isDark ? null : AppDimensions.cardShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: badge.isUnlocked
                  ? (isDark
                      ? AppColors.surfaceTertiaryDark
                      : const Color(0xFFF0EDFD))
                  : (isDark
                      ? AppColors.surfaceSecondaryDark
                      : const Color(0xFFF3F4F6)),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                badge.iconEmoji,
                style: TextStyle(
                  fontSize: 22,
                  color: badge.isUnlocked ? null : Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.space14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      badge.title,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                      ),
                    ),
                    if (badge.isUnlocked) ...[
                      const SizedBox(width: AppDimensions.space6),
                      const Icon(Icons.check_circle,
                          size: 14, color: AppColors.success),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  badge.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              badge.isUnlocked ? 'Unlocked' : 'Locked',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: badge.isUnlocked
                    ? AppColors.successDark
                    : AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
