import 'package:beer_logger/bounded_contexts/journal/application/week_axis_charts_for_last_7_days.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/week_charts_carousel.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../week_charts_fixtures.dart';

Future<void> _pump(
  WidgetTester tester,
  AsyncValue<List<WeekAxisChartSeries>> charts,
) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [
        weekAxisChartsForLast7DaysProvider.overrideWithValue(charts),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: WeekChartsCarousel()),
      ),
    ),
  );
}

void main() {
  testWidgets('первая страница — объём, четыре точки-индикатора', (tester) async {
    await _pump(tester, AsyncData(weekAxisChartsWithVolumeTap()));

    expect(find.text('Volume, last 7 days'), findsOneWidget);
    expect(find.text('0.5 L'), findsOneWidget);
    expect(find.byType(BarChart), findsOneWidget);
    expect(find.text('Mon'), findsOneWidget);
    expect(find.byKey(const Key('week-chart-page-dots')), findsOneWidget);
    expect(find.text("Couldn't load the week charts"), findsNothing);
  });

  testWidgets('свайп докручивает до следующей оси', (tester) async {
    await _pump(tester, AsyncData(emptyWeekAxisCharts()));
    await tester.pumpAndSettle();

    expect(find.text('Volume, last 7 days'), findsOneWidget);

    await tester.drag(
      find.byKey(const Key('week-charts-page-view')),
      const Offset(-400, 0),
    );
    await tester.pumpAndSettle();

    expect(find.text('Volume, last 7 days'), findsNothing);
    expect(find.text('Energy, last 7 days'), findsOneWidget);
  });

  testWidgets('loading — индикатор, без графика', (tester) async {
    await _pump(tester, const AsyncLoading());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Volume, last 7 days'), findsNothing);
    expect(find.byType(BarChart), findsNothing);
  });

  testWidgets('reload оставляет график', (tester) async {
    final reloading =
        // ignore: invalid_use_of_internal_member
        const AsyncLoading<List<WeekAxisChartSeries>>().copyWithPrevious(
          AsyncData(weekAxisChartsWithVolumeTap()),
          isRefresh: false,
        );

    await _pump(tester, reloading);

    expect(find.byType(BarChart), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('деньги — сумма в заголовке и красный столбец', (tester) async {
    await _pump(tester, AsyncData(weekAxisChartsWithNegativeMoney()));
    await tester.pumpAndSettle();

    final pageWidth = tester.getSize(
      find.byKey(const Key('week-charts-page-view')),
    ).width;
    await tester.drag(
      find.byKey(const Key('week-charts-page-view')),
      Offset(-pageWidth * 2, 0),
    );
    await tester.pumpAndSettle();

    expect(find.text('Money, last 7 days'), findsOneWidget);

    final total = tester.widget<Text>(find.text('-150 ₽'));
    final colors = Theme.of(tester.element(find.text('-150 ₽'))).colorScheme;
    expect(total.style?.color, colors.error);
  });

  testWidgets('error — текст l10n, без графика', (tester) async {
    await _pump(
      tester,
      AsyncError<List<WeekAxisChartSeries>>(
        StateError('boom'),
        StackTrace.empty,
      ),
    );

    expect(find.text("Couldn't load the week charts"), findsOneWidget);
    expect(find.byType(BarChart), findsNothing);
    expect(find.text('boom'), findsNothing);
  });
}
