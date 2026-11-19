import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../models/app_notification.dart';
import '../../providers/notifications_provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  Future<void> _confirmClear(
    BuildContext context,
    NotificationsProvider provider,
  ) async {
    final shouldClear = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear all notifications?'),
        content: const Text(
          'This will permanently remove your saved notification history.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear all'),
          ),
        ],
      ),
    );
    if (shouldClear == true) {
      await provider.clearAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final notifications = context.watch<NotificationsProvider>();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (notifications.unreadCount > 0)
            IconButton(
              key: const ValueKey('mark-all-notifications-read'),
              tooltip: 'Mark all as read',
              onPressed: notifications.markAllAsRead,
              icon: const Icon(Icons.done_all_rounded),
            ),
          if (notifications.notifications.isNotEmpty)
            IconButton(
              key: const ValueKey('clear-notifications'),
              tooltip: 'Clear all notifications',
              onPressed: () => _confirmClear(context, notifications),
              icon: const Icon(Icons.delete_outline_rounded),
            ),
        ],
      ),
      body: notifications.notifications.isEmpty
          ? const _EmptyNotifications()
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              children: [
                _UnreadSummary(count: notifications.unreadCount),
                const SizedBox(height: AppDimensions.space16),
                for (final notification in notifications.notifications)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDimensions.space10,
                    ),
                    child: _NotificationCard(
                      notification: notification,
                      isDark: isDark,
                    ),
                  ),
              ],
            ),
    );
  }
}

class _UnreadSummary extends StatelessWidget {
  final int count;

  const _UnreadSummary({required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            count == 0 ? 'You’re all caught up' : '$count unread',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final AppNotification notification;
  final bool isDark;

  const _NotificationCard({
    required this.notification,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NotificationsProvider>();
    final materialLocalizations = MaterialLocalizations.of(context);
    final localDate = notification.createdAt.toLocal();
    final date = materialLocalizations.formatMediumDate(localDate);
    final time = materialLocalizations.formatTimeOfDay(
      TimeOfDay.fromDateTime(localDate),
    );
    final color = _categoryColor(notification.category);
    final background = notification.isRead
        ? (isDark ? AppColors.surfaceDark : Colors.white)
        : (isDark
            ? AppColors.surfaceSecondaryDark
            : AppColors.primarySoft.withValues(alpha: 0.65));

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        key: ValueKey('notification-${notification.id}'),
        borderRadius: BorderRadius.circular(18),
        onTap: notification.isRead
            ? null
            : () => provider.markAsRead(notification.id),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: notification.isRead
                  ? (isDark ? AppColors.borderDark : AppColors.borderSubtle)
                  : AppColors.primary.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_categoryIcon(notification.category), color: color),
              ),
              const SizedBox(width: AppDimensions.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontWeight: notification.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w800,
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (!notification.isRead) ...[
                          const SizedBox(width: AppDimensions.space8),
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(top: 6),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: AppDimensions.space6),
                    Text(
                      notification.message,
                      style: TextStyle(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.space10),
                    Wrap(
                      spacing: AppDimensions.space10,
                      runSpacing: AppDimensions.space6,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _CategoryChip(
                          label: notification.category.label,
                          color: color,
                        ),
                        Text(
                          '$date · $time',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: isDark
                                        ? AppColors.textMutedDark
                                        : AppColors.textMuted,
                                  ),
                        ),
                        if (!notification.isRead)
                          Text(
                            'Unread',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final Color color;

  const _CategoryChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: AppDimensions.roundedPill,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _EmptyNotifications extends StatelessWidget {
  const _EmptyNotifications();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceSecondaryDark
                    : AppColors.primarySoft,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 36,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: AppDimensions.space16),
            Text(
              'No notifications yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: AppDimensions.space6),
            Text(
              'Learning updates and reminders will appear here.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

IconData _categoryIcon(NotificationCategory category) => switch (category) {
      NotificationCategory.reminder => Icons.alarm_rounded,
      NotificationCategory.learning => Icons.school_rounded,
      NotificationCategory.achievement => Icons.emoji_events_rounded,
      NotificationCategory.system => Icons.info_outline_rounded,
    };

Color _categoryColor(NotificationCategory category) => switch (category) {
      NotificationCategory.reminder => AppColors.streak,
      NotificationCategory.learning => AppColors.primary,
      NotificationCategory.achievement => AppColors.success,
      NotificationCategory.system => AppColors.info,
    };
