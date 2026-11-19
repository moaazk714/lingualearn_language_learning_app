import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimensions.dart';
import '../models/vocabulary_model.dart';
import 'learning_translation_text.dart';

class WordOfTheDayCard extends StatelessWidget {
  final VocabularyModel word;
  final VoidCallback onPlayAudio;
  final VoidCallback onAddToFlashcards;
  final bool isSaved;

  const WordOfTheDayCard({
    super.key,
    required this.word,
    required this.onPlayAudio,
    required this.onAddToFlashcards,
    this.isSaved = false,
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
          // Word, Phonetics and Speaker Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: AppDimensions.space8,
                      runSpacing: AppDimensions.space4,
                      children: [
                        Text(
                          word.word,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimary,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          word.phonetic,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.space4),
                    LearningTranslationText(
                      text: word.translation,
                      urduTranslation: word.urduTranslation,
                      localizedTranslations: word.localizedMeanings,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      word.partOfSpeech,
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),

              // Audio Speaker Button
              Material(
                color: isDark
                    ? AppColors.surfaceTertiaryDark
                    : AppColors.primarySoft,
                shape: const CircleBorder(),
                child: IconButton(
                  icon: const Icon(
                    Icons.volume_up_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  tooltip: 'Listen to pronunciation',
                  onPressed: onPlayAudio,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.space16),

          // Quote Example Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceTertiaryDark.withValues(alpha: 0.5)
                  : const Color(0xFFF3F1FD),
              borderRadius: AppDimensions.roundedLarge,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.format_quote_rounded,
                  size: 20,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppDimensions.space8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '"${word.exampleSentence}"',
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.space4),
                      LearningTranslationText(
                        text: word.exampleTranslation,
                        urduTranslation: word.exampleUrduTranslation,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: isDark
                              ? AppColors.textMutedDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.space16),

          // Footer: Category + Add to Flashcards Button
          LayoutBuilder(
            builder: (context, constraints) {
              final category = Text(
                '${word.category} • Common',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? AppColors.textMutedDark
                      : AppColors.textSecondary,
                ),
              );
              final flashcardButton = ConstrainedBox(
                constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                child: Material(
                  color: isDark
                      ? AppColors.surfaceSecondaryDark
                      : const Color(0xFFEEECFD),
                  borderRadius: AppDimensions.roundedPill,
                  child: InkWell(
                    onTap: onAddToFlashcards,
                    borderRadius: AppDimensions.roundedPill,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSaved
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: AppDimensions.space6),
                          Flexible(
                            child: Text(
                              isSaved ? 'In Flashcards' : 'Add to Flashcards',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );

              if (constraints.maxWidth < 380) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    category,
                    const SizedBox(height: AppDimensions.space8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: flashcardButton,
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: AppDimensions.space8),
                      child: category,
                    ),
                  ),
                  flashcardButton,
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
