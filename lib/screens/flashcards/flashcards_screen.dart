import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../models/vocabulary_model.dart';
import '../../providers/progress_provider.dart';
import '../../providers/vocabulary_provider.dart';
import '../../providers/language_provider.dart';
import '../../services/tts_service.dart';
import '../../widgets/learning_translation_text.dart';

class FlashcardsScreen extends StatefulWidget {
  const FlashcardsScreen({super.key});

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _isFront = true;
  int _currentIndex = 0;
  Future<void> _speak(String text) async {
    final languageId = context.read<LanguageProvider>().selectedLanguage.id;

    await TtsService.instance.speak(
      text,
      languageId: languageId,
    );
  }

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  void _flipCard() {
    if (_isFront) {
      _flipController.forward();
    } else {
      _flipController.reverse();
    }
    setState(() {
      _isFront = !_isFront;
    });
  }

  void _nextCard(int total) {
    if (_currentIndex < total - 1) {
      if (!_isFront) {
        _flipController.reverse();
        _isFront = true;
      }
      setState(() {
        _currentIndex++;
      });
      context
          .read<ProgressProvider>()
          .addStudyMinutes(1)
          .catchError((Object _) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Unable to save flashcard study time.'),
            ),
          );
        }
      });
    }
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      if (!_isFront) {
        _flipController.reverse();
        _isFront = true;
      }
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final vocabProvider = context.watch<VocabularyProvider>();
    final flashcards = vocabProvider.flashcardsQueue;

    if (flashcards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Flashcards')),
        body: const Center(child: Text('No flashcards available right now.')),
      );
    }

    if (_currentIndex >= flashcards.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _currentIndex = 0);
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentCard = flashcards[_currentIndex];
    final progress = (_currentIndex + 1) / flashcards.length;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text('Interactive Flashcards'),
        actions: [
          IconButton(
            icon: Icon(
              currentCard.isFavorite
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
              color: AppColors.primary,
            ),
            tooltip: 'Add to Favorites',
            onPressed: () {
              vocabProvider.toggleFavorite(currentCard.id);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            children: [
              // Progress Bar & Counter
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Card ${_currentIndex + 1} of ${flashcards.length}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: currentCard.isLearned
                          ? AppColors.successSoft
                          : (isDark
                              ? AppColors.surfaceSecondaryDark
                              : AppColors.primarySoft),
                      borderRadius: AppDimensions.roundedPill,
                    ),
                    child: Text(
                      currentCard.isLearned ? '✓ Learned' : 'In Review',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: currentCard.isLearned
                            ? AppColors.successDark
                            : AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.space8),

              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: isDark
                      ? AppColors.surfaceSecondaryDark
                      : const Color(0xFFE5E3F8),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                  minHeight: 6,
                ),
              ),

              const SizedBox(height: AppDimensions.space24),

              // Animated 3D Flip Flashcard
              Expanded(
                child: GestureDetector(
                  onTap: _flipCard,
                  child: AnimatedBuilder(
                    animation: _flipAnimation,
                    builder: (context, child) {
                      final angle = _flipAnimation.value * pi;
                      final isFrontVisible = angle < (pi / 2);

                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // 3D perspective
                          ..rotateY(angle),
                        child: isFrontVisible
                            ? _buildFrontCard(currentCard, isDark)
                            : Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..rotateY(pi),
                                child: _buildBackCard(currentCard, isDark),
                              ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.space20),

              // Tap hint
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.touch_app_outlined,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppDimensions.space6),
                  Text(
                    'Tap card to ${_isFront ? 'reveal translation' : 'see target word'}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppDimensions.space20),

              // Mark as Learned Action Button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: AppDimensions.roundedPill,
                ),
                child: OutlinedButton(
                  onPressed: () => vocabProvider.toggleLearned(currentCard.id),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: currentCard.isLearned
                        ? AppColors.successSoft
                        : Colors.transparent,
                    side: BorderSide(
                      color: currentCard.isLearned
                          ? AppColors.success
                          : AppColors.primary,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: AppDimensions.roundedPill,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        currentCard.isLearned
                            ? Icons.check_circle_rounded
                            : Icons.check_circle_outline_rounded,
                        color: currentCard.isLearned
                            ? AppColors.successDark
                            : AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: AppDimensions.space8),
                      Text(
                        currentCard.isLearned
                            ? 'Marked as Learned'
                            : 'Mark as Learned',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: currentCard.isLearned
                              ? AppColors.successDark
                              : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.space16),

              // Previous and Next Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _currentIndex > 0 ? _previousCard : null,
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: AppDimensions.roundedPill,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_rounded, size: 18),
                          SizedBox(width: AppDimensions.space6),
                          Text('Previous'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.space16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _currentIndex < flashcards.length - 1
                          ? () => _nextCard(flashcards.length)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppDimensions.roundedPill,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Next'),
                          SizedBox(width: AppDimensions.space6),
                          Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppDimensions.space12),
            ],
          ),
        ),
      ),
    );
  }

  // Front of Card: Word & Pronunciation
  Widget _buildFrontCard(VocabularyModel card, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderSubtle,
          width: 1.5,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceSecondaryDark
                  : const Color(0xFFF0EDFD),
              borderRadius: AppDimensions.roundedPill,
            ),
            child: Text(
              card.category,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          const Spacer(),

          // Target Word
          Text(
            card.word,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: AppDimensions.space10),

          // Phonetics
          Text(
            card.phonetic,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: AppDimensions.space16),

          // Speaker Button
          // Speaker Button
          Material(
            color:
                isDark ? AppColors.surfaceSecondaryDark : AppColors.primarySoft,
            shape: const CircleBorder(),
            child: IconButton(
              tooltip: 'Listen to pronunciation',
              icon: const Icon(
                Icons.volume_up_rounded,
                color: AppColors.primary,
                size: 24,
              ),
              onPressed: () => _speak(card.word),
            ),
          ),

          const Spacer(),

          Text(
            card.partOfSpeech,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: isDark ? AppColors.textMutedDark : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // Back of Card: Translation & Example Sentence
  Widget _buildBackCard(VocabularyModel card, bool isDark) {
    final translationLanguage =
        context.watch<LanguageProvider>().selectedTranslationLanguage;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.6),
          width: 2.0,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceSecondaryDark
                  : const Color(0xFFF0EDFD),
              borderRadius: AppDimensions.roundedPill,
            ),
            child: Text(
              'MEANING IN ${translationLanguage.name.toUpperCase()}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const Spacer(),

          // Translation
          LearningTranslationText(
            text: card.translation,
            urduTranslation: card.urduTranslation,
            localizedTranslations: card.localizedMeanings,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: AppDimensions.space6),

          Text(
            card.partOfSpeech,
            style: const TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(height: AppDimensions.space20),

          // Example Sentence Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.surfaceSecondaryDark
                  : const Color(0xFFF5F3FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  '"${card.exampleSentence}"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: AppDimensions.space6),
                LearningTranslationText(
                  text: card.exampleTranslation,
                  urduTranslation: card.exampleUrduTranslation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          Text(
            'Target Word: ${card.word}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textMutedDark : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
