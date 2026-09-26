import 'package:beer_logger/bounded_contexts/portion/domain/clicker/beer_half_liter.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker_id.dart';
import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';

/// Собирает [Clicker] из строки настроек.
///
/// В строке только четыре [LedgerAxis.enteredValue]. Название, [LedgerAxis.enteredInId]
/// и [LedgerAxis.sign] остаются у [beerHalfLiter]: смена порции не меняет знак денег.
Clicker clickerFromSettingsRow(ClickerSettingsRow row) {
  final preset = beerHalfLiter();
  return preset.copyWith(
    id: ClickerId.known(row.clickerId),
    axes: [
      for (final axis in preset.axes)
        axis.copyWith(enteredValue: _entered(row, axis.kind)),
    ],
  );
}

double _entered(ClickerSettingsRow row, LedgerAxisKind kind) {
  return switch (kind) {
    LedgerAxisKind.volume => row.volumeEntered,
    LedgerAxisKind.energy => row.energyEntered,
    LedgerAxisKind.money => row.moneyEntered,
    LedgerAxisKind.joy => row.joyEntered,
  };
}
