import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../models/quiz_model.dart';
import '../../providers/quiz_provider.dart';
import '../../widgets/custom_button.dart';
import '../../app/routes.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key});

  void _showAnswersReview(
      BuildContext context, QuizModel quiz, QuizResultModel result) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: AppDimensions.space16),
                  Text(
                    'Review Answers',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.space12),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: quiz.questions.length,
                      itemBuilder: (context, index) {
                        final q = quiz.questions[index];
                        final userChoiceIndex =
                            index < result.userSelectedIndices.length
                                ? result.userSelectedIndices[index]
                                : -1;
                        final isCorrect = userChoiceIndex == q.correctIndex;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.surfaceSecondaryDark
                                : const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isCorrect
                                  ? AppColors.successSoft
                                  : AppColors.errorSoft,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    isCorrect
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: isCorrect
                                        ? AppColors.success
                                        : AppColors.error,
                                    size: 18,
                                  ),
                                  const SizedBox(width: AppDimensions.space8),
                                  Text(
                                    'Question ${index + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: isCorrect
                                          ? AppColors.successDark
                                          : AppColors.error,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppDimensions.space8),
                              Text(
                                q.questionText,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: AppDimensions.space8),
                              Text(
                                'Your Answer: ${userChoiceIndex >= 0 ? q.options[userChoiceIndex] : 'Skipped'}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isCorrect
                                      ? AppColors.successDark
                                      : AppColors.error,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (!isCorrect)
                                Text(
                                  'Correct: ${q.options[q.correctIndex]}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.successDark,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              const SizedBox(height: AppDimensions.space6),
                              Text(
                                q.explanation,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark
                                      ? AppColors.textMutedDark
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final quizProvider = context.watch<QuizProvider>();
    final result = quizProvider.lastResult;
    final quiz = quizProvider.activeQuiz;

    if (result == null || quiz == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Results')),
        body: Center(
          child: CustomButton(
            text: 'Go to Dashboard',
            onPressed: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.main),
          ),
        ),
      );
    }

    final isGreat = result.scorePercentage >= 80;
    final isGood = result.scorePercentage >= 60;

    String feedbackTitle = '🎉 Outstanding Mastery!';
    String feedbackDesc =
        'You have an exceptional grasp of this material. Ready to conquer the next unit!';
    if (!isGreat && isGood) {
      feedbackTitle = '👍 Good Job!';
      feedbackDesc =
          'You understood most of the concepts. Review a few phrases and you\'ll be at 100%!';
    } else if (!isGood) {
      feedbackTitle = '💪 Keep Practicing!';
      feedbackDesc =
          'Language learning is all about repetition. Flip through the flashcards and try again!';
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text('Quiz Completed'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const SizedBox(height: AppDimensions.space12),

              // Animated Circular Score Ring
              CircularPercentIndicator(
                radius: 75.0,
                lineWidth: 12.0,
                animation: true,
                percent: (result.scorePercentage / 100.0).clamp(0.0, 1.0),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${result.scorePercentage.toInt()}%',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Accuracy',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: isGreat
                    ? AppColors.success
                    : isGood
                        ? AppColors.primary
                        : AppColors.streak,
                backgroundColor: isDark
                    ? AppColors.surfaceSecondaryDark
                    : const Color(0xFFE5E3F8),
              ),

              const SizedBox(height: AppDimensions.space24),

              // Feedback Title
              Text(
                feedbackTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: AppDimensions.space8),

              // Feedback Desc
              Text(
                feedbackDesc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                  height: 1.45,
                ),
              ),

              const SizedBox(height: AppDimensions.space28),

              // Breakdown Cards Row (Total, Correct, Incorrect)
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      'Total',
                      '${result.totalQuestions}',
                      Icons.format_list_numbered_rounded,
                      AppColors.primary,
                      isDark,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.space12),
                  Expanded(
                    child: _buildMetricCard(
                      'Correct',
                      '${result.correctAnswers}',
                      Icons.check_circle_rounded,
                      AppColors.success,
                      isDark,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.space12),
                  Expanded(
                    child: _buildMetricCard(
                      'Incorrect',
                      '${result.incorrectAnswers}',
                      Icons.cancel_rounded,
                      AppColors.error,
                      isDark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppDimensions.space28),

              // Review Answers Button
              OutlinedButton(
                onPressed: () => _showAnswersReview(context, quiz, result),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  side: const BorderSide(color: AppColors.primary, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppDimensions.roundedPill,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.rate_review_outlined, size: 18),
                    SizedBox(width: AppDimensions.space8),
                    Text(
                      'Review All Answers',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.space12),

              // Try Again Button
              OutlinedButton(
                onPressed: () {
                  quizProvider.resetQuiz();
                  Navigator.pushReplacementNamed(context, AppRoutes.quiz);
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  side: BorderSide(
                    color: isDark ? AppColors.borderDark : AppColors.border,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppDimensions.roundedPill,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh_rounded, size: 18),
                    SizedBox(width: AppDimensions.space8),
                    Text('Try Again'),
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.space12),

              // Continue Learning (Dashboard) Button
              CustomButton(
                text: 'Continue to Dashboard',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.main);
                },
              ),

              const SizedBox(height: AppDimensions.space16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard(
    String label,
    String value,
    IconData icon,
    Color color,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: AppDimensions.space8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.space2),
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
