import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../models/language_model.dart';
import '../../providers/course_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/progress_provider.dart';
import '../../providers/settings_provider.dart';
import '../../providers/vocabulary_provider.dart';
import '../../providers/quiz_provider.dart';
import '../../providers/notifications_provider.dart';
import '../../widgets/lingua_app_bar.dart';
import '../../widgets/stats_card.dart';
import '../../widgets/unit_banner_card.dart';
import '../../widgets/quick_practice_card.dart';
import '../../widgets/word_of_the_day_card.dart';
import '../../widgets/weekly_activity_chart.dart';
import '../../app/routes.dart';
import '../../services/tts_service.dart';

class HomeScreen extends StatelessWidget {
  final Function(int)? onSwitchTab;

  const HomeScreen({super.key, this.onSwitchTab});

  void _showLanguageSwitcher(BuildContext context) {
    final langProvider = context.read<LanguageProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: SizedBox(
              height: MediaQuery.of(ctx).size.height * 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Switch Active Language',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Scrollable language list
                  Expanded(
                    child: ListView.builder(
                      itemCount: LanguageModel.supportedLanguages.length,
                      itemBuilder: (context, index) {
                        final lang = LanguageModel.supportedLanguages[index];

                        final isSelected =
                            langProvider.selectedLanguage.id == lang.id;

                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Text(
                            lang.flagEmoji,
                            style: const TextStyle(fontSize: 26),
                          ),
                          title: Text(
                            '${lang.name} (${lang.nativeName})',
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected ? AppColors.primary : null,
                            ),
                          ),
                          subtitle: Text(lang.learnersCount),
                          trailing: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: AppColors.primary,
                                )
                              : null,
                          onTap: () {
                            langProvider.setLanguage(lang);

                            context
                                .read<VocabularyProvider>()
                                .updateLanguage(lang.id);

                            Navigator.pop(ctx);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _playPronunciation(
    BuildContext context,
    String word,
  ) async {
    // Get the language ID before the async operation.
    final languageId = context.read<LanguageProvider>().selectedLanguage.id;

    // Get the ScaffoldMessenger before the async operation.
    final messenger = ScaffoldMessenger.of(context);

    try {
      await TtsService.instance.speak(
        word,
        languageId: languageId,
      );
    } catch (e) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Pronunciation unavailable. Check your device voice settings.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final langProvider = context.watch<LanguageProvider>();
    final courseProvider = context.watch<CourseProvider>();
    final progressProvider = context.watch<ProgressProvider>();
    final vocabProvider = context.watch<VocabularyProvider>();
    final settingsProvider = context.watch<SettingsProvider>();
    final notificationsProvider = context.watch<NotificationsProvider>();

    final wordOfTheDay = vocabProvider.wordOfTheDay;
    final unit = courseProvider.currentUnit;
    final lesson = courseProvider.currentLesson;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: LinguaAppBar(
        title: AppStrings.appName,
        badgeText: AppStrings.homeDashboard,
        notificationCount: notificationsProvider.unreadCount,
        onNotificationTap: () =>
            Navigator.pushNamed(context, AppRoutes.notifications),
        onProfileTap: () {
          if (onSwitchTab != null) {
            onSwitchTab!(4); // Profile tab
          }
        },
      ),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 600));
          },
          color: AppColors.primary,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppDimensions.space8),

                // Language Selection Chip (Spanish (Beginner A1) ▾)
                GestureDetector(
                  onTap: () => _showLanguageSwitcher(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceSecondaryDark
                          : const Color(0xFFEFEFFD),
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
                        Flexible(
                          child: Text(
                            '${langProvider.selectedLanguage.name} (${langProvider.selectedLevel == 'Beginner' ? 'Beginner A1' : langProvider.selectedLevel})',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppDimensions.space4),
                        const Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppDimensions.space10),

                // Greeting Header & Avatar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${AppStrings.greetingPrefix} ${settingsProvider.userName}! 👋',
                            softWrap: true,
                            maxLines: null,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimary,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.space4),
                          Text(
                            'Ready for your daily ${langProvider.selectedLanguage.name} streak?',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // User Avatar with Ring & Online Status
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2.5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.avatarRingGradient,
                          ),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: isDark
                                ? AppColors.surfaceSecondaryDark
                                : Colors.white,
                            child: const Text(
                              '🧑‍💻',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDark
                                    ? AppColors.surfaceDark
                                    : Colors.white,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: AppDimensions.space18),

                // Stats Cards Horizontal Scroll / Row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: Row(
                    children: [
                      // Streak Card
                      StatsCard(
                        title: 'Streak',
                        value: '${progressProvider.streakDays} Days',
                        subtitle:
                            'Freezes: ${progressProvider.streakFreezes}/${progressProvider.maxStreakFreezes}',
                        icon: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.streakSoft,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.local_fire_department_rounded,
                            size: 16,
                            color: AppColors.streak,
                          ),
                        ),
                        onTap: () {
                          if (onSwitchTab != null) onSwitchTab!(3);
                        },
                      ),
                      const SizedBox(width: AppDimensions.space12),

                      // Today's Goal Card
                      StatsCard(
                        title: "Today's Goal",
                        value:
                            '${progressProvider.todayMinutes} / ${progressProvider.goalMinutes}m',
                        subtitle:
                            '${progressProvider.remainingMinutes} mins left',
                        subtitleColor: AppColors.primary,
                        circularProgress: progressProvider.goalProgress,
                        onTap: () {
                          if (onSwitchTab != null) onSwitchTab!(3);
                        },
                      ),
                      const SizedBox(width: AppDimensions.space12),

                      // Mastered Words Card
                      StatsCard(
                        title: 'Mastered',
                        value: '${progressProvider.masteredWords}',
                        subtitle: '+14 this week',
                        subtitleColor: AppColors.success,
                        icon: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.successSoft,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.trending_up_rounded,
                            size: 16,
                            color: AppColors.success,
                          ),
                        ),
                        onTap: () {
                          if (onSwitchTab != null) onSwitchTab!(2);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.space20),

