import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../services/storage_service.dart';
import '../../widgets/custom_button.dart';
import '../../app/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageData> _pages = const [
    OnboardingPageData(
      stepText: AppStrings.step1Of3,
      badgeText: AppStrings.scientificallyProven,
      title: AppStrings.onboardingTitle1,
      description: AppStrings.onboardingDesc1,
      highlightTitle: AppStrings.instantVoiceFeedback,
      highlightSubtitle: AppStrings.speakNaturally,
      highlightIcon: Icons.volume_up_rounded,
    ),
    OnboardingPageData(
      stepText: AppStrings.step2Of3,
      badgeText: 'Interactive Micro-Learning',
      title: 'Smart 3D Flashcards & Quizzes',
      description:
          'Reinforce vocabulary with spaced repetition flashcards and quick multiple-choice quizzes that adapt to your pace.',
      highlightTitle: 'Adaptive Memory Engine',
      highlightSubtitle: 'Over 92% retention rate in 30 days',
      highlightIcon: Icons.style_rounded,
    ),
    OnboardingPageData(
      stepText: AppStrings.step3Of3,
      badgeText: 'Proven Results',
      title: 'Build Consistent Daily Habits',
      description:
          'Stay motivated with daily learning streaks, achievement badges, and clear visual progress tracking.',
      highlightTitle: '15 Minutes a Day',
      highlightSubtitle: 'Reach conversational fluency in 90 days',
      highlightIcon: Icons.bolt_rounded,
    ),
  ];

  Future<void> _completeOnboarding() async {
    final storage = await StorageService.getInstance();
    await storage.setOnboardingCompleted(true);
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.languageSelection);
  }

  void _onContinuePressed() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: AppDimensions.space12),

              // Header Bar: STEP X OF 3 & Skip
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceSecondaryDark
                          : const Color(0xFFF0EDFD),
                      borderRadius: AppDimensions.roundedPill,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppDimensions.space6),
                        Text(
                          _pages[_currentPage].stepText,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _completeOnboarding,
                    child: const Text(
                      AppStrings.skip,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppDimensions.space12),

              // PageView containing the Elevated White Hero Card
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _buildOnboardingCard(
                      context,
                      _pages[index],
                      isDark,
                    );
                  },
                ),
              ),

              const SizedBox(height: AppDimensions.space16),

              // 3-Dot Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pages.length, (index) {
                  final isActive = index == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primary
                          : (isDark
                              ? AppColors.surfaceTertiaryDark
                              : const Color(0xFFDCD8F9)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),

              const SizedBox(height: AppDimensions.space20),

              // Primary Action Button (Continue ->)
              CustomButton(
                text: _currentPage == _pages.length - 1
                    ? AppStrings.getStarted
                    : '${AppStrings.continueText} →',
                onPressed: _onContinuePressed,
                backgroundColor: AppColors.primary,
              ),

              const SizedBox(height: AppDimensions.space12),

              // Sub-footer Guarantee Notes
              Text(
                AppStrings.threeStepsToFluency,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppDimensions.space16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingCard(
    BuildContext context,
    OnboardingPageData data,
    bool isDark,
  ) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: const Color(0xFF101828).withValues(alpha: 0.06),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Illustration Box with Floating Language Badges
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceSecondaryDark
                    : const Color(0xFFF1EEFD),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Illustration Characters Circle
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '🗣️ 💬 👂',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ),

                  // Floating Pill 1: Spanish (Top-Left)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: _buildFloatingBadge('🇪🇸', '¡Hola!', isDark),
                  ),

                  // Floating Pill 2: French (Top-Right)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: _buildFloatingBadge('🇫🇷', 'Bonjour!', isDark),
                  ),

                  // Floating Pill 3: Green Lightning (Bottom-Left)
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.success.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.bolt_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),

                  // Floating Pill 4: English (Bottom-Right)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: _buildFloatingBadge('🇬🇧', 'Hello!', isDark),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.space16),

            // Scientifically Proven Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceTertiaryDark
                    : const Color(0xFFF3F0FE),
                borderRadius: AppDimensions.roundedPill,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.verified_outlined,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppDimensions.space6),
                  Text(
                    data.badgeText,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.space10),

            // Headline
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                letterSpacing: -0.4,
              ),
            ),

            const SizedBox(height: AppDimensions.space6),

            // Description
            Text(
              data.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
                height: 1.4,
              ),
            ),

            const SizedBox(height: AppDimensions.space16),

            // Highlight Feature Box (Instant Voice Feedback)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceSecondaryDark
                    : const Color(0xFFF5F3FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      data.highlightIcon,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.space10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.highlightTitle,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          data.highlightSubtitle,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingBadge(String emoji, String text, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: AppDimensions.roundedPill,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: AppDimensions.space6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPageData {
  final String stepText;
  final String badgeText;
  final String title;
  final String description;
  final String highlightTitle;
  final String highlightSubtitle;
  final IconData highlightIcon;

  const OnboardingPageData({
    required this.stepText,
    required this.badgeText,
    required this.title,
    required this.description,
    required this.highlightTitle,
    required this.highlightSubtitle,
    required this.highlightIcon,
  });
}
