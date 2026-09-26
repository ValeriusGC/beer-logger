import 'dart:async';

import 'package:beer_logger/bounded_contexts/journal/application/axis_record_inputs.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click_id.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click_repository.dart';
import 'package:beer_logger/bounded_contexts/portion/application/current_clicker.cg.dart';
import 'package:beer_logger/core/di/click_repository.cg.dart';
import 'package:beer_logger/core/di/now.cg.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'record_click.cg.g.dart';

/// Запись одного тапа текущей порции в журнал.
///
/// Виджет [ClickRepository] не вызывает. Порцию берёт из [currentClicker],
/// не из зашитого пресета. Баланс за сегодня подхватывает тап сам, через
/// уже существующий поток. Момент тапа — свежий [now]: провайдер кэшируется,
/// пока его смотрит экран, поэтому запись его обновляет.
@riverpod
class RecordClick extends _$RecordClick {
  /// Полезных данных нет: кнопка смотрит только на загрузку и ошибку.
  @override
  FutureOr<void> build() {}

  /// Пишет один [Click] текущей порции через [ClickRepository.addClick].
  ///
  /// Пока предыдущий вызов ещё [AsyncValue.isLoading], сразу выходит.
  /// Пока [currentClicker] грузится, тоже выходит и ничего не пишет: кнопка
  /// на home в этом состоянии выключена, чтобы тап не пропадал молча.
  /// Ошибка потока настроек становится [AsyncError] с [Failure], не падением.
  /// [Click.record] Left и ошибка хранилища — тот же [AsyncError].
  Future<void> record() async {
    if (state.isLoading) return;

    final clickerState = ref.read(currentClickerProvider);
    if (clickerState.isLoading) return;
    if (clickerState.hasError) {
      final error = clickerState.error;
      state = AsyncError(
        error is Failure
            ? error
            : Failure.storage(operation: 'watchClicker', cause: error),
        clickerState.stackTrace ?? StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();

    final clicker = clickerState.requireValue;
    final recorded = Click.record(
      id: ClickId.known(const Uuid().v4()),
      clickerId: clicker.id,
      at: ref.refresh(nowProvider),
      axes: axisRecordInputsFrom(clicker),
    );

    final click = recorded.fold<Click?>((failure) {
      state = AsyncError(failure, StackTrace.current);
      return null;
    }, (click) => click);
    if (click == null) return;

    final saved = await ref.read(clickRepositoryProvider).addClick(click);
    saved.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (_) => state = const AsyncData(null),
    );
  }
}
