import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../models/language_model.dart';
import '../../models/translation_language.dart';
import '../../providers/course_provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/vocabulary_provider.dart';
import '../../services/storage_service.dart';
import '../../widgets/custom_button.dart';
import '../../app/routes.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final List<String> _levels = const [
    'Beginner\nA1-A2',
    'Intermediate\nB1-B2',
    'Advanced\nC1',
  ];

  late String _selectedLevelDisplay;

  @override
  void initState() {
    super.initState();
    _selectedLevelDisplay = _levels.first;
    _loadSavedLevel();
  }

  Future<void> _loadSavedLevel() async {
    final storage = await StorageService.getInstance();
    final savedLevel = storage.getSelectedLevel();
    final match = _levels.where(
      (level) => level.split('\n').first == savedLevel,
    );
    if (!mounted) return;
    setState(() {
      _selectedLevelDisplay = match.isEmpty ? _levels.first : match.first;
    });
  }

  Future<void> _onContinue() async {
    final langProvider = context.read<LanguageProvider>();
    final courseProvider = context.read<CourseProvider>();
    final vocabProvider = context.read<VocabularyProvider>();

    final levelName = _selectedLevelDisplay.split('\n').first;
    try {
      await langProvider.setLanguage(langProvider.selectedLanguage);
      await langProvider.setTranslationLanguage(
        langProvider.selectedTranslationLanguage,
      );
      await langProvider.setLevel(levelName);
      courseProvider.updateForLanguage(
        langProvider.selectedLanguage.id,
        levelName,
      );
      vocabProvider.updateLanguage(langProvider.selectedLanguage.id);
    } on StateError catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
      return;
    }

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, AppRoutes.main);
  }

  Future<void> _selectTranslationLanguage(String code) async {
    final language = TranslationLanguage.findByCode(code);
    if (language == null) return;
    try {
      await context.read<LanguageProvider>().setTranslationLanguage(language);
    } on StateError catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final langProvider = context.watch<LanguageProvider>();
    final selectedLang = langProvider.selectedLanguage;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Material(
              color: isDark ? AppColors.surfaceSecondaryDark : Colors.white,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: 20,
                    color: isDark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ),
        title: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceSecondaryDark
                  : const Color(0xFFF0EDFD),
              borderRadius: AppDimensions.roundedPill,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 14,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: AppDimensions.space6),
                const Text(
                  'Step 1 of 3',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Material(
                color: isDark ? AppColors.surfaceSecondaryDark : Colors.white,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Choose your primary language to customize your learning path.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.help_outline_rounded,
                      size: 20,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppDimensions.space12),

                    // Personalize Path Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.surfaceTertiaryDark
                            : const Color(0xFFF3F0FE),
                        borderRadius: AppDimensions.roundedPill,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.translate_rounded,
                            size: 14,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: AppDimensions.space6),
                          Text(
                            AppStrings.personalizePath,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppDimensions.space12),

                    // Title
                    Text(
                      AppStrings.selectLanguageTitle,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                        letterSpacing: -0.4,
                      ),
                    ),

                    const SizedBox(height: AppDimensions.space6),

                    // Subtitle
                    Text(
                      AppStrings.selectLanguageSubtitle,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: AppDimensions.space20),

                    // Language Cards List
                    ...langProvider.languages.map((language) {
                      final isSelected = selectedLang.id == language.id;
                      return _buildLanguageCard(
                        context,
                        language,
                        isSelected,
                        isDark,
                        () => langProvider.setLanguage(language),
                      );
                    }),

                    const SizedBox(height: AppDimensions.space20),

                    Text(
                      AppStrings.selectTranslationLanguageTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.space4),
                    Text(
                      AppStrings.selectTranslationLanguageSubtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.space10),
                    DropdownButtonFormField<String>(
                      key: ValueKey(
                        'translation-${langProvider.selectedTranslationLanguage.code}',
                      ),
                      initialValue:
                          langProvider.selectedTranslationLanguage.code,
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Translation language',
                        border: OutlineInputBorder(
                          borderRadius: AppDimensions.roundedMedium,
                        ),
                        filled: true,
                        fillColor:
                            isDark ? AppColors.surfaceDark : Colors.white,
                      ),
                      items: TranslationLanguage.supportedLanguages
                          .map(
                            (language) => DropdownMenuItem(
                              value: language.code,
                              child: Text(
                                '${language.name} (${language.nativeName})',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textDirection: language.isRightToLeft
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (code) {
                        if (code != null) {
                          _selectTranslationLanguage(code);
                        }
                      },
                    ),

                    const SizedBox(height: AppDimensions.space20),

                    // Starting Level Section Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppStrings.yourStartingLevel,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          AppStrings.adaptable,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.primaryLight
                                : AppColors.primary,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppDimensions.space12),

                    // Segmented Pills: Beginner A1-A2, Intermediate B1-B2, Advanced C1
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.surfaceSecondaryDark
                            : const Color(0xFFF3F2FA),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: _levels.map((level) {
                          final isLevelSelected =
                              _selectedLevelDisplay == level;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedLevelDisplay = level;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: isLevelSelected
                                      ? (isDark
                                          ? AppColors.surfaceDark
                                          : Colors.white)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: isLevelSelected
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.05,
                                            ),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Text(
                                  level,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isLevelSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isLevelSelected
                                        ? AppColors.primary
                                        : (isDark
                                            ? AppColors.textSecondaryDark
                                            : AppColors.textSecondary),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: AppDimensions.space16),

                    // 15 mins daily habit Tip Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.surfaceTertiaryDark
                                .withValues(alpha: 0.5)
                            : const Color(0xFFF4F2FE),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color:
                                  isDark ? AppColors.surfaceDark : Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.insights_rounded,
                              size: 18,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(width: AppDimensions.space12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.dailyHabitTitle,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: isDark
                                        ? AppColors.textPrimaryDark
                                        : AppColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: AppDimensions.space2),
                                Text(
                                  AppStrings.dailyHabitSubtitle,
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
                        ],
                      ),
                    ),

                    const SizedBox(height: AppDimensions.space24),
                  ],
                ),
              ),
            ),

            // Sticky Bottom CTA Button
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
              child: CustomButton(
                text: '${AppStrings.continueToDashboard} →',
                onPressed: _onContinue,
                backgroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard(
    BuildContext context,
    LanguageModel language,
    bool isSelected,
    bool isDark,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? AppColors.primary
              : (isDark ? AppColors.borderDark : AppColors.borderSubtle),
          width: isSelected ? 2.0 : 1.0,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: isSelected
                      ? AppColors.primary.withValues(alpha: 0.08)
                      : const Color(0xFF101828).withValues(alpha: 0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Row(
              children: [
                // Flag Container
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.surfaceSecondaryDark
                        : const Color(0xFFF7F8FC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      language.flagEmoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.space14),

                // Name & Learners
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              language.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppDimensions.space6),
                          Flexible(
                            child: Text(
                              '(${language.nativeName})',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.space4),
                      Row(
                        children: [
                          Icon(
                            Icons.groups_rounded,
                            size: 14,
                            color: isDark
                                ? AppColors.textMutedDark
                                : AppColors.textMuted,
                          ),
                          const SizedBox(width: AppDimensions.space4),
                          Text(
                            language.learnersCount,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: isDark
                                  ? AppColors.textMutedDark
                                  : AppColors.textSecondary,
                            ),
                          ),
                          if (language.isPopular) ...[
                            const SizedBox(width: AppDimensions.space6),
                            const Text('•',
                                style: TextStyle(color: AppColors.success)),
                            const SizedBox(width: AppDimensions.space6),
                            const Text(
                              'Popular',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Selected Checkmark Circle
                if (isSelected)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    ),
                  )
                else
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark
                            ? AppColors.borderDark
                            : const Color(0xFFD1D5DB),
                        width: 1.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
