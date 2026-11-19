import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimensions.dart';
import '../models/user_progress_model.dart';

class WeeklyActivityChart extends StatelessWidget {
  final List<DailyActivityModel> activities;
  final VoidCallback? onDetailsTap;

  const WeeklyActivityChart({
    super.key,
    required this.activities,
    this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: AppDimensions.roundedHero,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
          width: 1,
        ),
        boxShadow: isDark ? null : AppDimensions.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: AppDimensions.space4,
            children: [
              Text(
                'Weekly Activity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                ),
              ),
              Text(
                'Target: 7/7 Days',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.space24),

          // 7-Day Pill Bars
          LayoutBuilder(
            builder: (context, constraints) {
              final barWidth = activities.isEmpty
                  ? 0.0
                  : (constraints.maxWidth / activities.length).clamp(0.0, 36.0);
              return SizedBox(
                height: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: activities.map((item) {
                    return _buildPillBar(context, item, isDark, barWidth);
                  }).toList(),
                ),
              );
            },
          ),

          const SizedBox(height: AppDimensions.space18),

          // Bottom Achievement Pill Banner
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceTertiaryDark.withValues(alpha: 0.6)
                  : const Color(0xFFF0FDF4),
              borderRadius: AppDimensions.roundedPill,
              border: Border.all(
                color: isDark
                    ? AppColors.borderDark
                    : AppColors.success.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 13,
                  ),
                ),

                const SizedBox(width: AppDimensions.space10),

                Expanded(
                  child: Text(
                    'Daily goal reached 5 days in a row!',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF166534),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Details Link
                if (onDetailsTap != null)
                  InkWell(
                    onTap: onDetailsTap,
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillBar(
    BuildContext context,
    DailyActivityModel item,
    bool isDark,
    double barWidth,
  ) {
    // Dynamic height based on minutes (max 30 mins)
    double barHeight = 18.0;

    if (item.minutes > 0) {
      barHeight = (item.minutes / 30.0 * 70.0).clamp(24.0, 75.0);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Bar Pill
        Container(
          width: barWidth,
          height: barHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: item.isCurrentDay ? AppColors.activeBarGradient : null,
            color: item.isCurrentDay
                ? null
                : item.isCompleted
                    ? (isDark
                        ? const Color(0xFF373468)
                        : const Color(0xFFDED9F8))
                    : (isDark
                        ? AppColors.surfaceSecondaryDark
                        : const Color(0xFFECEEF2)),
          ),
          child: Center(
            child: item.isCurrentDay
                ? const Icon(
                    Icons.bolt_rounded,
                    color: Colors.white,
                    size: 18,
                  )
                : item.isCompleted
                    ? const Icon(
                        Icons.check_rounded,
                        color: AppColors.primary,
                        size: 16,
                      )
                    : null,
          ),
        ),

        const SizedBox(height: AppDimensions.space8),

        // Day Label
        Text(
          item.dayLabel,
          style: TextStyle(
            fontSize: 12,
            fontWeight: item.isCurrentDay ? FontWeight.w700 : FontWeight.w500,
            color: item.isCurrentDay
                ? AppColors.primary
                : (isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
