import 'package:beer_ledger_core/arch/value_object.dart';
import 'package:beer_ledger_core/ledger_axis_kind.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'signed_base_delta.dart';

part 'axis_contribution.freezed.dart';

/// Замороженный вклад одной оси в момент тапа.
///
/// [delta] уже включает знак оси и [Click.factor] — готов к суммированию в
/// [aggregateForPeriod]. [enteredInId] нужен только для отображения
/// («0.5 L»); пересчёт факта из него **запрещён**.
@freezed
abstract class AxisContribution with _$AxisContribution implements ValueObject {
  const factory AxisContribution({
    required SignedBaseDelta delta,
    required String enteredInId,
  }) = _AxisContribution;

  const AxisContribution._();

  /// Ось вклада — делегат к [delta.kind] для сортировки и поиска по оси.
  LedgerAxisKind get kind => delta.kind;
}
