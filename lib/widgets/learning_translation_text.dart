import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../providers/translation_provider.dart';

class LearningTranslationText extends StatefulWidget {
  final String text;
  final String sourceLanguageCode;
  final String urduTranslation;
  final Map<String, String> localizedTranslations;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const LearningTranslationText({
    super.key,
    required this.text,
    this.sourceLanguageCode = 'en',
    this.urduTranslation = '',
    this.localizedTranslations = const {},
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  State<LearningTranslationText> createState() =>
      _LearningTranslationTextState();
}

class _LearningTranslationTextState extends State<LearningTranslationText> {
  String? _requestKey;
  Future<String>? _translationFuture;

  @override
  Widget build(BuildContext context) {
    final translationLanguage =
        context.watch<LanguageProvider>().selectedTranslationLanguage;
    final languageCode = translationLanguage.code;
    final localTranslation = widget.localizedTranslations[languageCode] ??
        (languageCode == 'ur' ? widget.urduTranslation : '');
    final textDirection = translationLanguage.isRightToLeft
        ? TextDirection.rtl
        : TextDirection.ltr;

    if (localTranslation.trim().isNotEmpty) {
      return Text(
        localTranslation,
        textDirection: textDirection,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        overflow: widget.overflow,
        style: widget.style,
      );
    }

    if (languageCode == widget.sourceLanguageCode) {
      return Text(
        widget.text,
        textDirection: textDirection,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        overflow: widget.overflow,
        style: widget.style,
      );
    }

    final requestKey =
        '$languageCode|${widget.sourceLanguageCode}|${widget.text}';
    if (_requestKey != requestKey) {
      _requestKey = requestKey;
      _translationFuture =
          context.read<TranslationProvider>().translateLearningContent(
                text: widget.text,
                sourceLanguageCode: widget.sourceLanguageCode,
                targetLanguageCode: languageCode,
              );
    }

    return FutureBuilder<String>(
      future: _translationFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!,
            textDirection: textDirection,
            textAlign: widget.textAlign,
            maxLines: widget.maxLines,
            overflow: widget.overflow,
            style: widget.style,
          );
        }
        if (snapshot.hasError) {
          return Text(
            'Translation unavailable in ${translationLanguage.name}.',
            textDirection: textDirection,
            textAlign: widget.textAlign,
            maxLines: widget.maxLines,
            overflow: widget.overflow,
            style: widget.style
                ?.copyWith(color: Theme.of(context).colorScheme.error),
          );
        }
        return Text(
          'Loading translation…',
          textDirection: textDirection,
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,
          overflow: widget.overflow,
          style: widget.style?.copyWith(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        );
      },
    );
  }
}