                // Hero Banner - Current Unit
                UnitBannerCard(
                  unit: unit,
                  lesson: lesson,
                  onResume: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.lessonDetails,
                      arguments: lesson,
                    );
                  },
                ),

                const SizedBox(height: AppDimensions.space24),

                // Quick Practice Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        AppStrings.quickPractice,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (onSwitchTab != null) onSwitchTab!(1);
                      },
                      child: const Text(
                        AppStrings.viewAll,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppDimensions.space12),

                // 3 Practice Cards Row
                Row(
                  children: [
                    // Flashcards
                    QuickPracticeCard(
                      title: AppStrings.flashcards,
                      subtitle: '${vocabProvider.flashcardsQueue.length} Due',
                      icon: Icons.style_rounded,
                      iconColor: AppColors.primary,
                      iconBackgroundColor: isDark
                          ? AppColors.surfaceTertiaryDark
                          : const Color(0xFFECEBFA),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.flashcards);
                      },
                    ),
                    const SizedBox(width: AppDimensions.space12),

                    // Quick Quiz
                    QuickPracticeCard(
                      title: AppStrings.quickQuiz,
                      subtitle: '5 Questions',
                      icon: Icons.bolt_rounded,
                      iconColor: const Color(0xFFD97706),
                      iconBackgroundColor: isDark
                          ? AppColors.surfaceTertiaryDark
                          : const Color(0xFFFEF3C7),
                      onTap: () {
                        final quizProvider = context.read<QuizProvider>();
                        try {
                          quizProvider.startQuickQuiz();
                        } on UnsupportedError {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                quizProvider.quizUnavailableMessage,
                              ),
                            ),
                          );
                          return;
                        }
                        Navigator.pushNamed(context, AppRoutes.quiz);
                      },
                    ),
                    const SizedBox(width: AppDimensions.space12),

                    // Speech
                    QuickPracticeCard(
                      title: AppStrings.speech,
                      subtitle: AppStrings.pronunciation,
                      icon: Icons.mic_rounded,
                      iconColor: const Color(0xFF059669),
                      iconBackgroundColor: isDark
                          ? AppColors.surfaceTertiaryDark
                          : const Color(0xFFD1FAE5),
                      onTap: () {
                        _playPronunciation(context, wordOfTheDay.word);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: AppDimensions.space24),

                // Word of the Day Section Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.stars_rounded,
                            color: AppColors.primary,
                            size: 18,
                          ),
                          const SizedBox(width: AppDimensions.space6),
                          Flexible(
                            child: Text(
                              AppStrings.wordOfTheDay,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.surfaceSecondaryDark
                            : const Color(0xFFF1EFFE),
                        borderRadius: AppDimensions.roundedPill,
                      ),
                      child: const Text(
                        AppStrings.dailyDrop,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppDimensions.space12),

                // Word of the Day Card (El Desayuno)
                WordOfTheDayCard(
                  word: wordOfTheDay,
                  isSaved: wordOfTheDay.isFavorite,
                  onPlayAudio: () {
                    _playPronunciation(context, wordOfTheDay.word);
                  },
                  onAddToFlashcards: () {
                    vocabProvider.toggleFavorite(wordOfTheDay.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          wordOfTheDay.isFavorite
                              ? 'Removed from Flashcards'
                              : 'Added "${wordOfTheDay.word}" to Flashcards!',
                        ),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppDimensions.space24),

                // Weekly Activity Chart Section
                WeeklyActivityChart(
                  activities: progressProvider.weeklyActivity,
                  onDetailsTap: () {
                    if (onSwitchTab != null) onSwitchTab!(3);
                  },
                ),

                const SizedBox(height: AppDimensions.space32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
