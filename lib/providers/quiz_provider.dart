import 'package:flutter/foundation.dart';
import '../core/data/quiz_catalog.dart';
import '../models/language_model.dart';
import '../models/quiz_model.dart';
import '../services/storage_service.dart';

class QuizProvider with ChangeNotifier {
  final StorageService _storageService;

  QuizModel? _activeQuiz;
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  bool _isAnswerChecked = false;
  final List<int> _userSelectedAnswers = [];
  int _correctAnswersCount = 0;
  bool _isQuizFinished = false;
  QuizResultModel? _lastResult;
  late String _selectedLanguageCode;

  QuizProvider(this._storageService) {
    _selectedLanguageCode = _storageService.getSelectedLanguage();
  }

  void reset() {
    _clearQuizState();
    notifyListeners();
  }

  QuizModel? get activeQuiz => _activeQuiz;
  int get currentQuestionIndex => _currentQuestionIndex;
  int? get selectedOptionIndex => _selectedOptionIndex;
  bool get isAnswerChecked => _isAnswerChecked;
  bool get isQuizFinished => _isQuizFinished;
  QuizResultModel? get lastResult => _lastResult;
  String get selectedLanguageCode => _selectedLanguageCode;
  List<QuizModel> get availableQuizzes =>
      QuizCatalog.forLanguage(_selectedLanguageCode);

  String get quizUnavailableMessage {
    final language = LanguageModel.supportedLanguages.firstWhere(
      (item) => item.id == _selectedLanguageCode,
      orElse: () => LanguageModel.supportedLanguages.first,
    );
    return 'Quiz questions are not yet available for ${language.name}.';
  }

  QuizQuestionModel? get currentQuestion {
    if (_activeQuiz == null ||
        _currentQuestionIndex >= _activeQuiz!.questions.length) {
      return null;
    }
    return _activeQuiz!.questions[_currentQuestionIndex];
  }

  int get totalQuestions => _activeQuiz?.questions.length ?? 0;
  double get quizProgress => totalQuestions == 0
      ? 0.0
      : ((_currentQuestionIndex + 1) / totalQuestions).clamp(0.0, 1.0);

  void updateLanguage(String languageCode) {
    if (_selectedLanguageCode == languageCode) return;
    _selectedLanguageCode = languageCode;
    _clearQuizState();
    notifyListeners();
  }

  void startQuiz(QuizModel quiz) {
    final matchingQuizzes =
        availableQuizzes.where((available) => available.id == quiz.id);
    if (matchingQuizzes.isEmpty) {
      throw UnsupportedError(quizUnavailableMessage);
    }

    _activeQuiz = matchingQuizzes.first;
    _currentQuestionIndex = 0;
    _selectedOptionIndex = null;
    _isAnswerChecked = false;
    _userSelectedAnswers.clear();
    _correctAnswersCount = 0;
    _isQuizFinished = false;
    _lastResult = null;
    notifyListeners();
  }

  void startQuickQuiz() {
    if (availableQuizzes.isEmpty) {
      throw UnsupportedError(quizUnavailableMessage);
    }
    startQuiz(availableQuizzes.first);
  }

  void startQuizById(String quizId) {
    final matchingQuizzes =
        availableQuizzes.where((available) => available.id == quizId);
    if (matchingQuizzes.isEmpty) {
      throw UnsupportedError(quizUnavailableMessage);
    }
    startQuiz(matchingQuizzes.first);
  }

  void selectOption(int optionIndex) {
    if (_isAnswerChecked) return; // Prevent changing after check
    if (_selectedOptionIndex == optionIndex) return;
    _selectedOptionIndex = optionIndex;
    notifyListeners();
  }

  void checkAnswer() {
    if (_selectedOptionIndex == null || _isAnswerChecked) return;
    _isAnswerChecked = true;

    final question = currentQuestion;
    if (question != null) {
      if (_selectedOptionIndex == question.correctIndex) {
        _correctAnswersCount++;
      }
      _userSelectedAnswers.add(_selectedOptionIndex!);
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (_activeQuiz == null) return;

    if (_currentQuestionIndex < _activeQuiz!.questions.length - 1) {
      _currentQuestionIndex++;
      _selectedOptionIndex = null;
      _isAnswerChecked = false;
      notifyListeners();
    } else {
      finishQuiz();
    }
  }

  Future<void> finishQuiz() async {
    if (_activeQuiz == null || _isQuizFinished) return;

    final total = _activeQuiz!.questions.length;
    final incorrect = total - _correctAnswersCount;
    final percentage = total == 0 ? 0.0 : (_correctAnswersCount / total) * 100;

    _lastResult = QuizResultModel(
      quizId: _activeQuiz!.id,
      quizTitle: _activeQuiz!.title,
      totalQuestions: total,
      correctAnswers: _correctAnswersCount,
      incorrectAnswers: incorrect,
      scorePercentage: percentage,
      dateTaken: DateTime.now(),
      userSelectedIndices: List.from(_userSelectedAnswers),
    );

    _isQuizFinished = true;
    if (!await _storageService.saveQuizScore(_lastResult!.toMap())) {
      _isQuizFinished = false;
      throw StateError('Unable to persist the completed quiz result.');
    }
    notifyListeners();
  }

  void resetQuiz() {
    if (_activeQuiz != null) {
      startQuiz(_activeQuiz!);
    }
  }

  void _clearQuizState() {
    _activeQuiz = null;
    _currentQuestionIndex = 0;
    _selectedOptionIndex = null;
    _isAnswerChecked = false;
    _userSelectedAnswers.clear();
    _correctAnswersCount = 0;
    _isQuizFinished = false;
    _lastResult = null;
  }
}
