// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clicker_settings_repository.cg.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Настройки порции над [appDatabase].
///
/// Экран и запись тапа не ходят в drift сами.
///
/// [Ref.watch], не [Ref.read]: репозиторий привязан к той БД, которую
/// сейчас отдаёт [appDatabase].

@ProviderFor(clickerSettingsRepository)
final clickerSettingsRepositoryProvider = ClickerSettingsRepositoryProvider._();

/// Настройки порции над [appDatabase].
///
/// Экран и запись тапа не ходят в drift сами.
///
/// [Ref.watch], не [Ref.read]: репозиторий привязан к той БД, которую
/// сейчас отдаёт [appDatabase].

final class ClickerSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          ClickerSettingsRepository,
          ClickerSettingsRepository,
          ClickerSettingsRepository
        >
    with $Provider<ClickerSettingsRepository> {
  /// Настройки порции над [appDatabase].
  ///
  /// Экран и запись тапа не ходят в drift сами.
  ///
  /// [Ref.watch], не [Ref.read]: репозиторий привязан к той БД, которую
  /// сейчас отдаёт [appDatabase].
  ClickerSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clickerSettingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clickerSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ClickerSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ClickerSettingsRepository create(Ref ref) {
    return clickerSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClickerSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClickerSettingsRepository>(value),
    );
  }
}

String _$clickerSettingsRepositoryHash() =>
    r'b753e1454abd880f2754d0b26465097db0e0e96e';
