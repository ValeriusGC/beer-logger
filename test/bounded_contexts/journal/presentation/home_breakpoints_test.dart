import 'dart:async';

import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../week_charts_fixtures.dart';

const _compactBody = Key('home-compact-body');
const _wideBody = Key('home-wide-body');
const _balanceChartRow = Key('home-balance-chart-row');
const _tapBar = Key('home-tap-bar');
const _compactLine = Key('today-balance-compact');

/// Высота pinned-бара compact — должна совпадать с [_balanceToolbarHeight].
const _compactToolbarHeight = 72.0;

double _compactLineOpacity(WidgetTester tester) {
  return tester
      .widget<Opacity>(
        find.ancestor(
          of: find.byKey(_compactLine),
          matching: find.byType(Opacity),
        ),
      )
      .opacity;
}

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

Future<void> _pumpHome(
  WidgetTester tester, {
  required double width,
  double height = 900,
  double paddingBottom = 0,
}) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = Size(width, height);
  tester.view.padding = FakeViewPadding(bottom: paddingBottom);
  tester.view.viewPadding = FakeViewPadding(bottom: paddingBottom);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPadding);
  addTearDown(tester.view.resetViewPadding);

  await tester.pumpWidget(
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
  tester.view.physicalSize = Size(width, tester.view.physicalSize.height);
  await tester.pump();
}

void _expectSharedSections() {
  expect(find.byType(TodayBalanceCard), findsOneWidget);
  expect(find.byType(FilledButton), findsOneWidget);
  expect(find.text('Today'), findsOneWidget);
  expect(find.byType(WeekChartsCarousel), findsOneWidget);
}

void _expectTapPinned(WidgetTester tester) {
  expect(find.byKey(_tapBar), findsOneWidget);
  expect(
    find.descendant(
      of: find.byKey(_compactBody),
      matching: find.byType(FilledButton),
    ),
    findsNothing,
  );
  expect(
    find.descendant(
      of: find.byKey(_wideBody),
      matching: find.byType(FilledButton),
    ),
    findsNothing,
  );

  final tap = tester.getRect(find.byType(FilledButton));
  final scaffold = tester.getRect(find.byType(Scaffold));
  expect(tap.top, greaterThan(scaffold.center.dy));
  expect(tap.bottom, lessThanOrEqualTo(scaffold.bottom));
}

void _expectCompact(WidgetTester tester) {
  expect(find.byKey(_compactBody), findsOneWidget);
  expect(find.byKey(_wideBody), findsNothing);
  expect(find.byKey(_balanceChartRow), findsNothing);
  _expectSharedSections();
  _expectTapPinned(tester);
  expect(_compactLineOpacity(tester), lessThan(0.05));
  expect(
    find.descendant(
      of: find.byKey(_compactBody),
      matching: find.byType(WeekChartsCarousel),
    ),
    findsOneWidget,
  );

  final carouselTop = tester.getTopLeft(find.byType(WeekChartsCarousel));
  final journalTop = tester.getTopLeft(find.text('Today'));
  expect(journalTop.dy, greaterThan(carouselTop.dy));
}

Future<void> _expectWide(WidgetTester tester) async {
  await tester.pump();
  await tester.pump();
  expect(find.byKey(_wideBody), findsOneWidget);
  expect(find.byKey(_compactBody), findsNothing);
  expect(find.byKey(_balanceChartRow), findsOneWidget);
  _expectSharedSections();
  _expectTapPinned(tester);
  expect(find.byKey(_compactLine), findsNothing);
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
      matching: find.byType(WeekChartsCarousel),
    ),
    findsOneWidget,
  );

  final chart = tester.getRect(find.byType(WeekChartsCarousel));
  final balance = tester.getRect(find.byType(TodayBalanceCard));
  expect(chart.left, greaterThan(balance.left));
  expect((chart.top - balance.top).abs(), lessThan(1));
  await tester.pump();
  expect((chart.bottom - balance.bottom).abs(), lessThan(1));
}

