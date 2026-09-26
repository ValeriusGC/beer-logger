// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_balance.cg.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Четыре цифры за сегодня: объём, ккал, деньги, радость.
///
/// Сумма — [aggregateForPeriod], не отдельная формула. Тапы — [clicksForToday],
/// оси — [beerHalfLiter]. Экран только рисует.

@ProviderFor(todayBalance)
final todayBalanceProvider = TodayBalanceProvider._();

/// Четыре цифры за сегодня: объём, ккал, деньги, радость.
///
/// Сумма — [aggregateForPeriod], не отдельная формула. Тапы — [clicksForToday],
/// оси — [beerHalfLiter]. Экран только рисует.

final class TodayBalanceProvider
    extends
        $FunctionalProvider<
          AsyncValue<PeriodBalances>,
          PeriodBalances,
          FutureOr<PeriodBalances>
        >
    with $FutureModifier<PeriodBalances>, $FutureProvider<PeriodBalances> {
  /// Четыре цифры за сегодня: объём, ккал, деньги, радость.
  ///
  /// Сумма — [aggregateForPeriod], не отдельная формула. Тапы — [clicksForToday],
  /// оси — [beerHalfLiter]. Экран только рисует.
  TodayBalanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'todayBalanceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$todayBalanceHash();

  @$internal
  @override
  $FutureProviderElement<PeriodBalances> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PeriodBalances> create(Ref ref) {
    return todayBalance(ref);
  }
}

String _$todayBalanceHash() => r'0c9d1814b7b0f689526fbea8408fbb3ab40e7730';
