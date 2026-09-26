import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';

/// Поле порции на экране настроек.
enum PortionField {
  /// Объём, литры.
  volume,

  /// Ккал.
  energy,

  /// Цена, рубли, величина без знака.
  money,

  /// Радость, пункты пресета.
  joy,
}

/// Текст поля из сохранённого числа: `100`, не `100.0`.
String formatPortionInput(double value) {
  if (value == value.truncateToDouble()) return value.toInt().toString();
  return value.toString();
}

/// Число из поля. Пусто, мусор, NaN и Infinity — `null`.
///
/// Запятая читается как десятичный разделитель.
double? tryParsePortion(String text) {
  final value = double.tryParse(text.trim().replaceAll(',', '.'));
  if (value == null || value.isNaN || value.isInfinite) return null;
  return value;
}

/// Границы включительно: объём 0.1…3, ккал 50…250, цена 0…10000, радость 0…10.
///
/// Радость 0…10 — забор от мусора на вводе, не решение шкалы 1–5 из spec.
bool portionInputIsValid(PortionField field, String text) {
  final value = tryParsePortion(text);
  if (value == null) return false;
  return switch (field) {
    PortionField.volume => value >= 0.1 && value <= 3,
    PortionField.energy => value >= 50 && value <= 250,
    PortionField.money => value >= 0 && value <= 10000,
    PortionField.joy => value >= 0 && value <= 10,
  };
}

/// [Clicker] с новыми введёнными числами.
///
/// [LedgerAxis.enteredInId] и [LedgerAxis.sign] не меняются: цена остаётся минусом.
Clicker clickerWithPortion(
  Clicker clicker, {
  required double volume,
  required double energy,
  required double money,
  required double joy,
}) {
  return clicker.copyWith(
    axes: [
      for (final axis in clicker.axes)
        axis.copyWith(
          enteredValue: switch (axis.kind) {
            LedgerAxisKind.volume => volume,
            LedgerAxisKind.energy => energy,
            LedgerAxisKind.money => money,
            LedgerAxisKind.joy => joy,
          },
        ),
    ],
  );
}

/// Введённое число оси, которая соответствует [field].
double portionEntered(Clicker clicker, PortionField field) {
  final kind = switch (field) {
    PortionField.volume => LedgerAxisKind.volume,
    PortionField.energy => LedgerAxisKind.energy,
    PortionField.money => LedgerAxisKind.money,
    PortionField.joy => LedgerAxisKind.joy,
  };
  return clicker.axes.firstWhere((axis) => axis.kind == kind).enteredValue;
}
