import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:test/test.dart';

/// Golden-тест формата хранения единиц измерения.
///
/// `MeasureUnit.id` попадает в БД и в экспорт, поэтому его изменение — это
/// миграция данных, а не рефакторинг. Тест намеренно дублирует строки из
/// `lib/measure/`: он падает при любой правке идентификатора и заставляет
/// осознанно подтвердить изменение.
///
/// Порядок значений тоже зафиксирован: он определяет `index` и порядок пикеров
/// в интерфейсе. Хранить `index` запрещено — см. `MeasureUnit.id`.
void main() {
  group('Формат хранения id', () {
    test('VolumeUnit', () {
      expect(VolumeUnit.values.map((unit) => unit.id), [
        'volume.ml',
        'volume.liter',
        'volume.m3',
        'volume.pint_us',
        'volume.pint_imperial',
      ]);
    });

    test('MassUnit', () {
      expect(MassUnit.values.map((unit) => unit.id), [
        'mass.g',
        'mass.kg',
        'mass.t',
        'mass.oz',
        'mass.lb',
      ]);
    });

    test('MoneyUnit', () {
      expect(MoneyUnit.values.map((unit) => unit.id), [
        'money.kop',
        'money.rub',
      ]);
    });

    test('LengthUnit', () {
      expect(LengthUnit.values.map((unit) => unit.id), [
        'length.mm',
        'length.cm',
        'length.dm',
        'length.m',
        'length.km',
      ]);
    });

    test('EnergyUnit', () {
      expect(EnergyUnit.values.map((unit) => unit.id), [
        'energy.cal',
        'energy.kcal',
      ]);
    });

    test('CountUnit', () {
      expect(CountUnit.values.map((unit) => unit.id), [
        'count.times',
        'count.piece',
        'count.point',
      ]);
    });
  });
}
