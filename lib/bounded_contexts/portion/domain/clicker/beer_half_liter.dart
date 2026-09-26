import 'package:beer_ledger_core/ledger_axis_kind.dart';
import 'package:beer_ledger_core/measure/count_unit.dart';
import 'package:beer_ledger_core/measure/energy_unit.dart';
import 'package:beer_ledger_core/measure/money_unit.dart';
import 'package:beer_ledger_core/measure/volume_unit.dart';

import 'axis_sign.dart';
import 'clicker.dart';
import 'clicker_id.dart';
import 'ledger_axis.dart';

/// Preset v1 «Пиво 0.5 L» — четыре оси по spec v1.
///
/// Один тап: +0.5 L, +100 kcal, −150 ₽, +2 joy (в единицах ввода осей).
/// Агрегация и отображение — через [Click.record] и [aggregateForPeriod].
Clicker beerHalfLiter({ClickerId id = const ClickerId.known('clicker-beer')}) =>
    Clicker(
      id: id,
      title: 'Пиво 0.5 L',
      axes: [
        LedgerAxis(
          kind: LedgerAxisKind.volume,
          enteredValue: 0.5,
          enteredInId: VolumeUnit.liter.id,
          sign: AxisSign.plus,
        ),
        LedgerAxis(
          kind: LedgerAxisKind.energy,
          enteredValue: 100,
          enteredInId: EnergyUnit.kilocalorie.id,
          sign: AxisSign.plus,
        ),
        LedgerAxis(
          kind: LedgerAxisKind.money,
          enteredValue: 150,
          enteredInId: MoneyUnit.rouble.id,
          sign: AxisSign.minus,
        ),
        LedgerAxis(
          kind: LedgerAxisKind.joy,
          enteredValue: 2,
          enteredInId: CountUnit.point.id,
          sign: AxisSign.plus,
        ),
      ],
    );
