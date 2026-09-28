import 'package:beer_logger/bounded_contexts/journal/domain/click/aggregate_for_period.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click_repository.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/beer_half_liter.dart';
import 'package:beer_logger/core/di/click_repository.cg.dart';
import 'package:beer_logger/core/di/now.cg.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'week_axis_charts_for_last_7_days.cg.g.dart';

/// Значение одной оси за локальный день на недельном графике.
///
/// [value] — в единице отображения оси (л, ккал, ₽, pt), со знаком.
final class DayAxisPoint {
  /// Создаёт точку графика.
  const DayAxisPoint({required this.day, required this.value});

  /// Начало локального календарного дня.
  final DateTime day;

  /// Сумма вкладов оси за день в display unit.
  final double value;
}

/// Серия из семи дней для одной оси dashboard'а.
final class WeekAxisChartSeries {
  /// Создаёт серию недельного графика.
  const WeekAxisChartSeries({required this.kind, required this.days});

  /// Ось пресета (volume, energy, money, joy).
  final LedgerAxisKind kind;

  /// Семь точек: индекс 0 — самый старый день, 6 — сегодня.
  final List<DayAxisPoint> days;
}

const _dashboardKinds = [
  LedgerAxisKind.volume,
  LedgerAxisKind.energy,
  LedgerAxisKind.money,
  LedgerAxisKind.joy,
];

/// Семь локальных дней по четырём осям пресета, заканчивая [now].
///
/// Одна подписка [ClickRepository.watchClicksInRange] на всё окно;
/// по дню сумму считает [aggregateForPeriod], не виджет. Пустой день — 0.
/// [Failure.invalidPeriod] сюда не приходит: каждый день это `[start, start+1)`.
@riverpod
Stream<List<WeekAxisChartSeries>> weekAxisChartsForLast7Days(Ref ref) {
  final now = ref.watch(nowProvider);
  final today = DateTime(now.year, now.month, now.day);
  final from = today.subtract(const Duration(days: 6));
  final to = today.add(const Duration(days: 1));

  return ref
      .watch(clickRepositoryProvider)
      .watchClicksInRange(fromLocal: from, toLocal: to)
      .map((clicks) => _chartSeries(clicks, from));
}

List<WeekAxisChartSeries> _chartSeries(List<Click> clicks, DateTime firstDay) {
  return [
    for (final kind in _dashboardKinds)
      WeekAxisChartSeries(
        kind: kind,
        days: [
          for (var offset = 0; offset < 7; offset++)
            _dayPoint(clicks, kind, firstDay.add(Duration(days: offset))),
        ],
      ),
  ];
}

DayAxisPoint _dayPoint(List<Click> clicks, LedgerAxisKind kind, DateTime day) {
  final from = DateTime(day.year, day.month, day.day);
  final to = from.add(const Duration(days: 1));
  final balances = aggregateForPeriod(
    clicks: clicks,
    kinds: beerHalfLiter().axes.map((axis) => axis.kind).toList(),
    from: from,
    to: to,
  ).getOrElse((failure) => throw StateError('aggregateForPeriod: $failure'));

  return DayAxisPoint(
    day: from,
    value: _displayValue(kind, balances.totalFor(kind).signedBase),
  );
}

double _displayValue(LedgerAxisKind kind, double signedBase) {
  return switch (kind) {
    LedgerAxisKind.volume => fromBase(signedBase, VolumeUnit.liter),
    LedgerAxisKind.energy => fromBase(signedBase, EnergyUnit.kilocalorie),
    LedgerAxisKind.money => fromBase(signedBase, MoneyUnit.rouble),
    LedgerAxisKind.joy => fromBase(signedBase, CountUnit.point),
  };
}
