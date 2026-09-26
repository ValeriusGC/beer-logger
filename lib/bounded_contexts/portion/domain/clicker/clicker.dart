import 'package:beer_ledger_core/arch/aggregate_root.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'clicker_id.dart';
import 'ledger_axis.dart';

part 'clicker.freezed.dart';

/// Кнопка-пакет: название и набор осей учёта.
///
/// Один тап по кнопке порождает [Click] через [Click.record]. История тапов
/// **не** хранится здесь — отдельный [List<Click>] передаётся в агрегацию
/// и в репозиторий.
@Freezed(makeCollectionsUnmodifiable: false)
abstract class Clicker with _$Clicker implements AggregateRoot {
  const factory Clicker({
    required ClickerId id,
    required String title,
    required List<LedgerAxis> axes,
  }) = _Clicker;
}
