import 'package:flutter/material.dart';
import '../models/lesson_model.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/language_selection/language_selection_screen.dart';
import '../screens/main_navigation_screen.dart';
import '../screens/lesson_details/lesson_details_screen.dart';
import '../screens/flashcards/flashcards_screen.dart';
import '../screens/quiz/quiz_screen.dart';
import '../screens/quiz_result/quiz_result_screen.dart';
import '../screens/translation/translation_screen.dart';
import '../screens/notifications/notifications_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String languageSelection = '/language-selection';
  static const String main = '/main';
  static const String lessonDetails = '/lesson-details';
  static const String flashcards = '/flashcards';
  static const String quiz = '/quiz';
  static const String quizResult = '/quiz-result';
  static const String translation = '/translation';
  static const String notifications = '/notifications';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case languageSelection:
        return MaterialPageRoute(
            builder: (_) => const LanguageSelectionScreen());

      case main:
        return MaterialPageRoute(builder: (_) => const MainNavigationScreen());

      case lessonDetails:
        final lesson = settings.arguments as LessonModel;
        return MaterialPageRoute(
          builder: (_) => LessonDetailsScreen(lesson: lesson),
        );

      case flashcards:
        return MaterialPageRoute(builder: (_) => const FlashcardsScreen());

      case quiz:
        return MaterialPageRoute(builder: (_) => const QuizScreen());

      case quizResult:
        return MaterialPageRoute(builder: (_) => const QuizResultScreen());

      case translation:
        return MaterialPageRoute(
          builder: (_) => const TranslationScreen(),
        );

      case notifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationsScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
