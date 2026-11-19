import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimensions.dart';

class LinguaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? badgeText;
  final VoidCallback? onNotificationTap;
  final int notificationCount;
  final VoidCallback? onProfileTap;

  const LinguaAppBar({
    super.key,
    this.title = 'LinguaLearn',
    this.badgeText = 'Home Dashboard',
    this.onNotificationTap,
    this.notificationCount = 0,
    this.onProfileTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64.0);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final showBadge =
                    badgeText != null && constraints.maxWidth >= 325;
                return Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: AppColors.heroGradient,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'L',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.space10),
                    Flexible(
                      flex: showBadge ? 2 : 1,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                    if (showBadge) ...[
                      const SizedBox(width: AppDimensions.space6),
                      Flexible(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.surfaceSecondaryDark
                                : AppColors.primarySoft,
                            borderRadius: AppDimensions.roundedPill,
                          ),
                          child: Text(
                            badgeText!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                    IconButton(
                      tooltip: 'Notifications',
                      icon: Badge(
                        key: const ValueKey('notification-count-badge'),
                        isLabelVisible: notificationCount > 0,
                        backgroundColor: AppColors.error,
                        textColor: Colors.white,
                        label: Text(
                          notificationCount > 99 ? '99+' : '$notificationCount',
                        ),
                        child: Icon(
                          Icons.notifications_none_rounded,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                          size: 24,
                        ),
                      ),
                      onPressed: onNotificationTap,
                      splashRadius: 22,
                    ),
                    GestureDetector(
                      onTap: onProfileTap,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.avatarRingGradient,
                        ),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: isDark
                              ? AppColors.surfaceSecondaryDark
                              : Colors.white,
                          child: const Text(
                            '🧑‍💻',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
