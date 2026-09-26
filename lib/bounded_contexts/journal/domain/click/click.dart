import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker_id.dart';
import 'package:beer_ledger_core/arch/aggregate_root.dart';
import 'package:beer_ledger_core/convert/convert.dart';
import 'package:beer_ledger_core/failure/failure.dart';
import 'package:beer_ledger_core/measure/measure_registry.dart';
import 'package:beer_ledger_core/result/result.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'axis_contribution.dart';
import 'axis_record_input.dart';
import 'click_id.dart';
import 'signed_base_delta.dart';

part 'click.freezed.dart';

/// Одно нажатие кнопки-пакета: момент времени и замороженный вклад по осям.
///
/// [contributions] фиксируются в [record] и **не** пересчитываются при изменении
/// конфигурации порции.
@Freezed(makeCollectionsUnmodifiable: false)
abstract class Click with _$Click implements AggregateRoot {
  const factory Click({
    required ClickId id,
    required ClickerId clickerId,
    required DateTime at,
    @Default(1.0) double factor,
    required List<AxisContribution> contributions,
  }) = _Click;

  const Click._();

  /// Создаёт тап со снимком вкладов по осям журнала [axes].
  ///
  /// На каждой оси: резолв [AxisRecordInput.enteredInId] → [resolveUnit]; при
  /// неизвестном id — [Failure.unknownUnitId]. Иначе
  /// `delta = signMultiplier * deltaInBase(...)` в варианте оси.
  static Result<Click> record({
    required ClickId id,
    required ClickerId clickerId,
    required DateTime at,
    required List<AxisRecordInput> axes,
    double factor = 1,
  }) {
    final contributions = <AxisContribution>[];

    for (final axis in axes) {
      final unit = resolveUnit(axis.enteredInId);
      if (unit == null) {
        return Left(Failure.unknownUnitId(id: axis.enteredInId));
      }

      contributions.add(
        AxisContribution(
          delta: SignedBaseDelta.fromKind(
            axis.kind,
            axis.signMultiplier *
                deltaInBase(
                  enteredValue: axis.enteredValue,
                  enteredIn: unit,
                  factor: factor,
                ),
          ),
          enteredInId: axis.enteredInId,
        ),
      );
    }

    return Right(
      Click(
        id: id,
        clickerId: clickerId,
        at: at,
        factor: factor,
        contributions: contributions,
      ),
    );
  }
}
