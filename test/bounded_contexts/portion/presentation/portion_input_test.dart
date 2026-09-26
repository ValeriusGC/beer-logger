import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('portionInputIsValid', () {
    test('границы включительно', () {
      expect(portionInputIsValid(PortionField.volume, '0.1'), isTrue);
      expect(portionInputIsValid(PortionField.volume, '3'), isTrue);
      expect(portionInputIsValid(PortionField.volume, '0.09'), isFalse);
      expect(portionInputIsValid(PortionField.volume, '3.1'), isFalse);

      expect(portionInputIsValid(PortionField.energy, '50'), isTrue);
      expect(portionInputIsValid(PortionField.energy, '250'), isTrue);
      expect(portionInputIsValid(PortionField.energy, '49.9'), isFalse);
      expect(portionInputIsValid(PortionField.energy, '250.1'), isFalse);

      expect(portionInputIsValid(PortionField.money, '0'), isTrue);
      expect(portionInputIsValid(PortionField.money, '10000'), isTrue);
      expect(portionInputIsValid(PortionField.money, '-1'), isFalse);
      expect(portionInputIsValid(PortionField.money, '10000.1'), isFalse);

      expect(portionInputIsValid(PortionField.joy, '0'), isTrue);
      expect(portionInputIsValid(PortionField.joy, '10'), isTrue);
      expect(portionInputIsValid(PortionField.joy, '-0.1'), isFalse);
      expect(portionInputIsValid(PortionField.joy, '10.1'), isFalse);
    });

    test('пусто, запятая, NaN и Infinity', () {
      expect(portionInputIsValid(PortionField.energy, ''), isFalse);
      expect(portionInputIsValid(PortionField.energy, '   '), isFalse);
      expect(portionInputIsValid(PortionField.energy, 'abc'), isFalse);
      expect(portionInputIsValid(PortionField.energy, 'NaN'), isFalse);
      expect(portionInputIsValid(PortionField.energy, 'Infinity'), isFalse);
      expect(portionInputIsValid(PortionField.volume, '0,5'), isTrue);
      expect(tryParsePortion('0,5'), 0.5);
    });
  });

  test('clickerWithPortion меняет только введённые числа', () {
    final updated = clickerWithPortion(
      beerHalfLiter(),
      volume: 0.5,
      energy: 180,
      money: 150,
      joy: 2,
    );

    expect(updated.title, beerHalfLiter().title);
    expect(portionEntered(updated, PortionField.energy), 180);
    final money = updated.axes.firstWhere(
      (axis) => axis.kind == LedgerAxisKind.money,
    );
    expect(money.sign, AxisSign.minus);
    expect(money.enteredInId, MoneyUnit.rouble.id);
  });
}
