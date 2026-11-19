class LessonModel {
  final String id;
  final String unitId;
  final int lessonNumber;
  final String title;
  final String description;
  final int durationMinutes;
  final List<String> objectives;
  final List<String> vocabularyIds;
  final String quizId;
  final bool isCompleted;
  final bool isLocked;

  const LessonModel({
    required this.id,
    required this.unitId,
    required this.lessonNumber,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.objectives,
    required this.vocabularyIds,
    required this.quizId,
    this.isCompleted = false,
    this.isLocked = false,
  });

  LessonModel copyWith({
    String? id,
    String? unitId,
    int? lessonNumber,
    String? title,
    String? description,
    int? durationMinutes,
    List<String>? objectives,
    List<String>? vocabularyIds,
    String? quizId,
    bool? isCompleted,
    bool? isLocked,
  }) {
    return LessonModel(
      id: id ?? this.id,
      unitId: unitId ?? this.unitId,
      lessonNumber: lessonNumber ?? this.lessonNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      objectives: objectives ?? this.objectives,
      vocabularyIds: vocabularyIds ?? this.vocabularyIds,
      quizId: quizId ?? this.quizId,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}
