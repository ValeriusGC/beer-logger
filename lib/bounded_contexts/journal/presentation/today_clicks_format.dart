import 'package:beer_logger/bounded_contexts/journal/domain/click/axis_contribution.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Время строки журнала: часы, минуты и секунды по [Click.at] (уже local).
///
/// Секунды нужны, потому что тапы часто попадают в одну минуту.
String formatTodayClickTime(Click click, Locale locale) {
  return DateFormat.Hms(locale.toString()).format(click.at);
}

/// Объём порции для подписи кнопки тапа, в локали пользователя.
String formatRecordBeerVolume(Clicker clicker, {required String languageCode}) {
  double? liters;
  for (final axis in clicker.axes) {
    if (axis.kind == LedgerAxisKind.volume) {
      liters = axis.enteredValue;
      break;
    }
  }
  return _litersAmount(languageCode).format(liters ?? 0);
}

/// Объём тапа в литрах или `null`, если volume-вклада нет.
///
/// База → литры только через [fromBase]. Не падать и не рисовать другие оси.
String? formatTodayClickVolume(Click click, {required String languageCode}) {
  AxisContribution? volume;
  for (final contribution in click.contributions) {
    if (contribution.kind == LedgerAxisKind.volume) {
      volume = contribution;
      break;
    }
  }
  if (volume == null) return null;

  final liters = fromBase(volume.delta.signedBase, VolumeUnit.liter);
  return '${_litersAmount(languageCode).format(liters)} ${VolumeUnit.liter.symbol}';
}

NumberFormat _litersAmount(String languageCode) {
  return NumberFormat.decimalPattern(languageCode)
    ..minimumFractionDigits = 0
    ..maximumFractionDigits = 3;
}
