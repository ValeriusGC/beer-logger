import 'package:beer_ledger_core/arch/entity.dart';
import 'package:beer_ledger_core/ledger_axis_kind.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'axis_sign.dart';

part 'ledger_axis.freezed.dart';

/// Конфигурация одной оси учёта на [Clicker].
///
/// Описывает, **сколько** и **в каких единицах** пользователь задаёт вклад за
/// один тап, и **в какую сторону** ось двигает баланс. Сами значения за прошлые
/// тапы здесь не хранятся — они замораживаются в [AxisContribution] внутри
/// [Click] при вызове [Click.record].
@freezed
abstract class LedgerAxis with _$LedgerAxis implements Entity {
  const factory LedgerAxis({
    required LedgerAxisKind kind,
    required double enteredValue,
    required String enteredInId,
    required AxisSign sign,
  }) = _LedgerAxis;
}
