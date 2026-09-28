import 'dart:math' as math;

import 'package:beer_logger/bounded_contexts/journal/domain/click/period_balances.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:intl/intl.dart';

/// Строки карточки: объём, энергия, деньги, радость — в порядке пресета.
typedef TodayBalanceLines = ({
  String volume,
  String energy,
  String money,
  String joy,
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

/// Те же оси, что [formatTodayBalanceLines], одной слеш-строкой для сжатого AppBar.
///
/// Объём — только литры, без миллилитров в скобках. Знаки как на карточке.
/// Пробела перед символом единицы нет: строка должна умещаться в тулбар.
String formatTodayBalanceCompact(
  PeriodBalances balances, {
  required String languageCode,
}) {
  final volume = _compactAmount(
    fromBase(
      balances.totalFor(LedgerAxisKind.volume).signedBase,
      VolumeUnit.liter,
    ),
    VolumeUnit.liter,
    languageCode: languageCode,
    maximumFractionDigits: 3,
  );
  final energy = _compactAmount(
    fromBase(
      balances.totalFor(LedgerAxisKind.energy).signedBase,
      EnergyUnit.kilocalorie,
    ),
    EnergyUnit.kilocalorie,
    languageCode: languageCode,
    maximumFractionDigits: 0,
    showPlus: true,
  );
  final money = _compactAmount(
    fromBase(
      balances.totalFor(LedgerAxisKind.money).signedBase,
      MoneyUnit.rouble,
    ),
    MoneyUnit.rouble,
    languageCode: languageCode,
    maximumFractionDigits: 2,
  );
  final joy = _compactAmount(
    fromBase(balances.totalFor(LedgerAxisKind.joy).signedBase, CountUnit.point),
    CountUnit.point,
    languageCode: languageCode,
    maximumFractionDigits: 1,
    showPlus: true,
  );
  return '$volume/$energy/$money/$joy';
}

String _volumeLine(double milliliters, String languageCode) {
  final liters = _amount(
    fromBase(milliliters, VolumeUnit.liter),
    languageCode: languageCode,
    maximumFractionDigits: 3,
  );
  final millilitersText = _amount(
    fromBase(milliliters, VolumeUnit.milliliter),
    languageCode: languageCode,
    maximumFractionDigits: 0,
  );
  return '$liters ${VolumeUnit.liter.symbol} '
      '($millilitersText ${VolumeUnit.milliliter.symbol})';
}

String _axisLine(
  double baseValue,
  MeasureUnit unit, {
  required String languageCode,
  required int maximumFractionDigits,
  bool showPlus = false,
}) {
  final amount = _amount(
    fromBase(baseValue, unit),
    languageCode: languageCode,
    maximumFractionDigits: maximumFractionDigits,
    showPlus: showPlus,
  );
  return '$amount ${unit.symbol}';
}

String _compactAmount(
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
  return '$amount${unit.symbol}';
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
