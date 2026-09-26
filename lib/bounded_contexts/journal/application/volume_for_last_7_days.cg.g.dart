// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_for_last_7_days.cg.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Объём за семь локальных дней, заканчивая [now].
///
/// Значения — литры. Одна подписка [ClickRepository.watchClicksInRange]
/// на всё окно; по дню сумму считает [aggregateForPeriod], не виджет.
/// Всегда семь точек: пустой день — 0. Индекс 0 — самый старый день,
/// индекс 6 — сегодня. [Failure.invalidPeriod] сюда не приходит: каждый день
/// это `[start, start+1)`. Если придёт — провайдер в error, экран покажет l10n.

@ProviderFor(volumeForLast7Days)
final volumeForLast7DaysProvider = VolumeForLast7DaysProvider._();

/// Объём за семь локальных дней, заканчивая [now].
///
/// Значения — литры. Одна подписка [ClickRepository.watchClicksInRange]
/// на всё окно; по дню сумму считает [aggregateForPeriod], не виджет.
/// Всегда семь точек: пустой день — 0. Индекс 0 — самый старый день,
/// индекс 6 — сегодня. [Failure.invalidPeriod] сюда не приходит: каждый день
/// это `[start, start+1)`. Если придёт — провайдер в error, экран покажет l10n.

final class VolumeForLast7DaysProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DayVolume>>,
          List<DayVolume>,
          Stream<List<DayVolume>>
        >
    with $FutureModifier<List<DayVolume>>, $StreamProvider<List<DayVolume>> {
  /// Объём за семь локальных дней, заканчивая [now].
  ///
  /// Значения — литры. Одна подписка [ClickRepository.watchClicksInRange]
  /// на всё окно; по дню сумму считает [aggregateForPeriod], не виджет.
  /// Всегда семь точек: пустой день — 0. Индекс 0 — самый старый день,
  /// индекс 6 — сегодня. [Failure.invalidPeriod] сюда не приходит: каждый день
  /// это `[start, start+1)`. Если придёт — провайдер в error, экран покажет l10n.
  VolumeForLast7DaysProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'volumeForLast7DaysProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$volumeForLast7DaysHash();

  @$internal
  @override
  $StreamProviderElement<List<DayVolume>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<DayVolume>> create(Ref ref) {
    return volumeForLast7Days(ref);
  }
}

String _$volumeForLast7DaysHash() =>
    r'e75bb445d1cfe632854899c3e18fcc9f9b74f0bb';
