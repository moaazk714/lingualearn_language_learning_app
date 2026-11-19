import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../models/language_model.dart';
import '../../models/vocabulary_model.dart';
import '../../providers/language_provider.dart';
import '../../providers/vocabulary_provider.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/learning_translation_text.dart';

class AllVocabularyScreen extends StatefulWidget {
  const AllVocabularyScreen({super.key});

  @override
  State<AllVocabularyScreen> createState() => _AllVocabularyScreenState();
}

class _AllVocabularyScreenState extends State<AllVocabularyScreen> {
  final TextEditingController _searchController = TextEditingController();

  String? _selectedLanguageCode;
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _favoritesOnly = false;
  bool _learnedOnly = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _selectedLanguageCode ??=
        context.read<LanguageProvider>().selectedLanguage.id;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final vocabularyProvider = context.watch<VocabularyProvider>();
    final languageCode = _selectedLanguageCode!;
    final allWords = vocabularyProvider.wordsForLanguage(languageCode);
    final categories = allWords.map((word) => word.category).toSet().toList()
      ..sort();
    final words = allWords.where((word) {
      final query = _searchQuery.trim().toLowerCase();
      final matchesSearch = query.isEmpty ||
          word.word.toLowerCase().contains(query) ||
          word.translation.toLowerCase().contains(query) ||
          word.urduTranslation.toLowerCase().contains(query) ||
          word.localizedMeanings.values
              .any((meaning) => meaning.toLowerCase().contains(query));
      final matchesCategory =
          _selectedCategory == 'All' || word.category == _selectedCategory;
      final matchesFavorite = !_favoritesOnly || word.isFavorite;
      final matchesLearned = !_learnedOnly || word.isLearned;

      return matchesSearch &&
          matchesCategory &&
          matchesFavorite &&
          matchesLearned;
    }).toList();

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text('All Vocabulary Words'),
      ),
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildFilters(
                context,
                isDark,
                words.length,
                allWords.length,
                categories,
              ),
            ),
            if (words.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.search_off_rounded,
                  title: 'No words found',
                  message:
                      'Try another search or clear some filters to see more vocabulary.',
                  buttonText: 'Reset filters',
                  onButtonPressed: _resetFilters,
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 920),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _VocabularyWordCard(
                            word: words[index],
                            onTap: () => _showWordDetails(words[index]),
                          ),
                        ),
                      ),
                    ),
                    childCount: words.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(
    BuildContext context,
    bool isDark,
    int visibleWordCount,
    int totalWords,
    List<String> categories,
  ) {
    final language = LanguageModel.supportedLanguages.firstWhere(
      (item) => item.id == _selectedLanguageCode,
    );

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 952),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLanguageSelector(isDark, language),
              const SizedBox(height: AppDimensions.space12),
              TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search words, English, or Urdu...',
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.primary,
                  ),
                  suffixIcon: _searchQuery.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Clear search',
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                          icon: const Icon(Icons.close_rounded),
                        ),
                  filled: true,
                  fillColor: isDark ? AppColors.surfaceDark : Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: isDark
                          ? AppColors.borderDark
                          : AppColors.borderSubtle,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: isDark
                          ? AppColors.borderDark
                          : AppColors.borderSubtle,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.space12),
              SizedBox(
                height: 38,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryChip('All', isDark),
                    ...categories.map((category) {
                      return _buildCategoryChip(category, isDark);
                    }),
                  ],
                ),
              ),
              const SizedBox(height: AppDimensions.space8),
              Wrap(
                spacing: AppDimensions.space8,
                runSpacing: AppDimensions.space4,
                children: [
                  FilterChip(
                    avatar: Icon(
                      _favoritesOnly
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      size: 17,
                      color: _favoritesOnly ? Colors.white : AppColors.primary,
                    ),
                    label: const Text('Favorites'),
                    selected: _favoritesOnly,
                    onSelected: (value) =>
                        setState(() => _favoritesOnly = value),
                    selectedColor: AppColors.primary,
                    showCheckmark: false,
                  ),
                  FilterChip(
                    avatar: Icon(
                      Icons.check_circle_outline_rounded,
                      size: 17,
                      color:
                          _learnedOnly ? Colors.white : AppColors.successDark,
                    ),
                    label: const Text('Learned'),
                    selected: _learnedOnly,
                    onSelected: (value) => setState(() => _learnedOnly = value),
                    selectedColor: AppColors.success,
                    showCheckmark: false,
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.space8),
              Row(
                children: [
                  const Icon(
                    Icons.menu_book_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppDimensions.space6),
                  Expanded(
                    child: Text(
                      '$visibleWordCount of $totalWords words',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Text(
                    '${language.flagEmoji} ${language.name}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textMutedDark
                          : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(bool isDark, LanguageModel selectedLanguage) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Language',
        prefixIcon: const Icon(Icons.language_rounded),
        filled: true,
        fillColor: isDark ? AppColors.surfaceDark : Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
          ),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLanguage.id,
          isExpanded: true,
          borderRadius: BorderRadius.circular(16),
          items: LanguageModel.supportedLanguages.map((language) {
            return DropdownMenuItem(
              value: language.id,
              child: Text(
                '${language.flagEmoji}  ${language.name} · ${language.nativeName}',
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (languageCode) {
            if (languageCode != null) {
              setState(() {
                _selectedLanguageCode = languageCode;
                _selectedCategory = 'All';
              });
            }
          },
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category, bool isDark) {
    final selected = _selectedCategory == category;

    return Padding(
      padding: const EdgeInsets.only(right: AppDimensions.space8),
      child: ChoiceChip(
        label: Text(category),
        selected: selected,
        onSelected: (_) => setState(() => _selectedCategory = category),
        selectedColor: AppColors.primary,
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        labelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: selected
              ? Colors.white
              : isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondary,
        ),
        side: BorderSide(
          color: selected
              ? AppColors.primary
              : isDark
                  ? AppColors.borderDark
                  : AppColors.borderSubtle,
        ),
        showCheckmark: false,
      ),
    );
  }

  void _resetFilters() {
    _searchController.clear();
    setState(() {
      _searchQuery = '';
      _selectedCategory = 'All';
      _favoritesOnly = false;
      _learnedOnly = false;
    });
  }

  void _showWordDetails(VocabularyModel word) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.surfaceDark
          : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _VocabularyWordDetails(word: word),
    );
  }
}

class _VocabularyWordCard extends StatelessWidget {
  final VocabularyModel word;
  final VoidCallback onTap;

  const _VocabularyWordCard({
    required this.word,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      clipBehavior: Clip.antiAlias,
      color: isDark ? AppColors.surfaceDark : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: AppDimensions.space8,
                runSpacing: AppDimensions.space4,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    word.word,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text(
                    word.phonetic,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.space8),
              LearningTranslationText(
                text: word.translation,
                urduTranslation: word.urduTranslation,
                localizedTranslations: word.localizedMeanings,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: AppDimensions.space12),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.surfaceSecondaryDark
                          : AppColors.primarySoft,
                      borderRadius: AppDimensions.roundedPill,
                    ),
                    child: Text(
                      word.category,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (word.isFavorite)
                    const Padding(
                      padding: EdgeInsets.only(right: AppDimensions.space8),
                      child: Icon(
                        Icons.bookmark_rounded,
                        size: 18,
                        color: AppColors.primary,
                        semanticLabel: 'Favorite',
                      ),
                    ),
                  if (word.isLearned)
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 18,
                      color: AppColors.success,
                      semanticLabel: 'Learned',
                    ),
                  const SizedBox(width: AppDimensions.space8),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VocabularyWordDetails extends StatelessWidget {
  final VocabularyModel word;

  const _VocabularyWordDetails({required this.word});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final provider = context.watch<VocabularyProvider>();
    final currentWord = provider
        .wordsForLanguage(word.languageCode)
        .firstWhere((item) => item.id == word.id);
    final textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimary;
    final mutedColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondary;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.borderDark : AppColors.border,
                  borderRadius: AppDimensions.roundedPill,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.space20),
            Text(
              currentWord.word,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppDimensions.space6),
            Text(
              currentWord.phonetic,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppDimensions.space20),
            Text(
              'Meaning in ${context.watch<LanguageProvider>().selectedTranslationLanguage.name}',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: AppDimensions.space6),
            LearningTranslationText(
              text: currentWord.translation,
              urduTranslation: currentWord.urduTranslation,
              localizedTranslations: currentWord.localizedMeanings,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppDimensions.space20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.surfaceSecondaryDark
                    : AppColors.primarySoft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EXAMPLE',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                  ),
                  const SizedBox(height: AppDimensions.space8),
                  Text(
                    currentWord.exampleSentence,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: textColor,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                  const SizedBox(height: AppDimensions.space8),
                  LearningTranslationText(
                    text: currentWord.exampleTranslation,
                    urduTranslation: currentWord.exampleUrduTranslation,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: mutedColor,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.space20),
            Wrap(
              spacing: AppDimensions.space10,
              runSpacing: AppDimensions.space8,
              children: [
                OutlinedButton.icon(
                  onPressed: () => provider.toggleFavorite(currentWord.id),
                  icon: Icon(
                    currentWord.isFavorite
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                  ),
                  label: Text(
                    currentWord.isFavorite ? 'Favorited' : 'Add favorite',
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => provider.toggleLearned(currentWord.id),
                  icon: Icon(
                    currentWord.isLearned
                        ? Icons.check_circle_rounded
                        : Icons.check_circle_outline_rounded,
                  ),
                  label: Text(
                    currentWord.isLearned ? 'Learned' : 'Mark learned',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.space8),
          ],
        ),
      ),
    );
  }
}
