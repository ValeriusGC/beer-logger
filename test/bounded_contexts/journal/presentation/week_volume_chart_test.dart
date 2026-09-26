import 'package:beer_logger/bounded_contexts/journal/application/volume_for_last_7_days.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/week_volume_chart.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

List<DayVolume> _week() {
  return [
    for (var index = 0; index < 7; index++)
      DayVolume(
        day: DateTime(2026, 9, 15 + index),
        liters: index == 6 ? 0.5 : 0,
      ),
  ];
}

Future<void> _pump(WidgetTester tester, AsyncValue<List<DayVolume>> volumes) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [volumeForLast7DaysProvider.overrideWithValue(volumes)],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(body: WeekVolumeChart()),
      ),
    ),
  );
}

void main() {
  testWidgets('заголовок и график по известным 7 точкам', (tester) async {
    await _pump(tester, AsyncData(_week()));

    expect(find.text('Volume, last 7 days'), findsOneWidget);
    expect(find.byType(BarChart), findsOneWidget);
    expect(find.text('Mon'), findsOneWidget);
    expect(find.text("Couldn't load the week chart"), findsNothing);
  });

  testWidgets('loading — индикатор, без заголовка', (tester) async {
    await _pump(tester, const AsyncLoading());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Volume, last 7 days'), findsNothing);
    expect(find.byType(BarChart), findsNothing);
  });

  testWidgets('error — текст l10n, без графика', (tester) async {
    await _pump(
      tester,
      AsyncError<List<DayVolume>>(StateError('boom'), StackTrace.empty),
    );

    expect(find.text("Couldn't load the week chart"), findsOneWidget);
    expect(find.byType(BarChart), findsNothing);
    expect(find.text('boom'), findsNothing);
  });
}
