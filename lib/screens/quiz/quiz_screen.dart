import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../providers/quiz_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/learning_translation_text.dart';
import '../../providers/language_provider.dart';
import '../../app/routes.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final quizProvider = context.watch<QuizProvider>();
    final translationLanguage =
        context.watch<LanguageProvider>().selectedTranslationLanguage;
    final question = quizProvider.currentQuestion;

    if (question == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz')),
        body: Center(
          child: Text(
            quizProvider.availableQuizzes.isEmpty
                ? quizProvider.quizUnavailableMessage
                : 'No active quiz.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final currentIndex = quizProvider.currentQuestionIndex;
    final total = quizProvider.totalQuestions;
    final isLast = currentIndex == total - 1;
    final quizTextLanguageCode = quizProvider.selectedLanguageCode == 'es'
        ? 'en'
        : quizProvider.selectedLanguageCode;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: Text(quizProvider.activeQuiz?.title ?? 'Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Quit Quiz?'),
                content: const Text(
                    'Your current progress in this quiz will be lost.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.pop(context);
                    },
                    child: const Text('Quit',
                        style: TextStyle(color: AppColors.error)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Progress Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${currentIndex + 1} of $total',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '${(quizProvider.quizProgress * 100).toInt()}%',
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
              const SizedBox(height: AppDimensions.space8),

              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: quizProvider.quizProgress,
                  backgroundColor: isDark
                      ? AppColors.surfaceSecondaryDark
                      : const Color(0xFFE5E3F8),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                  minHeight: 6,
                ),
              ),

              const SizedBox(height: AppDimensions.space24),

              // Question Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : Colors.white,
                  borderRadius: AppDimensions.roundedHero,
                  border: Border.all(
                    color:
                        isDark ? AppColors.borderDark : AppColors.borderSubtle,
                  ),
                  boxShadow: isDark ? null : AppDimensions.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.surfaceSecondaryDark
                            : AppColors.primarySoft,
                        borderRadius: AppDimensions.roundedPill,
                      ),
                      child: const Text(
                        'MULTIPLE CHOICE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.space12),
                    Text(
                      question.questionText,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                        height: 1.35,
                      ),
                    ),
                    if (translationLanguage.code != quizTextLanguageCode) ...[
                      const SizedBox(height: AppDimensions.space8),
                      LearningTranslationText(
                        text: question.questionText,
                        sourceLanguageCode: quizTextLanguageCode,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.space20),

              // Options List
              Expanded(
                child: ListView.builder(
                  itemCount: question.options.length,
                  itemBuilder: (context, index) {
                    final optionText = question.options[index];
                    final isSelected =
                        quizProvider.selectedOptionIndex == index;
                    final isChecked = quizProvider.isAnswerChecked;
                    final isCorrect = index == question.correctIndex;

                    Color backgroundColor =
                        isDark ? AppColors.surfaceDark : Colors.white;
                    Color borderColor =
                        isDark ? AppColors.borderDark : AppColors.borderSubtle;
                    Color textColor = isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary;
                    Widget? trailingIcon;

                    if (isChecked) {
                      if (isCorrect) {
                        backgroundColor = AppColors.successSoft;
                        borderColor = AppColors.success;
                        textColor = AppColors.successDark;
                        trailingIcon = const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.success,
                        );
                      } else if (isSelected) {
                        backgroundColor = AppColors.errorSoft;
                        borderColor = AppColors.error;
                        textColor = AppColors.error;
                        trailingIcon = const Icon(
                          Icons.cancel_rounded,
                          color: AppColors.error,
                        );
                      }
                    } else if (isSelected) {
                      backgroundColor = isDark
                          ? AppColors.surfaceTertiaryDark
                          : const Color(0xFFF0EDFD);
                      borderColor = AppColors.primary;
                      textColor = AppColors.primary;
                    }

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: borderColor,
                          width: (isSelected || (isChecked && isCorrect))
                              ? 2.0
                              : 1.0,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            quizProvider.selectOption(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 16.0,
                            ),
                            child: Row(
                              children: [
                                // Option letter pill (A, B, C, D)
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color:
                                        (isSelected || (isChecked && isCorrect))
                                            ? borderColor
                                            : (isDark
                                                ? AppColors.surfaceSecondaryDark
                                                : const Color(0xFFF3F4F6)),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      String.fromCharCode(
                                          65 + index), // 'A', 'B', 'C', 'D'
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: (isSelected ||
                                                (isChecked && isCorrect))
                                            ? Colors.white
                                            : (isDark
                                                ? AppColors.textPrimaryDark
                                                : AppColors.textPrimary),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppDimensions.space12),

                                Expanded(
                                  child: Text(
                                    optionText,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: textColor,
                                    ),
                                  ),
                                ),

                                if (trailingIcon != null) trailingIcon,
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Feedback / Explanation Box after checking
              if (quizProvider.isAnswerChecked)
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 16.0),
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.surfaceSecondaryDark
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark ? AppColors.borderDark : AppColors.border,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.lightbulb_outline_rounded,
                        color: AppColors.streak,
                        size: 20,
                      ),
                      const SizedBox(width: AppDimensions.space10),
                      Expanded(
                        child: LearningTranslationText(
                          text: question.explanation,
                          sourceLanguageCode: quizTextLanguageCode,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              // Bottom Action Button (Check Answer -> Next / Finish)
              CustomButton(
                text: !quizProvider.isAnswerChecked
                    ? 'Check Answer'
                    : isLast
                        ? 'Finish Quiz & View Results'
                        : 'Next Question →',
                backgroundColor: quizProvider.selectedOptionIndex == null
                    ? (isDark
                        ? AppColors.surfaceSecondaryDark
                        : AppColors.border)
                    : AppColors.primary,
                textColor: quizProvider.selectedOptionIndex == null
                    ? AppColors.textMuted
                    : Colors.white,
                onPressed: quizProvider.selectedOptionIndex == null
                    ? null
                    : () async {
                        if (!quizProvider.isAnswerChecked) {
                          quizProvider.checkAnswer();
                        } else {
                          if (isLast) {
                            try {
                              await quizProvider.finishQuiz();
                              if (context.mounted) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.quizResult,
                                );
                              }
                            } catch (_) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Unable to save the quiz result. Please try again.',
                                    ),
                                  ),
                                );
                              }
                            }
                          } else {
                            quizProvider.nextQuestion();
                          }
                        }
                      },
              ),

              const SizedBox(height: AppDimensions.space12),
            ],
          ),
        ),
      ),
    );
  }
}
