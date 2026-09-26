import 'package:fpdart/fpdart.dart';

import '../failure/failure.dart';
import '../measure/measure_unit.dart';
import '../result/result.dart';

/// Переводит [value] из [from] в [to] внутри одного семейства единиц.
///
/// Формула совпадает с контрактом [MeasureUnit.ratioToBase]:
/// `value * from.ratioToBase / to.ratioToBase`.
///
/// Если [from.family] != [to.family], возвращает
/// [Failure.incompatibleUnits] — перевод литров в килограммы или порций в
/// килокалории недопустим на уровне домена.
///
/// Знак [value] не валидируется: направление оси (+/−) задаёт домен порции,
/// а не здесь.
///
/// Пример:
///
/// ```dart
/// final result = convert(
///   value: 0.5,
///   from: VolumeUnit.liter,
///   to: VolumeUnit.milliliter,
/// );
/// // Right(500.0)
/// ```
Result<double> convert({
  required double value,
  required MeasureUnit from,
  required MeasureUnit to,
}) {
  if (from.family != to.family) {
    return Left(Failure.incompatibleUnits(fromId: from.id, toId: to.id));
  }

  return Right(value * from.ratioToBase / to.ratioToBase);
}

/// Приводит [value], заданное в [unit], к базовой единице семейства.
///
/// Объём в миллилитрах, деньги в копейках, энергия в калориях — см. [MeasureUnit].
/// Используется при записи факта журнала: факт хранится в базовой единице
/// семейства, а не в единице ввода.
double toBase(double value, MeasureUnit unit) => value * unit.ratioToBase;

/// Выражает [baseValue] (в базовой единице семейства) через [unit].
///
/// Обратная операция к [toBase]; удобна для отображения сохранённого факта
/// в единице, которой пользователь вводил значение.
double fromBase(double baseValue, MeasureUnit unit) =>
    baseValue / unit.ratioToBase;

/// Сколько изменилась ось за один тап — в **базовой** единице семейства.
///
/// [enteredValue] — величина, которую пользователь задал для оси (напр. `0.5`
/// литра), [enteredIn] — единица ввода, [factor] — множитель тапа (по умолчанию
/// `1`). Результат совпадает с [toBase] от произведения `enteredValue * factor`.
///
/// Знак не применяется: направление оси (+/−) умножается снаружи в домене
/// порции.
///
/// Пример — «Пиво 0.5 L», factor = 1:
///
/// ```dart
/// deltaInBase(
///   enteredValue: 0.5,
///   enteredIn: VolumeUnit.liter,
/// ); // 500.0 мл
/// ```
double deltaInBase({
  required double enteredValue,
  required MeasureUnit enteredIn,
  double factor = 1,
}) => toBase(enteredValue * factor, enteredIn);
