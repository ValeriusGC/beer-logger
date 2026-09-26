// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now.cg.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Текущий момент.
///
/// Значение кэшируется, пока его кто-то смотрит. Для границ дня этого хватает.
/// Момент тапа так брать нельзя: все нажатия получат один instant, и внутри
/// минуты порядок станет порядком UUID. Запись делает [Ref.refresh].

@ProviderFor(now)
final nowProvider = NowProvider._();

/// Текущий момент.
///
/// Значение кэшируется, пока его кто-то смотрит. Для границ дня этого хватает.
/// Момент тапа так брать нельзя: все нажатия получат один instant, и внутри
/// минуты порядок станет порядком UUID. Запись делает [Ref.refresh].

final class NowProvider
    extends $FunctionalProvider<DateTime, DateTime, DateTime>
    with $Provider<DateTime> {
  /// Текущий момент.
  ///
  /// Значение кэшируется, пока его кто-то смотрит. Для границ дня этого хватает.
  /// Момент тапа так брать нельзя: все нажатия получат один instant, и внутри
  /// минуты порядок станет порядком UUID. Запись делает [Ref.refresh].
  NowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nowHash();

  @$internal
  @override
  $ProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DateTime create(Ref ref) {
    return now(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$nowHash() => r'cd84bcb298b7b9e78457b899f2d2445afe8d297f';
