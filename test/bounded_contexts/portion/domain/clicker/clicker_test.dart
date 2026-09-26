import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/domain_fixtures.dart';

void main() {
  group('AxisSign', () {
    test('multiplier для plus и minus', () {
      expect(AxisSign.plus.multiplier, 1);
      expect(AxisSign.minus.multiplier, -1);
    });
  });

  group('LedgerAxis', () {
    test('copyWith меняет только запрошенное поле', () {
      const axis = LedgerAxis(
        kind: LedgerAxisKind.volume,
        enteredValue: 0.5,
        enteredInId: 'volume.liter',
        sign: AxisSign.plus,
      );

      final updated = axis.copyWith(enteredValue: 0.33);

      expect(updated.enteredValue, 0.33);
      expect(updated.kind, LedgerAxisKind.volume);
      expect(updated.enteredInId, 'volume.liter');
      expect(updated.sign, AxisSign.plus);
    });
  });

  group('Clicker', () {
    test('два одинаковых clicker равны', () {
      final a = beerHalfLiterClicker();
      final b = beerHalfLiterClicker();

      expect(a, b);
    });

    test('copyWith меняет title', () {
      final updated = beerHalfLiterClicker().copyWith(title: 'Другое');

      expect(updated.title, 'Другое');
      expect(updated.axes, beerHalfLiterClicker().axes);
    });
  });
}
