import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_ui_model.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/today_balance_card.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(WidgetTester tester, HomeBalanceUiModel balance) {
  return tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: TodayBalanceCard(balance: balance),
    ),
  );
}

String _value(WidgetTester tester, String key) {
  return tester.widget<Text>(find.byKey(Key(key))).data!;
}

void main() {
  testWidgets('1500 мл, 300000 cal, −45000 коп и joy 6', (tester) async {
    await _pump(
      tester,
      const HomeBalanceUiLines((
        volume: '1.5 L (1500 ml)',
        energy: '+300 kcal',
        money: '-450 ₽',
        joy: '+6 pt',
      ), compactLine: '1.5L/+300kcal/-450₽/+6pt'),
    );

    expect(_value(tester, 'today-balance-volume'), '1.5 L (1500 ml)');
    expect(_value(tester, 'today-balance-energy'), '+300 kcal');
    expect(_value(tester, 'today-balance-money'), '-450 ₽');
    expect(_value(tester, 'today-balance-joy'), '+6 pt');
  });

  testWidgets('пустой день — нули, не ошибка и не загрузка', (tester) async {
    await _pump(
      tester,
      const HomeBalanceUiLines((
        volume: '0 L (0 ml)',
        energy: '0 kcal',
        money: '0 ₽',
        joy: '0 pt',
      ), compactLine: '0L/0kcal/0₽/0pt'),
    );

    expect(_value(tester, 'today-balance-volume'), '0 L (0 ml)');
    expect(_value(tester, 'today-balance-energy'), '0 kcal');
    expect(_value(tester, 'today-balance-money'), '0 ₽');
    expect(_value(tester, 'today-balance-joy'), '0 pt');
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text("Couldn't load today's totals"), findsNothing);
  });

  testWidgets('loading — индикатор, значений нет', (tester) async {
    await _pump(tester, const HomeBalanceUiLoading());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byKey(const Key('today-balance-volume')), findsNothing);
    expect(find.byKey(const Key('today-balance-energy')), findsNothing);
    expect(find.byKey(const Key('today-balance-money')), findsNothing);
    expect(find.byKey(const Key('today-balance-joy')), findsNothing);
  });

  testWidgets('error — текст l10n, без StateError и Failure', (tester) async {
    await _pump(
      tester,
      const HomeBalanceUiError("Couldn't load today's totals"),
    );

    expect(find.text("Couldn't load today's totals"), findsOneWidget);
    expect(find.textContaining('StateError'), findsNothing);
    expect(find.textContaining('boom'), findsNothing);
    expect(find.textContaining('Failure'), findsNothing);
    expect(find.byKey(const Key('today-balance-volume')), findsNothing);
  });
}