Future<void> _collapseBody(WidgetTester tester, Key body) async {
  final scrollable = tester.state<ScrollableState>(
    find.descendant(
      of: find.byKey(body),
      matching: find.byWidgetPredicate(
        (widget) =>
            widget is Scrollable && widget.axisDirection == AxisDirection.down,
      ),
    ),
  );
  scrollable.position.jumpTo(scrollable.position.maxScrollExtent);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('400px — compact body, график в колонке, кнопка не в скролле', (
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
    await _expectWide(tester);
  });

  testWidgets('800px — wide body, карточка слева от графика', (tester) async {
    await _pumpHome(tester, width: 800);
    await _expectWide(tester);
  });

  testWidgets('ресайз 400→800→400 переключает compact и wide', (tester) async {
    await _pumpHome(tester, width: 400);
    _expectCompact(tester);

    await _resizeHome(tester, width: 800);
    await _expectWide(tester);

    await _resizeHome(tester, width: 400);
    _expectCompact(tester);
  });

  testWidgets('развёрнутая карточка ниже тулбара, не под заголовком', (
    tester,
  ) async {
    await _pumpHome(tester, width: 400);
    final card = tester.getRect(find.byType(TodayBalanceCard));
    expect(card.top, greaterThanOrEqualTo(_compactToolbarHeight - 1));
  });

  testWidgets('развёрнутая карточка на всю ширину с боковыми отступами', (
    tester,
  ) async {
    await _pumpHome(tester, width: 400);
    expect(tester.getSize(find.byType(TodayBalanceCard)).width, 368);
  });

  testWidgets('скролл вниз уводит карточку и показывает строку в AppBar', (
    tester,
  ) async {
    await _pumpHome(tester, width: 400, height: 500);
    expect(find.byKey(const Key('today-balance-volume')), findsOneWidget);
    expect(_compactLineOpacity(tester), lessThan(0.05));
    final titleBefore = tester.getTopLeft(find.text('Pivomer'));

    await _collapseBody(tester, _compactBody);

    expect(
      tester.getRect(find.byType(TodayBalanceCard)).bottom,
      lessThan(_compactToolbarHeight),
    );
    expect(_compactLineOpacity(tester), greaterThan(0.9));
    expect(tester.getTopLeft(find.text('Pivomer')), titleBefore);
    expect(find.text('0L/0kcal/0₽/0pt'), findsOneWidget);
    expect(find.text('Pivomer'), findsOneWidget);
    expect(find.byTooltip('Settings'), findsOneWidget);
    expect(find.byType(FilledButton), findsOneWidget);
    expect(tester.getSize(find.byType(AppBar)).height, closeTo(72, 1));
    expect(
      tester.getRect(find.byKey(_compactLine)).top,
      greaterThanOrEqualTo(tester.getRect(find.text('Pivomer')).bottom - 1),
    );
  });

  testWidgets('wide после скролла не показывает compact-строку AppBar', (
    tester,
  ) async {
    await _pumpHome(tester, width: 800, height: 500);
    await _collapseBody(tester, _wideBody);

    expect(find.byKey(_compactLine), findsNothing);
    expect(
      find.descendant(
        of: find.byKey(_balanceChartRow),
        matching: find.byType(TodayBalanceCard),
      ),
      findsOneWidget,
    );
  });

  testWidgets('скролл журнала не двигает кнопку записи', (tester) async {
    await _pumpHome(tester, width: 400, height: 500);
    final before = tester.getTopLeft(find.byType(FilledButton));

    await tester.drag(find.byKey(_compactBody), const Offset(0, -200));
    await tester.pumpAndSettle();

    expect(tester.getTopLeft(find.byType(FilledButton)), before);
    expect(find.byType(FilledButton), findsOneWidget);
  });

  testWidgets('home indicator — кнопка выше системного inset', (tester) async {
    const inset = 34.0;
    await _pumpHome(tester, width: 400, paddingBottom: inset);

    final tap = tester.getRect(find.byType(FilledButton));
    final scaffold = tester.getRect(find.byType(Scaffold));
    expect(tap.bottom, lessThanOrEqualTo(scaffold.bottom - inset + 0.5));
    expect(tap.bottom, greaterThan(scaffold.bottom - inset - 48));
  });
}
