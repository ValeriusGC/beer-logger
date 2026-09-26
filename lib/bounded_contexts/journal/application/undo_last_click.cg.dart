import 'dart:async';

import 'package:beer_logger/core/di/click_repository.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click_repository.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'undo_last_click.cg.g.dart';

/// Отмена глобально последнего тапа через [ClickRepository.undoLastClick].
///
/// Виджет репозиторий не вызывает. Семантика: последний по
/// `(at DESC, id DESC)`, даже если он не из сегодняшнего списка. Пустой
/// журнал — тихий успех, не ошибка.
@riverpod
class UndoLastClick extends _$UndoLastClick {
  /// Полезных данных нет: кнопка смотрит только на загрузку и ошибку.
  @override
  FutureOr<void> build() {}

  /// Снимает глобально последний тап.
  ///
  /// Пока предыдущий вызов ещё [AsyncValue.isLoading], сразу выходит.
  /// Ошибка хранилища становится [AsyncError] с [Failure].
  Future<void> undo() async {
    if (state.isLoading) return;

    state = const AsyncLoading();
    final result = await ref.read(clickRepositoryProvider).undoLastClick();
    result.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (_) => state = const AsyncData(null),
    );
  }
}
