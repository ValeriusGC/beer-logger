import 'dart:math' as math;

import 'package:beer_logger/bounded_contexts/journal/domain/click/period_balances.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:intl/intl.dart';

/// Отформатированное значение оси с семантикой знака для UI.
final class FormattedAxisValue {
  /// Создаёт пару «текст + отрицательность».
  const FormattedAxisValue({required this.text, required this.isNegative});

  /// Готовая подпись с единицей и знаком.
  final String text;

  /// `true`, если числовое значение строго меньше нуля.
  final bool isNegative;
}

/// Строки карточки: объём, энергия, деньги, радость — в порядке пресета.
typedef TodayBalanceLines = ({
  FormattedAxisValue volume,
  FormattedAxisValue energy,
  FormattedAxisValue money,
  FormattedAxisValue joy,
});

/// Переводит суммы [balances] из базовых единиц в подписи карточки.
///
/// [languageCode] — язык для [NumberFormat.decimalPattern], без страны.
/// Объём — литры и миллилитры одной строкой. Плюс только у энергии и радости
/// и только если значение больше нуля. Минус у денег ставит форматтер.
TodayBalanceLines formatTodayBalanceLines(
  PeriodBalances balances, {
  required String languageCode,
}) {
  return (
    volume: _volumeLine(
      balances.totalFor(LedgerAxisKind.volume).signedBase,
      languageCode,
    ),
    energy: _axisLine(
      balances.totalFor(LedgerAxisKind.energy).signedBase,
      EnergyUnit.kilocalorie,
      languageCode: languageCode,
      maximumFractionDigits: 0,
      showPlus: true,
    ),
    money: _axisLine(
      balances.totalFor(LedgerAxisKind.money).signedBase,
      MoneyUnit.rouble,
      languageCode: languageCode,
      maximumFractionDigits: 2,
    ),
    joy: _axisLine(
      balances.totalFor(LedgerAxisKind.joy).signedBase,
      CountUnit.point,
      languageCode: languageCode,
      maximumFractionDigits: 1,
      showPlus: true,
    ),
  );
}

/// Те же оси, что [formatTodayBalanceLines], для сжатого AppBar.
///
/// Четыре сегмента без `/` — разделитель рисует виджет. Объём — только литры.
List<FormattedAxisValue> formatTodayBalanceCompact(
  PeriodBalances balances, {
  required String languageCode,
}) {
  return [
    _compactAxis(
      fromBase(
        balances.totalFor(LedgerAxisKind.volume).signedBase,
        VolumeUnit.liter,
      ),
      VolumeUnit.liter,
      languageCode: languageCode,
      maximumFractionDigits: 3,
    ),
    _compactAxis(
      fromBase(
        balances.totalFor(LedgerAxisKind.energy).signedBase,
        EnergyUnit.kilocalorie,
      ),
      EnergyUnit.kilocalorie,
      languageCode: languageCode,
      maximumFractionDigits: 0,
      showPlus: true,
    ),
    _compactAxis(
      fromBase(
        balances.totalFor(LedgerAxisKind.money).signedBase,
        MoneyUnit.rouble,
      ),
      MoneyUnit.rouble,
      languageCode: languageCode,
      maximumFractionDigits: 2,
    ),
    _compactAxis(
      fromBase(
        balances.totalFor(LedgerAxisKind.joy).signedBase,
        CountUnit.point,
      ),
      CountUnit.point,
      languageCode: languageCode,
      maximumFractionDigits: 1,
      showPlus: true,
    ),
  ];
}

/// Итог оси за неделю в display unit — для заголовка недельного графика.
FormattedAxisValue formatWeekChartAxisTotal(
  double sum,
  LedgerAxisKind kind, {
  required String languageCode,
}) {
  return switch (kind) {
    LedgerAxisKind.volume => _axisLine(
      sum,
      VolumeUnit.liter,
      languageCode: languageCode,
      maximumFractionDigits: 3,
      valueInDisplayUnit: true,
    ),
    LedgerAxisKind.energy => _axisLine(
      sum,
      EnergyUnit.kilocalorie,
      languageCode: languageCode,
      maximumFractionDigits: 0,
      showPlus: true,
      valueInDisplayUnit: true,
    ),
    LedgerAxisKind.money => _axisLine(
      sum,
      MoneyUnit.rouble,
      languageCode: languageCode,
      maximumFractionDigits: 2,
      valueInDisplayUnit: true,
    ),
    LedgerAxisKind.joy => _axisLine(
      sum,
      CountUnit.point,
      languageCode: languageCode,
      maximumFractionDigits: 1,
      showPlus: true,
      valueInDisplayUnit: true,
    ),
  };
}

FormattedAxisValue _volumeLine(double milliliters, String languageCode) {
  final liters = fromBase(milliliters, VolumeUnit.liter);
  final millilitersDisplay = fromBase(milliliters, VolumeUnit.milliliter);
  final isNegative = milliliters < 0;
  final litersText = _amount(
    liters,
    languageCode: languageCode,
    maximumFractionDigits: 3,
  );
  final millilitersText = _amount(
    millilitersDisplay,
    languageCode: languageCode,
    maximumFractionDigits: 0,
  );
  return FormattedAxisValue(
    isNegative: isNegative,
    text:
        '$litersText ${VolumeUnit.liter.symbol} '
        '($millilitersText ${VolumeUnit.milliliter.symbol})',
  );
}

FormattedAxisValue _axisLine(
  double value,
  MeasureUnit unit, {
  required String languageCode,
  required int maximumFractionDigits,
  bool showPlus = false,
  bool valueInDisplayUnit = false,
}) {
  final displayValue = valueInDisplayUnit ? value : fromBase(value, unit);
  final amount = _amount(
    displayValue,
    languageCode: languageCode,
    maximumFractionDigits: maximumFractionDigits,
    showPlus: showPlus,
  );
  return FormattedAxisValue(
    isNegative: displayValue < 0,
    text: '$amount ${unit.symbol}',
  );
}

FormattedAxisValue _compactAxis(
  double displayValue,
  MeasureUnit unit, {
  required String languageCode,
  required int maximumFractionDigits,
  bool showPlus = false,
}) {
  final amount = _amount(
    displayValue,
    languageCode: languageCode,
    maximumFractionDigits: maximumFractionDigits,
    showPlus: showPlus,
  );
  return FormattedAxisValue(
    isNegative: displayValue < 0,
    text: '$amount${unit.symbol}',
  );
}

/// [NumberFormat.decimalPattern] на `en` группирует тысячи (`1,500`).
/// Карточке нужна цифра без разделителя: 1500 мл остаются `1500`.
String _amount(
  double value, {
  required String languageCode,
  required int maximumFractionDigits,
  bool showPlus = false,
}) {
  final scale = math.pow(10, maximumFractionDigits).toDouble();
  final rounded = (value * scale).roundToDouble() / scale;
  // Отрицательный ноль тоже равен 0, но форматтер напечатал бы «-0».
  final normalized = rounded == 0 ? 0.0 : rounded;
  final format = NumberFormat.decimalPattern(languageCode)
    ..minimumFractionDigits = 0
    ..maximumFractionDigits = maximumFractionDigits
    ..turnOffGrouping();
  final text = format.format(normalized);
  if (showPlus && normalized > 0) {
    return '+$text';
  }
  return text;
}
