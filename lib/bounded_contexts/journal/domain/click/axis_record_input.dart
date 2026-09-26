import 'package:beer_ledger_core/arch/value_object.dart';
import 'package:beer_ledger_core/ledger_axis_kind.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'axis_record_input.freezed.dart';

/// Вход одной оси для [Click.record]: язык журнала до резолва единицы и вклада.
///
/// Сценарий записи собирает список из живой порции в application; домен журнала
/// [Clicker] не импортирует.
@freezed
abstract class AxisRecordInput with _$AxisRecordInput implements ValueObject {
  /// [kind] — ось баланса; [enteredValue] и [enteredInId] — как ввёл пользователь;
  /// [signMultiplier] — `1` или `-1` (в порции это `AxisSign.multiplier`, тип
  /// знака журнал не импортирует).
  const factory AxisRecordInput({
    required LedgerAxisKind kind,
    required double enteredValue,
    required String enteredInId,
    required int signMultiplier,
  }) = _AxisRecordInput;
}
