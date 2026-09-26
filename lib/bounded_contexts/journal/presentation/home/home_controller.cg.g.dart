// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.cg.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Обработчики записи и undo для главной.

@ProviderFor(HomeController)
final homeControllerProvider = HomeControllerProvider._();

/// Обработчики записи и undo для главной.
final class HomeControllerProvider
    extends $NotifierProvider<HomeController, void> {
  /// Обработчики записи и undo для главной.
  HomeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeControllerHash();

  @$internal
  @override
  HomeController create() => HomeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$homeControllerHash() => r'a0040d9f84123ece42a66b5babc18a153ad207dc';

/// Обработчики записи и undo для главной.

abstract class _$HomeController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
