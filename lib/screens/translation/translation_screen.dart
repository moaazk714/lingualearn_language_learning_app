import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../models/translation_language.dart';
import '../../providers/translation_provider.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({super.key});

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  final TextEditingController _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  Future<void> _copyTranslation(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Translation copied')),
    );
  }

  void _clearText() {
    _inputController.clear();
    context.read<TranslationProvider>().clearText();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TranslationProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surfaceColor = isDark ? AppColors.surfaceDark : Colors.white;
    final borderColor = isDark ? AppColors.borderDark : AppColors.borderSubtle;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.translation)),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(AppDimensions.space20),
          children: [
            Text(
              'Translate between languages',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppDimensions.space6),
            Text(
              'Choose any source and target language independently of your learning path.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppDimensions.space20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.space12),
                child: Row(
                  children: [
                    Expanded(
                      child: _LanguageSelector(
                        key: ValueKey(
                          'source-${provider.sourceLanguageCode}',
                        ),
                        label: 'From',
                        value: provider.sourceLanguageCode,
                        onChanged: provider.setSourceLanguage,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.space4),
                    IconButton(
                      key: const ValueKey('swap-languages'),
                      tooltip: 'Swap languages',
                      onPressed: provider.swapLanguages,
                      icon: const Icon(Icons.swap_horiz_rounded),
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: AppDimensions.space4),
                    Expanded(
                      child: _LanguageSelector(
                        key: ValueKey(
                          'target-${provider.targetLanguageCode}',
                        ),
                        label: 'To',
                        value: provider.targetLanguageCode,
                        onChanged: provider.setTargetLanguage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.space16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.space16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.sourceLanguage.name,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: AppDimensions.space8),
                    TextField(
                      key: const ValueKey('translation-input'),
                      controller: _inputController,
                      minLines: 5,
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      textDirection: provider.sourceLanguage.isRightToLeft
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      textAlign: provider.sourceLanguage.isRightToLeft
                          ? TextAlign.right
                          : TextAlign.left,
                      onChanged: provider.setInputText,
                      decoration: InputDecoration(
                        hintText: 'Enter text to translate',
                        filled: true,
                        fillColor: isDark
                            ? AppColors.surfaceSecondaryDark
                            : AppColors.surfaceSecondary,
                        border: OutlineInputBorder(
                          borderRadius: AppDimensions.roundedMedium,
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            const EdgeInsets.all(AppDimensions.space12),
                        suffixIcon: provider.inputText.isEmpty
                            ? null
                            : IconButton(
                                key: const ValueKey('clear-translation'),
                                tooltip: 'Clear text',
                                onPressed: _clearText,
                                icon: const Icon(Icons.clear_rounded),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.space12),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                key: const ValueKey('translate-button'),
                onPressed:
                    provider.isLoading ? null : () => provider.translate(),
                icon: provider.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.translate_rounded),
                label: Text(provider.isLoading ? 'Translating…' : 'Translate'),
              ),
            ),
            if (provider.errorMessage != null) ...[
              const SizedBox(height: AppDimensions.space12),
              _MessageCard(
                color: AppColors.error,
                message: provider.errorMessage!,
                child: provider.canRetry
                    ? TextButton.icon(
                        onPressed: provider.isLoading
                            ? null
                            : () => provider.translate(),
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Retry'),
                      )
                    : null,
              ),
            ],
            if (provider.translatedText != null) ...[
              const SizedBox(height: AppDimensions.space16),
              Card(
                key: const ValueKey('translation-result'),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.space16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              provider.targetLanguage.name,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          IconButton(
                            key: const ValueKey('copy-translation'),
                            tooltip: 'Copy translation',
                            onPressed: () =>
                                _copyTranslation(provider.translatedText!),
                            icon: const Icon(Icons.copy_rounded),
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.space8),
                      SelectableText(
                        provider.translatedText!,
                        key: const ValueKey('translated-text'),
                        textDirection: provider.targetLanguage.isRightToLeft
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        textAlign: provider.targetLanguage.isRightToLeft
                            ? TextAlign.right
                            : TextAlign.left,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: AppDimensions.space16),
            Container(
              padding: const EdgeInsets.all(AppDimensions.space12),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: AppDimensions.roundedMedium,
                border: Border.all(color: borderColor),
              ),
              child: Text(
                'Online translation by MyMemory. Text is sent to the translation service. '
                'Free anonymous use is limited to 5,000 characters per day; an internet connection is required.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  const _LanguageSelector({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: AppDimensions.roundedMedium,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.space8,
          vertical: AppDimensions.space10,
        ),
      ),
      items: TranslationLanguage.supportedLanguages
          .map(
            (language) => DropdownMenuItem(
              value: language.code,
              child: Text(
                language.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: (code) {
        if (code != null) onChanged(code);
      },
    );
  }
}

class _MessageCard extends StatelessWidget {
  final Color color;
  final String message;
  final Widget? child;

  const _MessageCard({
    required this.color,
    required this.message,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.space12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: AppDimensions.roundedMedium,
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: TextStyle(color: color)),
          if (child != null) ...[
            const SizedBox(height: AppDimensions.space4),
            child!,
          ],
        ],
      ),
    );
  }
}
