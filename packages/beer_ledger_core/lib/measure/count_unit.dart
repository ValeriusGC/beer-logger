import 'measure_family.dart';
import 'measure_unit.dart';

/// Безразмерные единицы счёта: тапы, порции, баллы удовольствия.
///
/// Все единицы семейства имеют коэффициент `1`: они различаются только
/// подписью, а конвертация внутри семейства тождественна. Ось без единицы
/// измерения выражается отсутствием единицы (`null`), а не отдельным «пустым»
/// значением, — отдельная unit-заглушка не нужна.
enum CountUnit implements MeasureUnit {
  /// Раз — сколько раз пользователь нажал кнопку.
  times('count.times', '×', 1.0),

  /// Штука — порция, единица товара.
  piece('count.piece', 'pc', 1.0),

  /// Балл — шкала субъективной оценки, например ось удовольствия.
  point('count.point', 'pt', 1.0);

  const CountUnit(this.id, this.symbol, this.ratioToBase);

  @override
  final String id;

  @override
  final String symbol;

  @override
  final double ratioToBase;

  @override
  MeasureFamily get family => MeasureFamily.count;

  /// Единица с коэффициентом `1`, к которой приведены остальные.
  static const baseUnit = times;

  /// Единица по умолчанию для новых осей и подписей в интерфейсе.
  static const defaultUnit = times;

  static final Map<String, CountUnit> _byId = {
    for (final unit in values) unit.id: unit,
  };

  /// Возвращает единицу по [id] или `null`, если идентификатор неизвестен.
  ///
  /// Подмены на [defaultUnit] не происходит: неизвестный идентификатор — это
  /// повреждённые данные, и решение об обработке принимает вызывающий слой.
  static CountUnit? tryFromId(String id) => _byId[id];
}
