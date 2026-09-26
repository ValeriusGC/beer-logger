// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'undo_last_click.cg.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Отмена глобально последнего тапа через [ClickRepository.undoLastClick].
///
/// Виджет репозиторий не вызывает. Семантика: последний по
/// `(at DESC, id DESC)`, даже если он не из сегодняшнего списка. Пустой
/// журнал — тихий успех, не ошибка.

@ProviderFor(UndoLastClick)
final undoLastClickProvider = UndoLastClickProvider._();

/// Отмена глобально последнего тапа через [ClickRepository.undoLastClick].
///
/// Виджет репозиторий не вызывает. Семантика: последний по
/// `(at DESC, id DESC)`, даже если он не из сегодняшнего списка. Пустой
/// журнал — тихий успех, не ошибка.
final class UndoLastClickProvider
    extends $AsyncNotifierProvider<UndoLastClick, void> {
  /// Отмена глобально последнего тапа через [ClickRepository.undoLastClick].
  ///
  /// Виджет репозиторий не вызывает. Семантика: последний по
  /// `(at DESC, id DESC)`, даже если он не из сегодняшнего списка. Пустой
  /// журнал — тихий успех, не ошибка.
  UndoLastClickProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'undoLastClickProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$undoLastClickHash();

  @$internal
  @override
  UndoLastClick create() => UndoLastClick();
}

String _$undoLastClickHash() => r'8c86de40d0573d7ca807e0aedb00f7fd0a808915';

/// Отмена глобально последнего тапа через [ClickRepository.undoLastClick].
///
/// Виджет репозиторий не вызывает. Семантика: последний по
/// `(at DESC, id DESC)`, даже если он не из сегодняшнего списка. Пустой
/// журнал — тихий успех, не ошибка.

abstract class _$UndoLastClick extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
