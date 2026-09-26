// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clicks_for_today.cg.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Живой список тапов за сегодняшний локальный день.
///
/// «Сегодня» — календарный день [now]. Экран только рисует этот поток,
/// в базу сам не ходит.

@ProviderFor(clicksForToday)
final clicksForTodayProvider = ClicksForTodayProvider._();

/// Живой список тапов за сегодняшний локальный день.
///
/// «Сегодня» — календарный день [now]. Экран только рисует этот поток,
/// в базу сам не ходит.

final class ClicksForTodayProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Click>>,
          List<Click>,
          Stream<List<Click>>
        >
    with $FutureModifier<List<Click>>, $StreamProvider<List<Click>> {
  /// Живой список тапов за сегодняшний локальный день.
  ///
  /// «Сегодня» — календарный день [now]. Экран только рисует этот поток,
  /// в базу сам не ходит.
  ClicksForTodayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clicksForTodayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clicksForTodayHash();

  @$internal
  @override
  $StreamProviderElement<List<Click>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Click>> create(Ref ref) {
    return clicksForToday(ref);
  }
}

String _$clicksForTodayHash() => r'b1539e19641e5cf5ebccf84681adb7cc6eacc41a';
