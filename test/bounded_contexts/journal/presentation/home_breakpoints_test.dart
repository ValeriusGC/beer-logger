import 'dart:async';

import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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

void main() {
  testWidgets('400px — карточка и график не в одном ряду', (tester) async {
    await _pumpHome(tester, width: 400);

    expect(find.byKey(const Key('home-balance-chart-row')), findsNothing);
  });

  testWidgets('800px — карточка и график в одном ряду', (tester) async {
    await _pumpHome(tester, width: 800);

    expect(find.byKey(const Key('home-balance-chart-row')), findsOneWidget);
  });
}
