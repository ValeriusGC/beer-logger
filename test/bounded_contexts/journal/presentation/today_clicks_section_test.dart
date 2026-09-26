import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_ui_model.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/today_clicks_section.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester,
  HomeJournalUiModel journal, {
  bool undoEnabled = true,
}) {
  return tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: CustomScrollView(
          slivers: [
            TodayClicksSection(
              journal: journal,
              undoEnabled: undoEnabled,
              undoLabel: 'Undo last tap',
              onUndo: () {},
            ),
          ],
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('пустой сегодня — empty-state, не ошибка', (tester) async {
    await _pump(tester, const HomeJournalUiEmpty('No taps today'));

    expect(find.text('No taps today'), findsOneWidget);
    expect(find.text("Couldn't load today's taps"), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('один тап — время с секундами и 0.5 L', (tester) async {
    await _pump(
      tester,
      const HomeJournalUiRows([
        (id: 'click-1', time: '14:30:00', volume: '0.5 L'),
      ]),
    );

    expect(find.byKey(const Key('today-click-click-1')), findsOneWidget);
    expect(find.text('14:30:00'), findsOneWidget);
    expect(find.text('0.5 L'), findsOneWidget);
  });

  testWidgets('loading — прогресс в секции', (tester) async {
    await _pump(tester, const HomeJournalUiLoading());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('No taps today'), findsNothing);
    expect(find.byKey(const Key('today-click-click-1')), findsNothing);
  });

  testWidgets('error — текст l10n, без сырого exception', (tester) async {
    await _pump(tester, const HomeJournalUiError("Couldn't load today's taps"));

    expect(find.text("Couldn't load today's taps"), findsOneWidget);
    expect(find.textContaining('StateError'), findsNothing);
    expect(find.textContaining('boom'), findsNothing);
    expect(find.text('No taps today'), findsNothing);
  });

  testWidgets('пустой сегодня — undo находится и enabled', (tester) async {
    await _pump(
      tester,
      const HomeJournalUiEmpty('No taps today'),
      undoEnabled: true,
    );

    final button = tester.widget<TextButton>(
      find.widgetWithText(TextButton, 'Undo last tap'),
    );
    expect(button.onPressed, isNotNull);
  });

  testWidgets('undo isLoading — кнопка disabled', (tester) async {
    await _pump(
      tester,
      const HomeJournalUiEmpty('No taps today'),
      undoEnabled: false,
    );

    expect(
      tester
          .widget<TextButton>(find.widgetWithText(TextButton, 'Undo last tap'))
          .onPressed,
      isNull,
    );
  });
}
