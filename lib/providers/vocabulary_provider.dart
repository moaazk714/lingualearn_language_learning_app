import 'package:flutter/foundation.dart';
import '../core/data/app_mock_data.dart';
import '../models/vocabulary_model.dart';
import '../services/storage_service.dart';

class VocabularyProvider with ChangeNotifier {
  final StorageService _storageService;

  List<VocabularyModel> _allWords = [];
  Set<String> _favoriteIds = {};
  Set<String> _learnedIds = {};
  Set<String> _unfavoritedIds = {};
  Set<String> _unlearnedIds = {};

  String _selectedCategory = 'All';
  String _searchQuery = '';
  String _currentLanguageCode = 'es';

  VocabularyProvider(this._storageService) {
    _init();
  }

  void reset() {
    _selectedCategory = 'All';
    _searchQuery = '';
    _init();
    notifyListeners();
  }

  void _init() {
    _favoriteIds = _storageService.getFavoriteWordIds().toSet();
    _learnedIds = _storageService.getLearnedWordIds().toSet();
    _unfavoritedIds = _storageService.getUnfavoritedWordIds().toSet();
    _unlearnedIds = _storageService.getUnlearnedWordIds().toSet();
    _loadWordsForLanguage(_storageService.getSelectedLanguage());
  }

  void updateLanguage(String languageCode) {
    if (_currentLanguageCode != languageCode) {
      _currentLanguageCode = languageCode;
      _loadWordsForLanguage(languageCode);
      notifyListeners();
    }
  }

  void _loadWordsForLanguage(String code) {
    _currentLanguageCode = code;
    _allWords = _mapWordStatus(_wordsForLanguageCode(code));
  }

  List<VocabularyModel> _wordsForLanguageCode(String code) {
    return AppMockData.vocabularyForLanguage(code);
  }

  List<VocabularyModel> _mapWordStatus(List<VocabularyModel> words) {
    return words.map(_wordWithStatus).toList();
  }

  VocabularyModel _wordWithStatus(VocabularyModel word) {
    return word.copyWith(
      isFavorite: !_unfavoritedIds.contains(word.id) &&
          (_favoriteIds.contains(word.id) || word.isFavorite),
      isLearned: !_unlearnedIds.contains(word.id) &&
          (_learnedIds.contains(word.id) || word.isLearned),
    );
  }

  List<VocabularyModel> wordsForLanguage(String languageCode) {
    return _mapWordStatus(_wordsForLanguageCode(languageCode));
  }

  // All vocabulary words
  List<VocabularyModel> get allWords => _allWords;

  // Words used by the Flashcards screen
  List<VocabularyModel> get flashcardsQueue => _allWords;

  // Filtered Vocabulary according to Category & Search
  List<VocabularyModel> get filteredWords {
    return _allWords.where((item) {
      final matchesCategory = _selectedCategory == 'All' ||
          item.category.toLowerCase() == _selectedCategory.toLowerCase();

      final query = _searchQuery.toLowerCase();

      final matchesSearch = query.isEmpty ||
          item.word.toLowerCase().contains(query) ||
          item.translation.toLowerCase().contains(query) ||
          item.urduTranslation.toLowerCase().contains(query) ||
          item.localizedMeanings.values
              .any((meaning) => meaning.toLowerCase().contains(query)) ||
          item.exampleSentence.toLowerCase().contains(query) ||
          item.exampleTranslation.toLowerCase().contains(query) ||
          item.exampleUrduTranslation.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  // Favorite vocabulary words
  List<VocabularyModel> get favoriteWords =>
      _allWords.where((word) => word.isFavorite).toList();

  // Learned vocabulary words
  List<VocabularyModel> get learnedWords =>
      _allWords.where((word) => word.isLearned).toList();

  // Word of the Day
  VocabularyModel get wordOfTheDay {
    if (_allWords.isNotEmpty) {
      return _allWords.first;
    }

    return AppMockData.spanishVocabulary.first;
  }

  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  void setCategory(String category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> toggleFavorite(String wordId) async {
    final index = _allWords.indexWhere((word) => word.id == wordId);
    final current = index == -1 ? _findWord(wordId) : _allWords[index];

    if (current != null) {
      final newStatus = !current.isFavorite;

      if (index != -1) {
        _allWords[index] = current.copyWith(isFavorite: newStatus);
      }

      if (newStatus) {
        _favoriteIds.add(wordId);
        _unfavoritedIds.remove(wordId);
      } else {
        _favoriteIds.remove(wordId);
        _unfavoritedIds.add(wordId);
      }

      await _storageService.setFavoriteWordIds(_favoriteIds.toList());
      await _storageService.setUnfavoritedWordIds(_unfavoritedIds.toList());
      notifyListeners();
    }
  }

  Future<void> toggleLearned(String wordId) async {
    final index = _allWords.indexWhere((word) => word.id == wordId);
    final current = index == -1 ? _findWord(wordId) : _allWords[index];

    if (current != null) {
      final newStatus = !current.isLearned;

      if (index != -1) {
        _allWords[index] = current.copyWith(isLearned: newStatus);
      }

      if (newStatus) {
        _learnedIds.add(wordId);
        _unlearnedIds.remove(wordId);
      } else {
        _learnedIds.remove(wordId);
        _unlearnedIds.add(wordId);
      }

      await _storageService.setLearnedWordIds(_learnedIds.toList());
      await _storageService.setUnlearnedWordIds(_unlearnedIds.toList());
      notifyListeners();
    }
  }

  VocabularyModel? _findWord(String wordId) {
    for (final languageCode in const ['es', 'fr', 'de', 'ja', 'en', 'ar']) {
      for (final word in _wordsForLanguageCode(languageCode)) {
        if (word.id == wordId) {
          return _wordWithStatus(word);
        }
      }
    }
    return null;
  }
}
