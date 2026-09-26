import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';

/// Clicker preset «Пиво 0.5 L» для тестов domain-слоя.
Clicker beerHalfLiterClicker() => beerHalfLiter();

AxisContribution? contribution(Click click, LedgerAxisKind kind) {
  for (final item in click.contributions) {
    if (item.kind == kind) return item;
  }
  return null;
}
