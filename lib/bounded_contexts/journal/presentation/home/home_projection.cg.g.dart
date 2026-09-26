// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_projection.cg.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Проекция главной из уже существующих application-провайдеров.

@ProviderFor(homeProjection)
final homeProjectionProvider = HomeProjectionProvider._();

/// Проекция главной из уже существующих application-провайдеров.

final class HomeProjectionProvider
    extends $FunctionalProvider<HomeProjection, HomeProjection, HomeProjection>
    with $Provider<HomeProjection> {
  /// Проекция главной из уже существующих application-провайдеров.
  HomeProjectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeProjectionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeProjectionHash();

  @$internal
  @override
  $ProviderElement<HomeProjection> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeProjection create(Ref ref) {
    return homeProjection(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeProjection value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeProjection>(value),
    );
  }
}

String _$homeProjectionHash() => r'f634fe4420c998a325d829da5631e9afefb8616c';
