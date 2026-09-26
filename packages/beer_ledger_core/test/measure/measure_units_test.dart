import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:test/test.dart';

/// Перевод значения по контракту [MeasureUnit.ratioToBase].
///
/// Формула повторена намеренно: тест фиксирует контракт, на который будет
/// опираться функция [convert].
double _convert(double value, MeasureUnit from, MeasureUnit to) =>
    value * from.ratioToBase / to.ratioToBase;

void main() {
  _verifyFamilyContract(
    label: 'VolumeUnit',
    family: MeasureFamily.volume,
    idPrefix: 'volume.',
    values: VolumeUnit.values,
    defaultUnit: VolumeUnit.defaultUnit,
    baseUnit: VolumeUnit.baseUnit,
    tryFromId: VolumeUnit.tryFromId,
  );

  _verifyFamilyContract(
    label: 'MassUnit',
    family: MeasureFamily.mass,
    idPrefix: 'mass.',
    values: MassUnit.values,
    defaultUnit: MassUnit.defaultUnit,
    baseUnit: MassUnit.baseUnit,
    tryFromId: MassUnit.tryFromId,
  );

  _verifyFamilyContract(
    label: 'MoneyUnit',
    family: MeasureFamily.money,
    idPrefix: 'money.',
    values: MoneyUnit.values,
    defaultUnit: MoneyUnit.defaultUnit,
    baseUnit: MoneyUnit.baseUnit,
    tryFromId: MoneyUnit.tryFromId,
  );

  _verifyFamilyContract(
    label: 'LengthUnit',
    family: MeasureFamily.length,
    idPrefix: 'length.',
    values: LengthUnit.values,
    defaultUnit: LengthUnit.defaultUnit,
    baseUnit: LengthUnit.baseUnit,
    tryFromId: LengthUnit.tryFromId,
  );

  _verifyFamilyContract(
    label: 'EnergyUnit',
    family: MeasureFamily.energy,
    idPrefix: 'energy.',
    values: EnergyUnit.values,
    defaultUnit: EnergyUnit.defaultUnit,
    baseUnit: EnergyUnit.baseUnit,
    tryFromId: EnergyUnit.tryFromId,
  );

  _verifyFamilyContract(
    label: 'CountUnit',
    family: MeasureFamily.count,
    idPrefix: 'count.',
    values: CountUnit.values,
    defaultUnit: CountUnit.defaultUnit,
    baseUnit: CountUnit.baseUnit,
    tryFromId: CountUnit.tryFromId,
  );

  group('Реестр единиц в целом', () {
    test('каждое семейство представлено хотя бы одной единицей', () {
      expect(
        allUnits.map((unit) => unit.family).toSet(),
        MeasureFamily.values.toSet(),
      );
    });

    test('идентификаторы уникальны во всех семействах', () {
      final ids = allUnits.map((unit) => unit.id).toList();

      expect(ids.toSet().length, ids.length);
    });

    test('единицы разных семейств не равны при совпадении коэффициента', () {
      expect(MassUnit.gram.ratioToBase, MoneyUnit.kopeck.ratioToBase);
      expect(MassUnit.gram, isNot(MoneyUnit.kopeck));
    });
  });

  group('Эталонные коэффициенты', () {
    test('литр — 1000 миллилитров', () {
      expect(_convert(0.5, VolumeUnit.liter, VolumeUnit.milliliter), 500.0);
    });

    test('пинта США — 473.176473 мл', () {
      expect(_convert(1, VolumeUnit.pintUs, VolumeUnit.milliliter), 473.176473);
    });

    test('имперская пинта — 568.26125 мл', () {
      expect(
        _convert(1, VolumeUnit.pintImperial, VolumeUnit.milliliter),
        568.26125,
      );
    });

    test('килограмм — 1000 граммов, тонна — 1000 килограммов', () {
      expect(_convert(1, MassUnit.kilogram, MassUnit.gram), 1000.0);
      expect(_convert(1, MassUnit.ton, MassUnit.kilogram), 1000.0);
    });

    test('унция — 28.349523125 г, фунт — 453.59237 г', () {
      expect(_convert(1, MassUnit.ounce, MassUnit.gram), 28.349523125);
      expect(_convert(1, MassUnit.pound, MassUnit.gram), 453.59237);
    });

    test('килограмм — примерно 2.2046 фунта', () {
      expect(
        _convert(1, MassUnit.kilogram, MassUnit.pound),
        closeTo(2.2046226, 1e-7),
      );
    });

    test('рубль — 100 копеек', () {
      expect(_convert(1, MoneyUnit.rouble, MoneyUnit.kopeck), 100.0);
    });

    test('метр — 1000 миллиметров', () {
      expect(_convert(1, LengthUnit.meter, LengthUnit.millimeter), 1000.0);
    });

    test('килокалория — 1000 калорий', () {
      expect(_convert(1, EnergyUnit.kilocalorie, EnergyUnit.calorie), 1000.0);
    });
  });

  group('Контракт конвертации', () {
    test('перевод в ту же единицу не меняет значение', () {
      expect(_convert(0.5, VolumeUnit.liter, VolumeUnit.liter), 0.5);
    });

    test('обратный перевод возвращает исходное значение', () {
      final inPounds = _convert(2, MassUnit.kilogram, MassUnit.pound);

      expect(
        _convert(inPounds, MassUnit.pound, MassUnit.kilogram),
        closeTo(2.0, 1e-12),
      );
    });

    test('внутри семейства счёта конвертация тождественна', () {
      expect(_convert(3, CountUnit.piece, CountUnit.point), 3.0);
    });
  });
}

/// Все единицы всех семейств — для проверок, охватывающих реестр целиком.
const allUnits = <MeasureUnit>[
  ...VolumeUnit.values,
  ...MassUnit.values,
  ...MoneyUnit.values,
  ...LengthUnit.values,
  ...EnergyUnit.values,
  ...CountUnit.values,
];

/// Проверяет инварианты, обязательные для любого семейства единиц.
///
/// [baseUnit] — единица с коэффициентом `1`, [idPrefix] — обязательный префикс
/// идентификаторов, [tryFromId] — поиск по идентификатору без подмены значения.
void _verifyFamilyContract<T extends MeasureUnit>({
  required String label,
  required MeasureFamily family,
  required String idPrefix,
  required List<T> values,
  required T defaultUnit,
  required T baseUnit,
  required T? Function(String id) tryFromId,
}) {
  group('$label — инварианты семейства', () {
    test('базовая единица имеет коэффициент 1', () {
      expect(baseUnit.ratioToBase, 1.0);
    });

    test('все единицы объявлены в семействе $family', () {
      expect(values.map((unit) => unit.family).toSet(), {family});
    });

    test('идентификаторы уникальны и начинаются с "$idPrefix"', () {
      final ids = values.map((unit) => unit.id).toList();

      expect(ids.toSet().length, ids.length);
      expect(ids.every((id) => id.startsWith(idPrefix)), isTrue);
    });

    test('коэффициенты положительны', () {
      expect(values.every((unit) => unit.ratioToBase > 0), isTrue);
    });

    test('единица по умолчанию входит в values', () {
      expect(values, contains(defaultUnit));
    });

    test('tryFromId возвращает тот же экземпляр для каждого id', () {
      for (final unit in values) {
        expect(identical(tryFromId(unit.id), unit), isTrue, reason: unit.id);
      }
    });

    test('tryFromId возвращает null для неизвестного и пустого id', () {
      expect(tryFromId('${idPrefix}unknown'), isNull);
      expect(tryFromId(''), isNull);
    });
  });
}
