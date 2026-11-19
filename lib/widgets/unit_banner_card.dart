import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimensions.dart';
import '../models/lesson_model.dart';
import '../models/course_model.dart';

class UnitBannerCard extends StatelessWidget {
  final UnitModel unit;
  final LessonModel lesson;
  final VoidCallback onResume;

  const UnitBannerCard({
    super.key,
    required this.unit,
    required this.lesson,
    required this.onResume,
  });

  @override
  Widget build(BuildContext context) {
    final progress = unit.progressPercentage;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        borderRadius: AppDimensions.roundedHero,
        gradient: AppColors.heroGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            offset: const Offset(0, 10),
            blurRadius: 24,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Badges Row
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.20),
                  borderRadius: AppDimensions.roundedPill,
                ),
                child: const Text(
                  'CURRENT UNIT',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.space8),
              Expanded(
                child: Text(
                  '${(progress * 100).toInt()}% Completed',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.space12),

          // Unit Title
          Text(
            unit.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: AppDimensions.space4),

          // Lesson Details
          Text(
            'Lesson ${lesson.lessonNumber} of ${unit.lessons.length} • ${lesson.title}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: AppDimensions.space16),

          // Progress Bar (Bright Lime Green)
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 6,
              child: LinearProgressIndicator(
                value: progress.clamp(0.05, 1.0),
                backgroundColor: const Color(0xFF26207E).withValues(alpha: 0.6),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.success, // Lime Green #22C55E
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.space16),

          // Bottom Action Row
          LayoutBuilder(
            builder: (context, constraints) {
              final durationLabel = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 15,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                  const SizedBox(width: AppDimensions.space6),
                  Flexible(
                    child: Text(
                      '~${lesson.durationMinutes} min remaining',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                ],
              );
              final resumeButton = Material(
                color: Colors.white,
                borderRadius: AppDimensions.roundedPill,
                elevation: 0,
                child: InkWell(
                  onTap: onResume,
                  borderRadius: AppDimensions.roundedPill,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 9,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: AppDimensions.space4),
                        Text(
                          'Resume',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );

              if (constraints.maxWidth < 300) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    durationLabel,
                    const SizedBox(height: AppDimensions.space8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: resumeButton,
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: durationLabel),
                  resumeButton,
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
