import 'package:beer_logger/bounded_contexts/journal/application/record_click.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/application/undo_last_click.cg.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.cg.g.dart';

/// Обработчики записи и undo для главной.
@riverpod
class HomeController extends _$HomeController {
  @override
  void build() {}

  /// Записывает тап текущей порции.
  Future<void> record() => ref.read(recordClickProvider.notifier).record();

  /// Отменяет последний тап.
  Future<void> undo() => ref.read(undoLastClickProvider.notifier).undo();
}
