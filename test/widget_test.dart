import 'dart:async';

import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
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

void main() {
  testWidgets('на locale en видна кнопка Beer 0.5', (tester) async {
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

    expect(find.text('Beer 0.5'), findsOneWidget);
  });
}
