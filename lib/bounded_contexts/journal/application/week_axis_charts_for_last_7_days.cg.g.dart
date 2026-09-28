// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_axis_charts_for_last_7_days.cg.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Семь локальных дней по четырём осям пресета, заканчивая [now].
///
/// Одна подписка [ClickRepository.watchClicksInRange] на всё окно;
/// по дню сумму считает [aggregateForPeriod], не виджет. Пустой день — 0.
/// [Failure.invalidPeriod] сюда не приходит: каждый день это `[start, start+1)`.

@ProviderFor(weekAxisChartsForLast7Days)
final weekAxisChartsForLast7DaysProvider =
    WeekAxisChartsForLast7DaysProvider._();

/// Семь локальных дней по четырём осям пресета, заканчивая [now].
///
/// Одна подписка [ClickRepository.watchClicksInRange] на всё окно;
/// по дню сумму считает [aggregateForPeriod], не виджет. Пустой день — 0.
/// [Failure.invalidPeriod] сюда не приходит: каждый день это `[start, start+1)`.

final class WeekAxisChartsForLast7DaysProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WeekAxisChartSeries>>,
          List<WeekAxisChartSeries>,
          Stream<List<WeekAxisChartSeries>>
        >
    with
        $FutureModifier<List<WeekAxisChartSeries>>,
        $StreamProvider<List<WeekAxisChartSeries>> {
  /// Семь локальных дней по четырём осям пресета, заканчивая [now].
  ///
  /// Одна подписка [ClickRepository.watchClicksInRange] на всё окно;
  /// по дню сумму считает [aggregateForPeriod], не виджет. Пустой день — 0.
  /// [Failure.invalidPeriod] сюда не приходит: каждый день это `[start, start+1)`.
  WeekAxisChartsForLast7DaysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weekAxisChartsForLast7DaysProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weekAxisChartsForLast7DaysHash();

  @$internal
  @override
  $StreamProviderElement<List<WeekAxisChartSeries>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<WeekAxisChartSeries>> create(Ref ref) {
    return weekAxisChartsForLast7Days(ref);
  }
}

String _$weekAxisChartsForLast7DaysHash() =>
    r'c5ac708b9dfc5f5c60ef07408aaa97292bfc684c';
