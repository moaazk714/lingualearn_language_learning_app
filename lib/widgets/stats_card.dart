import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimensions.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Widget? icon;
  final double? circularProgress;
  final Color? subtitleColor;
  final VoidCallback? onTap;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    this.icon,
    this.circularProgress,
    this.subtitleColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: isDark ? AppColors.surfaceDark : AppColors.surface,
      borderRadius: AppDimensions.roundedCard,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDimensions.roundedCard,
        child: Container(
          width: 140,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: AppDimensions.roundedCard,
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
              width: 1,
            ),
            boxShadow: isDark ? null : AppDimensions.cardShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Row: Title + Icon / Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  if (circularProgress != null)
                    CircularPercentIndicator(
                      radius: 14.0,
                      lineWidth: 3.0,
                      percent: circularProgress!.clamp(0.0, 1.0),
                      progressColor: AppColors.primary,
                      backgroundColor: AppColors.primarySoft,
                      center: Text(
                        '${(circularProgress! * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  else if (icon != null)
                    icon!,
                ],
              ),
              const SizedBox(height: AppDimensions.space8),

              // Middle: Bold Value
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: AppDimensions.space6),

              // Bottom: Subtitle with icon or indicator
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: subtitleColor ??
                      (isDark
                          ? AppColors.textMutedDark
                          : AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
