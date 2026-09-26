import 'package:beer_logger/bounded_contexts/journal/domain/click/axis_record_input.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker.dart';

/// Переводит оси живой порции на вход [Click.record].
///
/// Домен журнала [Clicker] не видит: антикоррупционный слой между bounded context'ами.
List<AxisRecordInput> axisRecordInputsFrom(Clicker clicker) {
  return [
    for (final axis in clicker.axes)
      AxisRecordInput(
        kind: axis.kind,
        enteredValue: axis.enteredValue,
        enteredInId: axis.enteredInId,
        signMultiplier: axis.sign.multiplier,
      ),
  ];
}
