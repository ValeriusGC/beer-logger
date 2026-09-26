// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'click_repository.cg.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Журнал тапов для всего приложения.
///
/// Всегда [DriftClickRepository] над [appDatabase]. Экран и фичи не ходят
/// в drift сами — только сюда.
///
/// [Ref.watch], не [Ref.read]: репозиторий привязан к той БД, которую
/// сейчас отдаёт [appDatabase].

@ProviderFor(clickRepository)
final clickRepositoryProvider = ClickRepositoryProvider._();

/// Журнал тапов для всего приложения.
///
/// Всегда [DriftClickRepository] над [appDatabase]. Экран и фичи не ходят
/// в drift сами — только сюда.
///
/// [Ref.watch], не [Ref.read]: репозиторий привязан к той БД, которую
/// сейчас отдаёт [appDatabase].

final class ClickRepositoryProvider
    extends
        $FunctionalProvider<ClickRepository, ClickRepository, ClickRepository>
    with $Provider<ClickRepository> {
  /// Журнал тапов для всего приложения.
  ///
  /// Всегда [DriftClickRepository] над [appDatabase]. Экран и фичи не ходят
  /// в drift сами — только сюда.
  ///
  /// [Ref.watch], не [Ref.read]: репозиторий привязан к той БД, которую
  /// сейчас отдаёт [appDatabase].
  ClickRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clickRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clickRepositoryHash();

  @$internal
  @override
  $ProviderElement<ClickRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ClickRepository create(Ref ref) {
    return clickRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ClickRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ClickRepository>(value),
    );
  }
}

String _$clickRepositoryHash() => r'9ebd9be8656972083ccd7015013fec67c149c3e1';
