import 'measure_unit.dart';
import 'count_unit.dart';
import 'energy_unit.dart';
import 'length_unit.dart';
import 'mass_unit.dart';
import 'money_unit.dart';
import 'volume_unit.dart';

/// Находит единицу измерения по wire-id во всех enum-семействах пакета.
///
/// Используется при десериализации и при записи факта журнала: id хранится
/// строкой, а не ссылкой на enum-значение.
MeasureUnit? resolveUnit(String id) =>
    VolumeUnit.tryFromId(id) ??
    MassUnit.tryFromId(id) ??
    MoneyUnit.tryFromId(id) ??
    LengthUnit.tryFromId(id) ??
    EnergyUnit.tryFromId(id) ??
    CountUnit.tryFromId(id);
