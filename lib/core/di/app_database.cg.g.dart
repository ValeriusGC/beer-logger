// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.cg.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Файловая SQLite-база приложения.
///
/// Одна на процесс: `keepAlive` не даёт закрыть её, когда никто не слушает.
/// При уничтожении контейнера закрывается в [Ref.onDispose].

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

/// Файловая SQLite-база приложения.
///
/// Одна на процесс: `keepAlive` не даёт закрыть её, когда никто не слушает.
/// При уничтожении контейнера закрывается в [Ref.onDispose].

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  /// Файловая SQLite-база приложения.
  ///
  /// Одна на процесс: `keepAlive` не даёт закрыть её, когда никто не слушает.
  /// При уничтожении контейнера закрывается в [Ref.onDispose].
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'44154e51c3f3079ee293d8ad0ebd1e17cca871ed';
