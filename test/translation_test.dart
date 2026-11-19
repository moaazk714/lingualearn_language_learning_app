import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:lingualearn_app/providers/translation_provider.dart';
import 'package:lingualearn_app/screens/translation/translation_screen.dart';
import 'package:lingualearn_app/services/translation_service.dart';
import 'package:provider/provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TranslationProvider', () {
    test('supports each requested pair independently of learning language',
        () async {
      final service = _FakeTranslationService();
      final provider = TranslationProvider(service);
      const pairs = [
        ('en', 'ur'),
        ('ur', 'en'),
        ('es', 'en'),
        ('ja', 'ur'),
        ('ar', 'en'),
        ('fr', 'de'),
      ];

      for (final (source, target) in pairs) {
        provider.setSourceLanguage(source);
        provider.setTargetLanguage(target);
        provider.setInputText('sample text');
        await provider.translate();

        expect(service.lastSourceLanguageCode, source);
        expect(service.lastTargetLanguageCode, target);
        expect(provider.translatedText, 'translated: sample text');
      }

      provider.dispose();
    });

    test('swaps selected languages and invalidates the previous result',
        () async {
      final provider = TranslationProvider(_FakeTranslationService());
      provider.setSourceLanguage('es');
      provider.setTargetLanguage('en');
      provider.setInputText('Buenos días');
      await provider.translate();

      provider.swapLanguages();

      expect(provider.sourceLanguageCode, 'en');
      expect(provider.targetLanguageCode, 'es');
      expect(provider.inputText, 'Buenos días');
      expect(provider.translatedText, isNull);
      expect(provider.errorMessage, isNull);
      provider.dispose();
    });

    test('validates empty text and identical languages without a request',
        () async {
      final service = _FakeTranslationService();
      final provider = TranslationProvider(service);

      await provider.translate();
      expect(provider.errorMessage, 'Enter text to translate.');
      expect(service.callCount, 0);

      provider.setInputText('Hello');
      provider.setTargetLanguage('en');
      await provider.translate();
      expect(
        provider.errorMessage,
        'Choose two different languages to translate.',
      );
      expect(service.callCount, 0);
      provider.dispose();
    });

    test('shows loading, surfaces service errors, and retries successfully',
        () async {
      var fail = true;
      final service = _FakeTranslationService(
        onTranslate: (text, source, target) async {
          if (fail) {
            fail = false;
            throw const TranslationException('Network unavailable');
          }
          return 'Bonjour';
        },
      );
      final provider = TranslationProvider(service);
      provider.setInputText('Hello');

      await provider.translate();
      expect(provider.isLoading, isFalse);
      expect(provider.errorMessage, 'Network unavailable');
      expect(provider.canRetry, isTrue);

      await provider.translate();
      expect(provider.errorMessage, isNull);
      expect(provider.translatedText, 'Bonjour');
      provider.dispose();
    });

    test('ignores a translation response after its input changes', () async {
      final response = Completer<String>();
      final service = _FakeTranslationService(
        onTranslate: (text, source, target) => response.future,
      );
      final provider = TranslationProvider(service);
      provider.setInputText('Hello');

      final request = provider.translate();
      expect(provider.isLoading, isTrue);
      provider.setInputText('Goodbye');
      response.complete('Hola');
      await request;

      expect(provider.isLoading, isFalse);
      expect(provider.translatedText, isNull);
      expect(provider.inputText, 'Goodbye');
      provider.dispose();
    });
  });

  group('MyMemoryTranslationService', () {
    test('sends the selected pair and parses translated text', () async {
      late Uri requestUri;
      final client = MockClient((request) async {
        requestUri = request.url;
        return http.Response.bytes(
          utf8.encode(
            jsonEncode({
              'responseStatus': 200,
              'responseData': {'translatedText': 'صبح بخیر'},
            }),
          ),
          200,
        );
      });
      final service = MyMemoryTranslationService(client: client);

      final result = await service.translate(
        text: 'Good morning',
        sourceLanguageCode: 'en',
        targetLanguageCode: 'ur',
      );

      expect(result, 'صبح بخیر');
      expect(requestUri.queryParameters['langpair'], 'en|ur');
      expect(requestUri.queryParameters['q'], 'Good morning');
      service.close();
    });

    test('splits long UTF-8 text into requests below the API byte limit',
        () async {
      final requestLengths = <int>[];
      final service = MyMemoryTranslationService(
        client: MockClient((request) async {
          requestLengths.add(
            utf8.encode(request.url.queryParameters['q']!).length,
          );
          return http.Response(
            jsonEncode({
              'responseStatus': 200,
              'responseData': {'translatedText': 'x'},
            }),
            200,
          );
        }),
      );

      final result = await service.translate(
        text: '日' * 300,
        sourceLanguageCode: 'ja',
        targetLanguageCode: 'ur',
      );

      expect(requestLengths.length, greaterThan(1));
      expect(requestLengths.every((length) => length <= 500), isTrue);
      expect(result, isNotEmpty);
      service.close();
    });

    test('rejects unsupported codes and reports network failures', () async {
      final unsupportedService =
          MyMemoryTranslationService(client: MockClient((_) async {
        fail('An unsupported language must be rejected before the request.');
      }));

      await expectLater(
        unsupportedService.translate(
          text: 'Hello',
          sourceLanguageCode: 'xx',
          targetLanguageCode: 'ur',
        ),
        throwsA(isA<TranslationException>()),
      );
      unsupportedService.close();

      final networkService = MyMemoryTranslationService(
        client: MockClient((_) async {
          throw http.ClientException('Network unavailable');
        }),
      );
      await expectLater(
        networkService.translate(
          text: 'Hello',
          sourceLanguageCode: 'en',
          targetLanguageCode: 'ur',
        ),
        throwsA(
          isA<TranslationException>().having(
            (error) => error.message,
            'message',
            contains('internet connection'),
          ),
        ),
      );
      networkService.close();
    });
  });

  group('TranslationScreen', () {
    testWidgets('sets RTL input and result directions', (tester) async {
      final provider = TranslationProvider(
        _FakeTranslationService(onTranslate: (_, __, ___) async => 'أهلاً'),
      );
      provider.setSourceLanguage('ur');
      provider.setTargetLanguage('ar');
      await _pumpScreen(tester, provider);

      await tester.enterText(
          find.byKey(const ValueKey('translation-input')), 'سلام');
      await tester.tap(find.byKey(const ValueKey('translate-button')));
      await tester.pumpAndSettle();

      expect(
        tester
            .widget<TextField>(
              find.byKey(const ValueKey('translation-input')),
            )
            .textDirection,
        TextDirection.rtl,
      );
      expect(
        tester
            .widget<SelectableText>(
              find.byKey(const ValueKey('translated-text')),
            )
            .textDirection,
        TextDirection.rtl,
      );
    });

    testWidgets('copies the translated result to the clipboard',
        (tester) async {
      String? copiedText;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (call) async {
        if (call.method == 'Clipboard.setData') {
          copiedText =
              (call.arguments as Map<Object?, Object?>)['text'] as String;
        }
        return null;
      });
      addTearDown(
        () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(SystemChannels.platform, null),
      );

      final provider = TranslationProvider(
        _FakeTranslationService(onTranslate: (_, __, ___) async => 'Hola'),
      );
      await _pumpScreen(tester, provider);
      await tester.enterText(
          find.byKey(const ValueKey('translation-input')), 'Hello');
      await tester.tap(find.byKey(const ValueKey('translate-button')));
      await tester.pumpAndSettle();
      await tester
          .ensureVisible(find.byKey(const ValueKey('copy-translation')));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('copy-translation')));
      await tester.pump();

      expect(copiedText, 'Hola');
    });

    testWidgets('clear button empties the input and clears translation state',
        (tester) async {
      final provider = TranslationProvider(_FakeTranslationService());
      await _pumpScreen(tester, provider);
      await tester.enterText(
        find.byKey(const ValueKey('translation-input')),
        'Hello',
      );
      await tester.pump();

      await tester.tap(find.byKey(const ValueKey('clear-translation')));
      await tester.pump();

      expect(provider.inputText, isEmpty);
      expect(provider.translatedText, isNull);
      expect(
        tester
            .widget<TextField>(
              find.byKey(const ValueKey('translation-input')),
            )
            .controller!
            .text,
        isEmpty,
      );
    });

    testWidgets('shows a loading indicator while translation is pending',
        (tester) async {
      final response = Completer<String>();
      final provider = TranslationProvider(_FakeTranslationService(
        onTranslate: (_, __, ___) => response.future,
      ));
      await _pumpScreen(tester, provider);
      await tester.enterText(
          find.byKey(const ValueKey('translation-input')), 'Hello');
      await tester.tap(find.byKey(const ValueKey('translate-button')));
      await tester.pump();

      expect(provider.isLoading, isTrue);
      expect(find.text('Translating…'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      response.complete('Hola');
      await tester.pumpAndSettle();
      expect(find.text('Hola'), findsOneWidget);
    });

    testWidgets('shows a retry action after a network error', (tester) async {
      var fail = true;
      final provider = TranslationProvider(
        _FakeTranslationService(
          onTranslate: (_, __, ___) async {
            if (fail) {
              fail = false;
              throw const TranslationException('Network unavailable');
            }
            return 'Hola';
          },
        ),
      );
      await _pumpScreen(tester, provider);
      await tester.enterText(
          find.byKey(const ValueKey('translation-input')), 'Hello');
      await tester.tap(find.byKey(const ValueKey('translate-button')));
      await tester.pumpAndSettle();

      expect(find.text('Network unavailable'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      await tester.ensureVisible(find.text('Retry'));
      await tester.pump();
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(find.text('Hola'), findsOneWidget);
    });
  });
}

Future<void> _pumpScreen(
  WidgetTester tester,
  TranslationProvider provider,
) async {
  await tester.pumpWidget(
    ChangeNotifierProvider<TranslationProvider>.value(
      value: provider,
      child: const MaterialApp(home: TranslationScreen()),
    ),
  );
}

typedef _TranslateCallback = Future<String> Function(
  String text,
  String sourceLanguageCode,
  String targetLanguageCode,
);

class _FakeTranslationService implements TranslationService {
  final _TranslateCallback? onTranslate;
  String? lastSourceLanguageCode;
  String? lastTargetLanguageCode;
  int callCount = 0;

  _FakeTranslationService({this.onTranslate});

  @override
  Future<String> translate({
    required String text,
    required String sourceLanguageCode,
    required String targetLanguageCode,
  }) async {
    callCount++;
    lastSourceLanguageCode = sourceLanguageCode;
    lastTargetLanguageCode = targetLanguageCode;
    return onTranslate?.call(text, sourceLanguageCode, targetLanguageCode) ??
        'translated: $text';
  }

  @override
  void close() {}
}
