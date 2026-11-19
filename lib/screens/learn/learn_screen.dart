import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../models/course_model.dart';
import '../../models/lesson_model.dart';
import '../../providers/course_provider.dart';
import '../../providers/language_provider.dart';
import '../../widgets/learning_translation_text.dart';
import '../../app/routes.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final courseProvider = context.watch<CourseProvider>();
    final langProvider = context.watch<LanguageProvider>();
    final course = courseProvider.currentCourse;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text('Structured Courses'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceSecondaryDark
                  : AppColors.primarySoft,
              borderRadius: AppDimensions.roundedPill,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  langProvider.selectedLanguage.flagEmoji,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: AppDimensions.space6),
                Text(
                  langProvider.selectedLanguage.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: [
            // Overall Course Progress Hero Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: AppDimensions.roundedPill,
                        ),
                        child: Text(
                          course.level.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      Text(
                        '${(course.overallProgress * 100).toInt()}% Total Progress',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.space12),
                  LearningTranslationText(
                    text: course.title,
                    sourceLanguageCode: 'en',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.space4),
                  LearningTranslationText(
                    text: course.description,
                    sourceLanguageCode: 'en',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.space16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: course.overallProgress.clamp(0.05, 1.0),
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.success,
                      ),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.space12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${course.completedLessons} of ${course.totalLessons} Lessons Completed',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.space24),

            // Units Breakdown
            ...course.units.map((unit) {
              return _buildUnitSection(context, unit, isDark);
            }),

            const SizedBox(height: AppDimensions.space32),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitSection(
    BuildContext context,
    UnitModel unit,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
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
          // Unit Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: unit.isCompleted
                        ? AppColors.successSoft
                        : (isDark
                            ? AppColors.surfaceSecondaryDark
                            : AppColors.primarySoft),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'U${unit.unitNumber}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: unit.isCompleted
                            ? AppColors.successDark
                            : AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        unit.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.space2),
                      Text(
                        unit.description,
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
                Text(
                  '${(unit.progressPercentage * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.borderSubtle),

          // Lessons List inside Unit
          ...unit.lessons.map((lesson) {
            return _buildLessonTile(context, lesson, isDark);
          }),
        ],
      ),
    );
  }

  Widget _buildLessonTile(
    BuildContext context,
    LessonModel lesson,
    bool isDark,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (lesson.isLocked) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('🔒 Complete previous lessons to unlock this one!'),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else {
            Navigator.pushNamed(
              context,
              AppRoutes.lessonDetails,
              arguments: lesson,
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              // Status Icon Indicator
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: lesson.isCompleted
                      ? AppColors.successSoft
                      : lesson.isLocked
                          ? (isDark
                              ? AppColors.surfaceSecondaryDark
                              : const Color(0xFFF3F4F6))
                          : AppColors.primarySoft,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  lesson.isCompleted
                      ? Icons.check_circle_rounded
                      : lesson.isLocked
                          ? Icons.lock_rounded
                          : Icons.play_arrow_rounded,
                  size: 18,
                  color: lesson.isCompleted
                      ? AppColors.success
                      : lesson.isLocked
                          ? (isDark
                              ? AppColors.textMutedDark
                              : const Color(0xFF9CA3AF))
                          : AppColors.primary,
                ),
              ),
              const SizedBox(width: AppDimensions.space12),

              // Title & Duration
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${lesson.lessonNumber}. ${lesson.title}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: lesson.isLocked
                            ? (isDark
                                ? AppColors.textMutedDark
                                : AppColors.textMuted)
                            : (isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimary),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.space2),
                    Text(
                      '~${lesson.durationMinutes} mins • ${lesson.objectives.length} objectives',
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

              // Chevron or lock
              Icon(
                lesson.isLocked
                    ? Icons.lock_outline_rounded
                    : Icons.chevron_right_rounded,
                size: 20,
                color:
                    isDark ? AppColors.textMutedDark : const Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
