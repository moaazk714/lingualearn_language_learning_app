import 'package:flutter/foundation.dart';
import '../core/data/app_mock_data.dart';
import '../models/course_model.dart';
import '../models/lesson_model.dart';
import '../services/storage_service.dart';

class CourseProvider with ChangeNotifier {
  final StorageService _storageService;

  late CourseModel _currentCourse;
  late Set<String> _completedLessonIds;
  late String _selectedLanguageCode;

  CourseProvider(this._storageService) {
    _init();
  }

  void reset() {
    _init();
    notifyListeners();
  }

  void _init() {
    _completedLessonIds = _storageService.getCompletedLessonIds().toSet();
    _selectedLanguageCode = _storageService.getSelectedLanguage();
    _currentCourse = _buildCourseWithCompletion(
      _selectedLanguageCode,
      _storageService.getSelectedLevel(),
    );
  }

  void updateForLevel(String level) {
    if (_currentCourse.level == level) return;
    _currentCourse = _buildCourseWithCompletion(_selectedLanguageCode, level);
    notifyListeners();
  }

  void updateForLanguage(String languageCode, String level) {
    if (_selectedLanguageCode == languageCode &&
        _currentCourse.level == level) {
      return;
    }
    _selectedLanguageCode = languageCode;
    _currentCourse = _buildCourseWithCompletion(languageCode, level);
    notifyListeners();
  }

  CourseModel _buildCourseWithCompletion(String languageCode, String level) {
    final baseCourse = AppMockData.getCourseForLanguage(languageCode, level);

    var previousUnitCompleted = true;
    final updatedUnits = baseCourse.units.map((unit) {
      final updatedLessons = unit.lessons.asMap().entries.map((entry) {
        final index = entry.key;
        final lesson = entry.value;

        final isCompleted = _completedLessonIds.contains(lesson.id);

        bool isLocked;
        if (index == 0) {
          isLocked = unit.unitNumber == 1 ? false : !previousUnitCompleted;
        } else {
          final prevLesson = unit.lessons[index - 1];
          final prevCompleted = _completedLessonIds.contains(prevLesson.id);
          isLocked = !prevCompleted;
        }

        return lesson.copyWith(
          isCompleted: isCompleted,
          isLocked: isLocked,
        );
      }).toList();

      final result = unit.copyWith(lessons: updatedLessons);
      previousUnitCompleted = result.isCompleted;
      return result;
    }).toList();

    return baseCourse.copyWith(units: updatedUnits);
  }

  CourseModel get currentCourse => _currentCourse;

  // Current active unit for Home Banner (defaults to Unit 2 if present)
  UnitModel get currentUnit {
    if (_currentCourse.units.length >= 2) {
      return _currentCourse.units[1]; // Unit 2
    }
    return _currentCourse.units.first;
  }

  // Current active lesson for Home Banner (Lesson 4 of Unit 2)
  LessonModel get currentLesson {
    final unit = currentUnit;
    if (unit.lessons.length >= 4) {
      return unit.lessons[3]; // Lesson 4
    }
    return unit.lessons.first;
  }

  Future<void> markLessonCompleted(String lessonId) async {
    if (_completedLessonIds.contains(lessonId)) return;
    _completedLessonIds.add(lessonId);
    await _storageService.setCompletedLessonIds(_completedLessonIds.toList());
    _currentCourse = _buildCourseWithCompletion(
      _selectedLanguageCode,
      _currentCourse.level,
    );
    notifyListeners();
  }

  LessonModel? getLessonById(String lessonId) {
    for (final unit in _currentCourse.units) {
      for (final lesson in unit.lessons) {
        if (lesson.id == lessonId) return lesson;
      }
    }
    return null;
  }
}
