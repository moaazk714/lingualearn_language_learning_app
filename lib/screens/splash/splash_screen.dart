import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../services/storage_service.dart';
import '../../app/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward();

    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(milliseconds: 2600));
    if (!mounted) return;

    final storage = await StorageService.getInstance();
    final isCompleted = storage.isOnboardingCompleted();

    if (!mounted) return;
    if (isCompleted) {
      Navigator.pushReplacementNamed(context, AppRoutes.main);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient:
              isDark ? AppColors.splashGradientDark : AppColors.splashGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: AppDimensions.space20),

              // Top Global Academy Network Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceSecondaryDark
                      : Colors.white.withValues(alpha: 0.8),
                  borderRadius: AppDimensions.roundedPill,
                  border: Border.all(
                    color:
                        isDark ? AppColors.borderDark : AppColors.borderSubtle,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.space8),
                    Text(
                      AppStrings.globalAcademyNetwork,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : const Color(0xFF4B5563),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0),

              const Spacer(),

              // Central Brand Graphic with Floating Satellites
              Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Ambient Glow
                      Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withValues(alpha: 0.08),
                        ),
                      ),

                      // Outer Dashed Orbit Path
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.15),
                            width: 1.5,
                          ),
                        ),
                      ),

                      // Central Logo Disc
                      Container(
                        width: 108,
                        height: 108,
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.surfaceDark : Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.18),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              gradient: AppColors.heroGradient,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: const Center(
                              child: Text(
                                'L',
                                style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Satellite Badge 1 (Top Right - Translation Character 文/A)
                      Positioned(
                        top: 20,
                        right: 24,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.surfaceSecondaryDark
                                : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.translate_rounded,
                            size: 18,
                            color: AppColors.primary,
                          ),
                        ),
                      ).animate().scale(delay: 400.ms, duration: 500.ms),

                      // Satellite Badge 2 (Bottom Left - Sparkles)
                      Positioned(
                        bottom: 24,
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.surfaceSecondaryDark
                                : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.auto_awesome_rounded,
                            size: 16,
                            color: AppColors.success,
                          ),
                        ),
                      ).animate().scale(delay: 600.ms, duration: 500.ms),
                    ],
                  ),
                ),
              ).animate().scale(duration: 700.ms, curve: Curves.easeOutBack),

              const SizedBox(height: AppDimensions.space24),

              // Title: LinguaLearn (Dual Tone)
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: AppStrings.appTitleFirst,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                      ),
                    ),
                    const TextSpan(
                      text: AppStrings.appTitleSecond,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

              const SizedBox(height: AppDimensions.space8),

              // Tagline
              Text(
                AppStrings.appTagline,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ).animate().fadeIn(delay: 350.ms),

              const SizedBox(height: AppDimensions.space16),

              // Trust Pill Badge: 120+ Immersion Pathways
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceSecondaryDark
                      : Colors.white.withValues(alpha: 0.9),
                  borderRadius: AppDimensions.roundedPill,
                  border: Border.all(
                    color:
                        isDark ? AppColors.borderDark : AppColors.borderSubtle,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified_outlined,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: AppDimensions.space8),
                    Text(
                      AppStrings.immersionPathways,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 500.ms),

              const Spacer(),

              // Bottom Progress Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: AnimatedBuilder(
                  animation: _progressController,
                  builder: (context, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: SizedBox(
                        height: 4,
                        child: LinearProgressIndicator(
                          value: _progressController.value,
                          backgroundColor: isDark
                              ? AppColors.surfaceSecondaryDark
                              : const Color(0xFFE4E0FB),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppDimensions.space16),

              // Powered by Flutter & Dart
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.flutter_dash_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppDimensions.space6),
                  Text(
                    AppStrings.poweredBy,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : const Color(0xFF4B5563),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppDimensions.space8),

              // Version & Encrypted Sync
              Text(
                AppStrings.appVersion,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.textMutedDark : AppColors.textMuted,
                  letterSpacing: 0.8,
                ),
              ),

              const SizedBox(height: AppDimensions.space4),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.space6),
                  Text(
                    AppStrings.encryptedSync,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? AppColors.textMutedDark
                          : AppColors.textMuted,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppDimensions.space16),
            ],
          ),
        ),
      ),
    );
  }
}
