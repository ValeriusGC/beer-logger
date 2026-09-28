import 'package:beer_logger/bounded_contexts/journal/application/week_axis_charts_for_last_7_days.cg.dart';
import 'package:beer_ledger_core/ledger_axis_kind.dart';

const _dashboardKinds = [
  LedgerAxisKind.volume,
  LedgerAxisKind.energy,
  LedgerAxisKind.money,
  LedgerAxisKind.joy,
];

/// Семь нулевых дней по четырём осям для override провайдера в widget-тестах.
List<WeekAxisChartSeries> emptyWeekAxisCharts() {
  return [
    for (final kind in _dashboardKinds)
      WeekAxisChartSeries(
        kind: kind,
        days: [
          for (var index = 0; index < 7; index++)
            DayAxisPoint(
              day: DateTime(2026, 9, 15 + index),
              value: 0,
            ),
        ],
      ),
  ];
}

/// Деньги за неделю: один отрицательный день.
List<WeekAxisChartSeries> weekAxisChartsWithNegativeMoney() {
  return [
    for (final kind in _dashboardKinds)
      WeekAxisChartSeries(
        kind: kind,
        days: [
          for (var index = 0; index < 7; index++)
            DayAxisPoint(
              day: DateTime(2026, 9, 15 + index),
              value: kind == LedgerAxisKind.money && index == 6 ? -150 : 0,
            ),
        ],
      ),
  ];
}

/// Одна серия с ненулевым объёмом в последний день.
List<WeekAxisChartSeries> weekAxisChartsWithVolumeTap() {
  return [
    for (final kind in _dashboardKinds)
      WeekAxisChartSeries(
        kind: kind,
        days: [
          for (var index = 0; index < 7; index++)
            DayAxisPoint(
              day: DateTime(2026, 9, 15 + index),
              value: kind == LedgerAxisKind.volume && index == 6 ? 0.5 : 0,
            ),
        ],
      ),
  ];
}
