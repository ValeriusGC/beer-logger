// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_clicker.cg.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Текущая порция единственного clicker v1.
///
/// Экран настроек и запись тапа смотрят сюда. В рантайме записи не подставлять
/// [beerHalfLiter] вместо этого потока: пресет даёт только название, единицы и знаки.

@ProviderFor(currentClicker)
final currentClickerProvider = CurrentClickerProvider._();

/// Текущая порция единственного clicker v1.
///
/// Экран настроек и запись тапа смотрят сюда. В рантайме записи не подставлять
/// [beerHalfLiter] вместо этого потока: пресет даёт только название, единицы и знаки.

final class CurrentClickerProvider
    extends $FunctionalProvider<AsyncValue<Clicker>, Clicker, Stream<Clicker>>
    with $FutureModifier<Clicker>, $StreamProvider<Clicker> {
  /// Текущая порция единственного clicker v1.
  ///
  /// Экран настроек и запись тапа смотрят сюда. В рантайме записи не подставлять
  /// [beerHalfLiter] вместо этого потока: пресет даёт только название, единицы и знаки.
  CurrentClickerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentClickerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentClickerHash();

  @$internal
  @override
  $StreamProviderElement<Clicker> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Clicker> create(Ref ref) {
    return currentClicker(ref);
  }
}

String _$currentClickerHash() => r'569a9386ae7ec7408e63e6e2121280cc23305a95';
