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

/// [build] завершён — кнопка активна.
class _ReadyRecordClick extends RecordClick {
  @override
  FutureOr<void> build() {}
}

/// [build] не завершается — кнопка в loading.
class _LoadingRecordClick extends RecordClick {
  @override
  FutureOr<void> build() => Completer<void>().future;
}

Future<void> _pumpHome(
  WidgetTester tester, {
  required RecordClick recordClick,
  Stream<Clicker>? clicker,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        todayBalanceProvider.overrideWithValue(AsyncData(_emptyBalances())),
        recordClickProvider.overrideWith(() => recordClick),
        clicksForTodayProvider.overrideWithValue(const AsyncData(<Click>[])),
        volumeForLast7DaysProvider.overrideWithValue(
          AsyncData([
            for (var index = 0; index < 7; index++)
              DayVolume(day: DateTime(2026, 9, 15 + index), liters: 0),
          ]),
        ),
        currentClickerProvider.overrideWith(
          (ref) => clicker ?? Stream.value(beerHalfLiter()),
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
  testWidgets('подпись кнопки — Beer 0.5 на en', (tester) async {
    await _pumpHome(tester, recordClick: _ReadyRecordClick());

    expect(find.text('Beer 0.5'), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNotNull,
    );
  });

  testWidgets('isLoading — кнопка disabled', (tester) async {
    await _pumpHome(tester, recordClick: _LoadingRecordClick());

    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
  });

  testWidgets('кнопка показывает текущий объём', (tester) async {
    final clicker = beerHalfLiter().copyWith(
      axes: [
        for (final axis in beerHalfLiter().axes)
          if (axis.kind == LedgerAxisKind.volume)
            axis.copyWith(enteredValue: 0.6)
          else
            axis,
      ],
    );

    await _pumpHome(
      tester,
      recordClick: _ReadyRecordClick(),
      clicker: Stream.value(clicker),
    );

    expect(find.text('Beer 0.6'), findsOneWidget);
    expect(find.text('Beer 0.5'), findsNothing);
  });

  testWidgets('пока порция грузится кнопка выключена', (tester) async {
    await _pumpHome(
      tester,
      recordClick: _ReadyRecordClick(),
      clicker: Stream.fromFuture(Completer<Clicker>().future),
    );

    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
  });
}
