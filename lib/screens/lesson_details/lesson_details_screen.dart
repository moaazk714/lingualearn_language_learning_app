import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../models/lesson_model.dart';
import '../../models/vocabulary_model.dart';
import '../../providers/course_provider.dart';
import '../../providers/progress_provider.dart';
import '../../providers/quiz_provider.dart';
import '../../providers/vocabulary_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/learning_translation_text.dart';
import '../../app/routes.dart';

class LessonDetailsScreen extends StatelessWidget {
  final LessonModel lesson;

  const LessonDetailsScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final vocabProvider = context.watch<VocabularyProvider>();
    final courseProvider = context.watch<CourseProvider>();

    // Fetch vocabulary items for this lesson
    final lessonVocabs = vocabProvider.allWords
        .where((w) => lesson.vocabularyIds.contains(w.id))
        .toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: Text('Lesson ${lesson.lessonNumber}'),
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

                    // Lesson Header Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        gradient: AppColors.heroGradient,
                        borderRadius: AppDimensions.roundedHero,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: AppDimensions.roundedPill,
                                ),
                                child: Text(
                                  lesson.isCompleted
                                      ? 'COMPLETED'
                                      : 'IN PROGRESS',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                  const SizedBox(width: AppDimensions.space4),
                                  Text(
                                    '${lesson.durationMinutes} mins',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDimensions.space14),
                          LearningTranslationText(
                            text: lesson.title,
                            sourceLanguageCode: 'en',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: AppDimensions.space6),
                          LearningTranslationText(
                            text: lesson.description,
                            sourceLanguageCode: 'en',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.9),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppDimensions.space24),

                    // Learning Objectives Section
                    Text(
                      'Learning Objectives',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.space12),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.surfaceDark : Colors.white,
                        borderRadius: AppDimensions.roundedCard,
                        border: Border.all(
                          color: isDark
                              ? AppColors.borderDark
                              : AppColors.borderSubtle,
                        ),
                        boxShadow: isDark ? null : AppDimensions.cardShadow,
                      ),
                      child: Column(
                        children: lesson.objectives.map((obj) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.success,
                                  size: 18,
                                ),
                                const SizedBox(width: AppDimensions.space10),
                                Expanded(
                                  child: LearningTranslationText(
                                    text: obj,
                                    sourceLanguageCode: 'en',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: isDark
                                          ? AppColors.textPrimaryDark
                                          : AppColors.textPrimary,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: AppDimensions.space24),

                    // Vocabulary Preview Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Vocabulary Preview',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '${lessonVocabs.length} Words',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.space12),

                    ...lessonVocabs.map((vocab) {
                      return _buildVocabPreviewTile(context, vocab, isDark);
                    }),

                    const SizedBox(height: AppDimensions.space24),
                  ],
                ),
              ),
            ),

            // Bottom Actions (Start Lesson & Quiz)
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                border: Border(
                  top: BorderSide(
                    color:
                        isDark ? AppColors.borderDark : AppColors.borderSubtle,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    text: lesson.isCompleted
                        ? 'Practice Again'
                        : 'Start Lesson Flashcards',
                    icon: Icons.play_arrow_rounded,
                    onPressed: () async {
                      final progressProvider = context.read<ProgressProvider>();
                      try {
                        await progressProvider
                            .addStudyMinutes(lesson.durationMinutes);
                        await courseProvider.markLessonCompleted(lesson.id);
                      } catch (error) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Unable to save lesson progress. Please try again.',
                              ),
                            ),
                          );
                        }
                        return;
                      }
                      if (context.mounted) {
                        Navigator.pushNamed(context, AppRoutes.flashcards);
                      }
                    },
                  ),
                  const SizedBox(height: AppDimensions.space10),
                  OutlinedButton(
                    onPressed: () {
                      final quizProvider = context.read<QuizProvider>();
                      try {
                        quizProvider.startQuizById(lesson.quizId);
                        Navigator.pushNamed(context, AppRoutes.quiz);
                      } on UnsupportedError {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              quizProvider.quizUnavailableMessage,
                            ),
                          ),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      side: const BorderSide(
                          color: AppColors.primary, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: AppDimensions.roundedPill,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.quiz_rounded,
                            size: 18, color: AppColors.primary),
                        SizedBox(width: AppDimensions.space8),
                        Text(
                          'Take Interactive Quiz',
                          style: TextStyle(
                            fontSize: 14,
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
          ],
        ),
      ),
    );
  }

  Widget _buildVocabPreviewTile(
    BuildContext context,
    VocabularyModel vocab,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      vocab.word,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.space8),
                    Text(
                      vocab.phonetic,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.space2),
                LearningTranslationText(
                  text: vocab.translation,
                  urduTranslation: vocab.urduTranslation,
                  localizedTranslations: vocab.localizedMeanings,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              vocab.isFavorite
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
              color: AppColors.primary,
              size: 20,
            ),
            onPressed: () {
              context.read<VocabularyProvider>().toggleFavorite(vocab.id);
            },
          ),
        ],
      ),
    );
  }
}
