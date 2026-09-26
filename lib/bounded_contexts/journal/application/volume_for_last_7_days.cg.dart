import 'package:beer_logger/bounded_contexts/journal/domain/click/aggregate_for_period.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click_repository.dart';
import 'package:beer_logger/core/di/click_repository.cg.dart';
import 'package:beer_logger/core/di/now.cg.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'volume_for_last_7_days.cg.g.dart';

/// Объём одного локального дня на графике недели.
///
/// [liters] — литры, уже через [fromBase]. [day] — начало этого календарного дня.
final class DayVolume {
  /// Создаёт точку графика.
  const DayVolume({required this.day, required this.liters});

  /// Начало локального календарного дня.
  final DateTime day;

  /// Объём этого дня в литрах.
  final double liters;
}

/// Объём за семь локальных дней, заканчивая [now].
///
/// Значения — литры. Одна подписка [ClickRepository.watchClicksInRange]
/// на всё окно; по дню сумму считает [aggregateForPeriod], не виджет.
/// Всегда семь точек: пустой день — 0. Индекс 0 — самый старый день,
/// индекс 6 — сегодня. [Failure.invalidPeriod] сюда не приходит: каждый день
/// это `[start, start+1)`. Если придёт — провайдер в error, экран покажет l10n.
@riverpod
Stream<List<DayVolume>> volumeForLast7Days(Ref ref) {
  final now = ref.watch(nowProvider);
  final today = DateTime(now.year, now.month, now.day);
  final from = today.subtract(const Duration(days: 6));
  final to = today.add(const Duration(days: 1));

  return ref
      .watch(clickRepositoryProvider)
      .watchClicksInRange(fromLocal: from, toLocal: to)
      .map((clicks) => _dayVolumes(clicks, from));
}

List<DayVolume> _dayVolumes(List<Click> clicks, DateTime firstDay) {
  return [
    for (var offset = 0; offset < 7; offset++)
      _dayVolume(clicks, firstDay.add(Duration(days: offset))),
  ];
}

DayVolume _dayVolume(List<Click> clicks, DateTime day) {
  final from = DateTime(day.year, day.month, day.day);
  final to = from.add(const Duration(days: 1));
  final balances = aggregateForPeriod(
    clicks: clicks,
    kinds: const [LedgerAxisKind.volume],
    from: from,
    to: to,
  ).getOrElse((failure) => throw StateError('aggregateForPeriod: $failure'));

  return DayVolume(
    day: from,
    liters: fromBase(
      balances.totalFor(LedgerAxisKind.volume).signedBase,
      VolumeUnit.liter,
    ),
  );
}
