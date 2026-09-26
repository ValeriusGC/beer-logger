import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test/test.dart';

void main() {
  group('convert', () {
    test('литр в миллилитры', () {
      final result = convert(
        value: 0.5,
        from: VolumeUnit.liter,
        to: VolumeUnit.milliliter,
      );

      expect(result, const Right(500.0));
    });

    test('килограмм в фунты', () {
      final result = convert(
        value: 1,
        from: MassUnit.kilogram,
        to: MassUnit.pound,
      );

      expect(result.getOrElse((_) => -1), closeTo(2.2046226, 1e-7));
    });

    test('обратный перевод возвращает исходное значение', () {
      const original = 2.0;

      final toPounds = convert(
        value: original,
        from: MassUnit.kilogram,
        to: MassUnit.pound,
      );
      final back = convert(
        value: toPounds.getOrElse((_) => throw StateError('expected Right')),
        from: MassUnit.pound,
        to: MassUnit.kilogram,
      );

      expect(back.getOrElse((_) => -1), closeTo(original, 1e-12));
    });

    test('перевод в ту же единицу не меняет значение', () {
      final result = convert(
        value: 0.5,
        from: VolumeUnit.liter,
        to: VolumeUnit.liter,
      );

      expect(result, const Right(0.5));
    });

    test('несовместимые семейства → Failure.incompatibleUnits', () {
      final result = convert(
        value: 1,
        from: VolumeUnit.liter,
        to: MoneyUnit.rouble,
      );

      expect(
        result,
        Left(
          Failure.incompatibleUnits(
            fromId: VolumeUnit.liter.id,
            toId: MoneyUnit.rouble.id,
          ),
        ),
      );
    });

    test('масса и энергия → incompatibleUnits', () {
      final result = convert(
        value: 3,
        from: MassUnit.gram,
        to: EnergyUnit.kilocalorie,
      );

      expect(result.isLeft(), isTrue);
      result.match(
        (failure) => expect(
          failure,
          Failure.incompatibleUnits(
            fromId: MassUnit.gram.id,
            toId: EnergyUnit.kilocalorie.id,
          ),
        ),
        (_) => fail('expected Left'),
      );
    });

    test('отрицательное value допустимо', () {
      final result = convert(
        value: -0.5,
        from: VolumeUnit.liter,
        to: VolumeUnit.milliliter,
      );

      expect(result, const Right(-500.0));
    });
  });

  group('toBase / fromBase', () {
    test('0.5 L → 500 мл в базе объёма', () {
      expect(toBase(0.5, VolumeUnit.liter), 500.0);
    });

    test('1 ₽ → 100 копеек в базе денег', () {
      expect(toBase(1, MoneyUnit.rouble), 100.0);
    });

    test('fromBase — обратная операция к toBase', () {
      expect(fromBase(500, VolumeUnit.liter), 0.5);
      expect(fromBase(toBase(2.5, MassUnit.kilogram), MassUnit.gram), 2500.0);
    });
  });

  group('deltaInBase', () {
    test('«Пиво 0.5 L», factor = 1 → 500 мл', () {
      expect(
        deltaInBase(enteredValue: 0.5, enteredIn: VolumeUnit.liter),
        500.0,
      );
    });

    test('factor умножает введённое значение', () {
      expect(
        deltaInBase(enteredValue: 0.5, enteredIn: VolumeUnit.liter, factor: 2),
        1000.0,
      );
    });

    test('совпадает с toBase(enteredValue * factor, enteredIn)', () {
      const entered = 1.5;
      const factor = 0.5;

      expect(
        deltaInBase(
          enteredValue: entered,
          enteredIn: MassUnit.kilogram,
          factor: factor,
        ),
        toBase(entered * factor, MassUnit.kilogram),
      );
    });
  });
}
