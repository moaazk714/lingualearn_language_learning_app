import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/course_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/progress_provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/vocabulary_provider.dart';
import '../../providers/quiz_provider.dart';
import '../../app/routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showEditNameDialog(BuildContext context, SettingsProvider settings) {
    final controller = TextEditingController(text: settings.userName);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Profile Name'),
        content: TextField(
          controller: controller,
          autofocus: true,
          minLines: 1,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: 'Your Name',
            hintText: 'Enter your name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                settings.updateUserName(controller.text.trim());
              }
              Navigator.pop(ctx);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDailyGoalDialog(BuildContext context, ProgressProvider progress) {
    final goals = [10, 15, 20, 30, 45];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Set Daily Habit Goal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: goals.map((mins) {
            final isSelected = progress.goalMinutes == mins;
            return ListTile(
              title: Text('$mins minutes per day'),
              leading: Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: isSelected ? AppColors.primary : null,
              ),
              onTap: () {
                progress.setDailyGoal(mins);
                Navigator.pop(ctx);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showResetConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset All Learning Progress?'),
        content: const Text(
          'This will reset all your completed lessons, streaks, and saved vocabulary data. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () async {
              Navigator.pop(ctx);
              final settingsProvider = context.read<SettingsProvider>();
              final languageProvider = context.read<LanguageProvider>();
              final courseProvider = context.read<CourseProvider>();
              final vocabularyProvider = context.read<VocabularyProvider>();
              final quizProvider = context.read<QuizProvider>();
              final progressProvider = context.read<ProgressProvider>();
              await settingsProvider.resetAll();
              languageProvider.reset();
              courseProvider.reset();
              vocabularyProvider.reset();
              quizProvider.reset();
              progressProvider.reset();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, AppRoutes.splash);
              }
            },
            child:
                const Text('Reset Data', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: AppStrings.appName,
      applicationVersion: AppStrings.appVersion,
      applicationIcon: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          gradient: AppColors.heroGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'L',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
      children: [
        const SizedBox(height: 12),
        const Text(
          'LinguaLearn is a modern, high-fidelity language learning application built for CodeAlpha Flutter Development Internship Project 4.',
        ),
        const SizedBox(height: 8),
        const Text('• Clean Architecture with Provider state management'),
        const Text('• Offline persistence with SharedPreferences'),
        const Text('• Stitch AI 1:1 Pixel-Accurate UI Design'),
        const Text('• Powered by Flutter 3.x & Dart'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final settings = context.watch<SettingsProvider>();
    final langProvider = context.watch<LanguageProvider>();
    final progress = context.watch<ProgressProvider>();
    final course = context.watch<CourseProvider>();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text('Profile & Settings'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: [
            // Profile Header Card
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
              child: Row(
                children: [
                  // Avatar
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.avatarRingGradient,
                    ),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: isDark
                          ? AppColors.surfaceSecondaryDark
                          : Colors.white,
                      child:
                          const Text('🧑‍💻', style: TextStyle(fontSize: 32)),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.space16),

                  // Name & Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                settings.userName,
                                softWrap: true,
                                maxLines: null,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(width: AppDimensions.space6),
                            InkWell(
                              onTap: () =>
                                  _showEditNameDialog(context, settings),
                              child: const Icon(
                                Icons.edit_rounded,
                                size: 16,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppDimensions.space4),
                        Text(
                          '${langProvider.selectedLanguage.flagEmoji} Learning: ${langProvider.selectedLanguage.name}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.space4),
                        Text(
                          'Understanding: ${langProvider.selectedTranslationLanguage.name} (${langProvider.selectedTranslationLanguage.nativeName})',
                          textDirection: langProvider
                                  .selectedTranslationLanguage.isRightToLeft
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.space4),
                        Text(
                          'Level: ${langProvider.selectedLevel}',
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
            ),

            const SizedBox(height: AppDimensions.space20),

            // Profile Quick Stats
            Row(
              children: [
                Expanded(
                  child: _buildSmallStat(
                    'Streak',
                    '${progress.streakDays}d',
                    Icons.local_fire_department,
                    AppColors.streak,
                    isDark,
                  ),
                ),
                const SizedBox(width: AppDimensions.space12),
                Expanded(
                  child: _buildSmallStat(
                    'Words',
                    '${progress.masteredWords}',
                    Icons.translate,
                    AppColors.primary,
                    isDark,
                  ),
                ),
                const SizedBox(width: AppDimensions.space12),
                Expanded(
                  child: _buildSmallStat(
                    'Lessons',
                    '${course.currentCourse.completedLessons}',
                    Icons.done_all,
                    AppColors.success,
                    isDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.space24),

            // Preferences Section
            Text(
              'Learning Preferences',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.space12),

            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: AppDimensions.roundedCard,
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: AppDimensions.roundedCard,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.timer_outlined,
                          color: AppColors.primary),
                      title: const Text('Daily Habit Goal'),
                      subtitle: Text('${progress.goalMinutes} minutes per day'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showDailyGoalDialog(context, progress),
                    ),
                    const Divider(height: 1, indent: 56),
                    ListTile(
                      leading: const Icon(Icons.language_rounded,
                          color: AppColors.primary),
                      title: const Text('Learning language'),
                      subtitle: Text(
                          '${langProvider.selectedLanguage.name} (${langProvider.selectedLanguage.nativeName})'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.languageSelection);
                      },
                    ),
                    const Divider(height: 1, indent: 56),
                    ListTile(
                      leading: const Icon(Icons.translate_rounded,
                          color: AppColors.primary),
                      title: const Text('Translation language'),
                      subtitle: Text(
                        '${langProvider.selectedTranslationLanguage.name} (${langProvider.selectedTranslationLanguage.nativeName})',
                        textDirection: langProvider
                                .selectedTranslationLanguage.isRightToLeft
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoutes.languageSelection);
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.space24),

            // App Settings Section
            Text(
              'App Settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.space12),

            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: AppDimensions.roundedCard,
                border: Border.all(
                  color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                borderRadius: AppDimensions.roundedCard,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    SwitchListTile(
                      secondary: const Icon(Icons.dark_mode_outlined,
                          color: AppColors.primary),
                      title: const Text('Dark Mode'),
                      subtitle: const Text('Toggle high-contrast dark theme'),
                      value: settings.isDarkMode,
                      activeThumbColor: AppColors.primary,
                      onChanged: (val) => settings.toggleDarkMode(val),
                    ),
                    const Divider(height: 1, indent: 56),
                    SwitchListTile(
                      secondary: const Icon(Icons.volume_up_outlined,
                          color: AppColors.primary),
                      title: const Text('Sound Effects & Audio'),
                      subtitle:
                          const Text('Pronunciation cues and answer sounds'),
                      value: settings.isSoundEnabled,
                      activeThumbColor: AppColors.primary,
                      onChanged: (val) => settings.toggleSound(val),
                    ),
                    const Divider(height: 1, indent: 56),
                    SwitchListTile(
                      secondary: const Icon(Icons.notifications_none_outlined,
                          color: AppColors.primary),
                      title: const Text('Daily Practice Reminders'),
                      subtitle: const Text(
                          'Stay consistent with smart notifications'),
                      value: settings.areNotificationsEnabled,
                      activeThumbColor: AppColors.primary,
                      onChanged: (val) => settings.toggleNotifications(val),
                    ),
                    const Divider(height: 1, indent: 56),
                    ListTile(
                      leading: const Icon(Icons.translate_rounded,
                          color: AppColors.primary),
                      title: const Text(AppStrings.translateText),
                      subtitle: const Text(
                        'Translate between seven languages',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.translation);
                      },
                    ),
                    const Divider(height: 1, indent: 56),
                    ListTile(
                      leading: const Icon(Icons.info_outline_rounded,
                          color: AppColors.primary),
                      title: const Text('About LinguaLearn'),
                      subtitle:
                          const Text('Version, CodeAlpha project & licenses'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showAboutDialog(context),
                    ),
                    const Divider(height: 1, indent: 56),
                    ListTile(
                      leading: const Icon(Icons.restart_alt_rounded,
                          color: AppColors.error),
                      title: const Text(
                        'Reset All Learning Data',
                        style: TextStyle(color: AppColors.error),
                      ),
                      subtitle:
                          const Text('Clear all saved progress & restart'),
                      onTap: () => _showResetConfirmDialog(context),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.space32),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallStat(
    String label,
    String value,
    IconData icon,
    Color color,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: AppDimensions.space6),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
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
    );
  }
}
