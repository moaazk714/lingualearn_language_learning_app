import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../models/vocabulary_model.dart';
import '../../providers/language_provider.dart';
import '../../providers/vocabulary_provider.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/learning_translation_text.dart';
import '../../services/tts_service.dart';
import 'all_vocabulary_screen.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _categories = const [
    'All',
    'Greetings',
    'Food & Dining',
    'Travel',
    'Numbers',
    'Family',
    'Home',
    'Education',
    'Animals',
    'Weather',
    'Shopping',
    'Work',
    'Daily Activities',
    'Health',
    'Nature',
    'Technology',
  ];

  bool _showFavoritesOnly = false;
  bool _showLearnedOnly = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final vocabProvider = context.watch<VocabularyProvider>();
    final langProvider = context.watch<LanguageProvider>();

    var words = vocabProvider.filteredWords;
    if (_showFavoritesOnly) {
      words = words.where((w) => w.isFavorite).toList();
    }
    if (_showLearnedOnly) {
      words = words.where((w) => w.isLearned).toList();
    }

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Vocabulary Library'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceSecondaryDark
                      : AppColors.primarySoft,
                  borderRadius: AppDimensions.roundedPill,
                ),
                child: Text(
                  '${words.length} Words',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
                    child: Tooltip(
                      message: 'Browse vocabulary in all six languages',
                      child: OutlinedButton(
                        key: const ValueKey('allVocabularyButton'),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const AllVocabularyScreen(),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.language_rounded,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: AppDimensions.space12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'All Words',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: AppColors.primary),
                                  ),
                                  Text(
                                    'Browse all six languages',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Search Input Field
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        vocabProvider.setSearchQuery(val);
                      },
                      decoration: InputDecoration(
                        hintText:
                            'Search in ${langProvider.selectedLanguage.name}, English or Urdu...',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.textMutedDark
                              : AppColors.textMuted,
                        ),
                        prefixIcon: const Icon(Icons.search_rounded,
                            color: AppColors.primary, size: 20),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  vocabProvider.setSearchQuery('');
                                },
                              )
                            : null,
                        filled: true,
                        fillColor:
                            isDark ? AppColors.surfaceDark : Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
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
                          borderSide: const BorderSide(
                              color: AppColors.primary, width: 1.5),
                        ),
                      ),
                    ),
                  ),

                  // Horizontal Category Pills
                  SizedBox(
                    height: 38,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        final isSelected =
                            vocabProvider.selectedCategory == cat;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(cat),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                vocabProvider.setCategory(cat);
                              }
                            },
                            labelStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? Colors.white
                                  : (isDark
                                      ? AppColors.textSecondaryDark
                                      : AppColors.textSecondary),
                            ),
                            selectedColor: AppColors.primary,
                            backgroundColor:
                                isDark ? AppColors.surfaceDark : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: AppDimensions.roundedPill,
                              side: BorderSide(
                                color: isSelected
                                    ? AppColors.primary
                                    : (isDark
                                        ? AppColors.borderDark
                                        : AppColors.borderSubtle),
                              ),
                            ),
                            showCheckmark: false,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: AppDimensions.space10),

                  // Filter Toggles (Favorites & Learned)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      spacing: AppDimensions.space8,
                      runSpacing: AppDimensions.space4,
                      children: [
                        FilterChip(
                          label: const Text('Saved Favorites'),
                          avatar: Icon(
                            _showFavoritesOnly
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            size: 14,
                            color: _showFavoritesOnly
                                ? Colors.white
                                : AppColors.primary,
                          ),
                          selected: _showFavoritesOnly,
                          onSelected: (val) {
                            setState(() {
                              _showFavoritesOnly = val;
                            });
                          },
                          selectedColor: AppColors.primary,
                          backgroundColor:
                              isDark ? AppColors.surfaceDark : Colors.white,
                          labelStyle: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _showFavoritesOnly
                                ? Colors.white
                                : AppColors.primary,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppDimensions.roundedPill,
                            side: const BorderSide(
                                color: AppColors.primary, width: 1),
                          ),
                          showCheckmark: false,
                        ),
                        FilterChip(
                          label: const Text('Learned'),
                          avatar: Icon(
                            Icons.check_circle_rounded,
                            size: 14,
                            color: _showLearnedOnly
                                ? Colors.white
                                : AppColors.success,
                          ),
                          selected: _showLearnedOnly,
                          onSelected: (val) {
                            setState(() {
                              _showLearnedOnly = val;
                            });
                          },
                          selectedColor: AppColors.success,
                          backgroundColor:
                              isDark ? AppColors.surfaceDark : Colors.white,
                          labelStyle: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _showLearnedOnly
                                ? Colors.white
                                : AppColors.successDark,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppDimensions.roundedPill,
                            side: const BorderSide(
                                color: AppColors.success, width: 1),
                          ),
                          showCheckmark: false,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppDimensions.space10),
                ],
              ),
            ),
            if (words.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.search_off_rounded,
                  title: 'No Words Found',
                  message:
                      'Try adjusting your search query or removing the filters.',
                  buttonText: 'Reset Filters',
                  onButtonPressed: () {
                    setState(() {
                      _showFavoritesOnly = false;
                      _showLearnedOnly = false;
                      _searchController.clear();
                    });
                    vocabProvider.setCategory('All');
                    vocabProvider.setSearchQuery('');
                  },
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = words[index];
                      return _buildVocabularyItem(
                        context,
                        item,
                        isDark,
                        vocabProvider,
                      );
                    },
                    childCount: words.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVocabularyItem(
    BuildContext context,
    VocabularyModel item,
    bool isDark,
    VocabularyProvider provider,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
        ),
        boxShadow: isDark ? null : AppDimensions.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: AppDimensions.space8,
                      runSpacing: AppDimensions.space4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          item.word,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          item.phonetic,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.space4),
                    LearningTranslationText(
                      text: item.translation,
                      urduTranslation: item.urduTranslation,
                      localizedTranslations: item.localizedMeanings,
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      item.partOfSpeech,
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark
                            ? AppColors.textMutedDark
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),

              // Audio Pronunciation Button
              IconButton(
                icon: const Icon(
                  Icons.volume_up_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
                onPressed: () async {
                  final languageId =
                      context.read<LanguageProvider>().selectedLanguage.id;

                  try {
                    await TtsService.instance.speak(
                      item.word,
                      languageId: languageId,
                    );
                  } catch (e) {
                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pronunciation unavailable.'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
              ),

              // Favorite Bookmark Button
              IconButton(
                icon: Icon(
                  item.isFavorite
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
                onPressed: () {
                  provider.toggleFavorite(item.id);
                },
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.space10),

          // Example Sentence Quote Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceSecondaryDark
                  : const Color(0xFFF6F5FE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '"${item.exampleSentence}"',
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                LearningTranslationText(
                  text: item.exampleTranslation,
                  urduTranslation: item.exampleUrduTranslation,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark
                        ? AppColors.textMutedDark
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.space10),

          // Category Pill & Learned Status
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: AppDimensions.space4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                item.category,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.textMutedDark : AppColors.textMuted,
                ),
              ),
              InkWell(
                onTap: () {
                  provider.toggleLearned(item.id);
                },
                child: Row(
                  children: [
                    Icon(
                      item.isLearned
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      size: 15,
                      color: item.isLearned
                          ? AppColors.success
                          : AppColors.textMuted,
                    ),
                    const SizedBox(width: AppDimensions.space4),
                    Text(
                      item.isLearned ? 'Learned' : 'Mark as Learned',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: item.isLearned
                            ? AppColors.successDark
                            : AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
