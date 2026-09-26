import 'package:beer_ledger_core/beer_ledger_core.dart';

/// Wire-id оси в SQLite (`click_contributions.kind`).
String ledgerAxisKindToWire(LedgerAxisKind kind) => switch (kind) {
  LedgerAxisKind.volume => 'volume',
  LedgerAxisKind.energy => 'energy',
  LedgerAxisKind.money => 'money',
  LedgerAxisKind.joy => 'joy',
};

/// Парсит wire-id оси из SQLite в domain [LedgerAxisKind].
LedgerAxisKind ledgerAxisKindFromWire(String wire) => switch (wire) {
  'volume' => LedgerAxisKind.volume,
  'energy' => LedgerAxisKind.energy,
  'money' => LedgerAxisKind.money,
  'joy' => LedgerAxisKind.joy,
  _ => throw ArgumentError.value(
    wire,
    'wire',
    'Неизвестный kind для wire-format',
  ),
};
