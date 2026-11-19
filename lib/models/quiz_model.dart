class QuizQuestionModel {
  final String id;
  final String questionText;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestionModel({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class QuizModel {
  final String id;
  final String title;
  final String description;
  final List<QuizQuestionModel> questions;

  const QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });
}

class QuizResultModel {
  final String quizId;
  final String quizTitle;
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final double scorePercentage;
  final DateTime dateTaken;
  final List<int> userSelectedIndices;

  const QuizResultModel({
    required this.quizId,
    required this.quizTitle,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.scorePercentage,
    required this.dateTaken,
    required this.userSelectedIndices,
  });

  Map<String, dynamic> toMap() {
    return {
      'quizId': quizId,
      'quizTitle': quizTitle,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'scorePercentage': scorePercentage,
      'dateTaken': dateTaken.toIso8601String(),
      'userSelectedIndices': userSelectedIndices,
    };
  }

  factory QuizResultModel.fromMap(Map<String, dynamic> map) {
    return QuizResultModel(
      quizId: map['quizId'] ?? '',
      quizTitle: map['quizTitle'] ?? 'Quiz',
      totalQuestions: map['totalQuestions'] ?? 0,
      correctAnswers: map['correctAnswers'] ?? 0,
      incorrectAnswers: map['incorrectAnswers'] ?? 0,
      scorePercentage: (map['scorePercentage'] as num?)?.toDouble() ?? 0.0,
      dateTaken: DateTime.tryParse(map['dateTaken'] ?? '') ?? DateTime.now(),
      userSelectedIndices:
          List<int>.from(map['userSelectedIndices'] ?? const []),
    );
  }
}
