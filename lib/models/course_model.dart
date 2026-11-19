import 'lesson_model.dart';

class UnitModel {
  final String id;
  final String courseId;
  final int unitNumber;
  final String title;
  final String description;
  final List<LessonModel> lessons;

  const UnitModel({
    required this.id,
    required this.courseId,
    required this.unitNumber,
    required this.title,
    required this.description,
    required this.lessons,
  });

  double get progressPercentage {
    if (lessons.isEmpty) return 0.0;
    final completed = lessons.where((l) => l.isCompleted).length;
    return completed / lessons.length;
  }

  int get completedCount => lessons.where((l) => l.isCompleted).length;

  bool get isCompleted =>
      lessons.isNotEmpty && lessons.every((l) => l.isCompleted);

  UnitModel copyWith({
    String? id,
    String? courseId,
    int? unitNumber,
    String? title,
    String? description,
    List<LessonModel>? lessons,
  }) {
    return UnitModel(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      unitNumber: unitNumber ?? this.unitNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      lessons: lessons ?? this.lessons,
    );
  }
}

class CourseModel {
  final String id;
  final String languageCode;
  final String level; // Beginner, Intermediate, Advanced
  final String title;
  final String description;
  final List<UnitModel> units;

  const CourseModel({
    required this.id,
    required this.languageCode,
    required this.level,
    required this.title,
    required this.description,
    required this.units,
  });

  int get totalLessons => units.fold(0, (sum, u) => sum + u.lessons.length);

  int get completedLessons => units.fold(0, (sum, u) => sum + u.completedCount);

  double get overallProgress {
    if (totalLessons == 0) return 0.0;
    return completedLessons / totalLessons;
  }

  CourseModel copyWith({
    String? id,
    String? languageCode,
    String? level,
    String? title,
    String? description,
    List<UnitModel>? units,
  }) {
    return CourseModel(
      id: id ?? this.id,
      languageCode: languageCode ?? this.languageCode,
      level: level ?? this.level,
      title: title ?? this.title,
      description: description ?? this.description,
      units: units ?? this.units,
    );
  }
}
