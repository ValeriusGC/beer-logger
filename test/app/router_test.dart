import 'dart:async';

import 'package:beer_logger/app/router.dart';
import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../bounded_contexts/journal/week_charts_fixtures.dart';

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

Future<void> _pumpApp(WidgetTester tester) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        todayBalanceProvider.overrideWithValue(AsyncData(_emptyBalances())),
        recordClickProvider.overrideWith(() => _ReadyRecordClick()),
        clicksForTodayProvider.overrideWithValue(const AsyncData(<Click>[])),
        currentClickerProvider.overrideWith(
          (ref) => Stream.value(beerHalfLiter()),
        ),
        weekAxisChartsForLast7DaysProvider.overrideWithValue(
          AsyncData(emptyWeekAxisCharts()),
        ),
      ],
      child: MaterialApp.router(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: beerLoggerRouter,
      ),
    ),
  );
}

void main() {
  setUp(() => beerLoggerRouter.go('/'));

  tearDown(() => beerLoggerRouter.go('/'));

  testWidgets(
    'go /settings собирает стек главная → настройки, pop снимает его',
    (tester) async {
      await _pumpApp(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Settings'));
      await tester.pumpAndSettle();

      expect(beerLoggerRouter.state.matchedLocation, '/settings');
      expect(
        tester
            .state<NavigatorState>(find.byType(Navigator))
            .widget
            .pages
            .map((page) => page.name),
        ['/', 'settings'],
      );
      expect(find.byType(SettingsPage), findsOneWidget);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      expect(beerLoggerRouter.state.matchedLocation, '/');
      expect(find.byType(SettingsPage), findsNothing);
      expect(find.text('Beer 0.5'), findsOneWidget);
    },
  );
}
