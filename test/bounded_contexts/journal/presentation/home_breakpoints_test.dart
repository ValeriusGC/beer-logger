import 'dart:async';

import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _compactBody = Key('home-compact-body');
const _wideBody = Key('home-wide-body');
const _balanceChartRow = Key('home-balance-chart-row');

PeriodBalances _emptyBalances() {
  return PeriodBalances(
    totalsInBase: {
      LedgerAxisKind.volume: SignedBaseDelta.volume(0),
      LedgerAxisKind.energy: SignedBaseDelta.energy(0),
      LedgerAxisKind.money: SignedBaseDelta.money(0),
      LedgerAxisKind.joy: SignedBaseDelta.joy(0),
    },
  );
}

/// [build] завершён — кнопка активна.
class _ReadyRecordClick extends RecordClick {
  @override
  FutureOr<void> build() {}
}

Future<void> _pumpHome(WidgetTester tester, {required double width}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = Size(width, 900);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        todayBalanceProvider.overrideWithValue(AsyncData(_emptyBalances())),
        recordClickProvider.overrideWith(() => _ReadyRecordClick()),
        clicksForTodayProvider.overrideWithValue(const AsyncData(<Click>[])),
        currentClickerProvider.overrideWith(
          (ref) => Stream.value(beerHalfLiter()),
        ),
        volumeForLast7DaysProvider.overrideWithValue(
          AsyncData([
            for (var index = 0; index < 7; index++)
              DayVolume(day: DateTime(2026, 9, 15 + index), liters: 0),
          ]),
        ),
      ],
      child: const MaterialApp(
        locale: Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: HomePage(),
      ),
    ),
  );
  await tester.pump();
}

Future<void> _resizeHome(WidgetTester tester, {required double width}) async {
  tester.view.physicalSize = Size(width, 900);
  await tester.pump();
}

void _expectSharedSections() {
  expect(find.byType(TodayBalanceCard), findsOneWidget);
  expect(find.byType(FilledButton), findsOneWidget);
  expect(find.text('Today'), findsOneWidget);
  expect(find.byType(WeekVolumeChart), findsOneWidget);
}

void _expectCompact(WidgetTester tester) {
  expect(find.byKey(_compactBody), findsOneWidget);
  expect(find.byKey(_wideBody), findsNothing);
  expect(find.byKey(_balanceChartRow), findsNothing);
  _expectSharedSections();
  expect(
    find.descendant(
      of: find.byKey(_compactBody),
      matching: find.byType(WeekVolumeChart),
    ),
    findsOneWidget,
  );

  final chartTop = tester.getTopLeft(find.byType(WeekVolumeChart)).dy;
  final tapTop = tester.getTopLeft(find.byType(FilledButton)).dy;
  expect(chartTop, greaterThan(tapTop));
}

void _expectWide(WidgetTester tester) {
  expect(find.byKey(_wideBody), findsOneWidget);
  expect(find.byKey(_compactBody), findsNothing);
  expect(find.byKey(_balanceChartRow), findsOneWidget);
  _expectSharedSections();
  expect(
    find.descendant(
      of: find.byKey(_balanceChartRow),
      matching: find.byType(TodayBalanceCard),
    ),
    findsOneWidget,
  );
  expect(
    find.descendant(
      of: find.byKey(_balanceChartRow),
      matching: find.byType(WeekVolumeChart),
    ),
    findsOneWidget,
  );

  final chart = tester.getRect(find.byType(WeekVolumeChart));
  final balance = tester.getRect(find.byType(TodayBalanceCard));
  expect(chart.left, greaterThan(balance.left));
  expect((chart.top - balance.top).abs(), lessThan(1));
}

void main() {
  testWidgets('400px — compact body, график под кнопкой, не в ряду', (
    tester,
  ) async {
    await _pumpHome(tester, width: 400);
    _expectCompact(tester);
  });

  testWidgets('599px — всё ещё compact: порог 600 не включён', (tester) async {
    await _pumpHome(tester, width: 599);
    _expectCompact(tester);
  });

  testWidgets('600px — wide body, баланс и график в одном ряду', (
    tester,
  ) async {
    await _pumpHome(tester, width: 600);
    _expectWide(tester);
  });

  testWidgets('800px — wide body, карточка слева от графика', (tester) async {
    await _pumpHome(tester, width: 800);
    _expectWide(tester);
  });

  testWidgets('ресайз 400→800→400 переключает compact и wide', (tester) async {
    await _pumpHome(tester, width: 400);
    _expectCompact(tester);

    await _resizeHome(tester, width: 800);
    _expectWide(tester);

    await _resizeHome(tester, width: 400);
    _expectCompact(tester);
  });
}
