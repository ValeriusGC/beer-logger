import 'measure_family.dart';
import 'measure_unit.dart';

/// Единицы длины — часть общего движка измерений; Пивомер их не использует,
/// они нужны вертикалям вроде трекинга дистанции.
///
/// База семейства — [meter], шкала метрическая.
enum LengthUnit implements MeasureUnit {
  /// Миллиметр.
  millimeter('length.mm', 'mm', 0.001),

  /// Сантиметр.
  centimeter('length.cm', 'cm', 0.01),

  /// Дециметр.
  decimeter('length.dm', 'dm', 0.1),

  /// Метр — базовая единица семейства.
  meter('length.m', 'm', 1.0),

  /// Километр.
  kilometer('length.km', 'km', 1000.0);

  const LengthUnit(this.id, this.symbol, this.ratioToBase);

  @override
  final String id;

  @override
  final String symbol;

  @override
  final double ratioToBase;

  @override
  MeasureFamily get family => MeasureFamily.length;

  /// Единица с коэффициентом `1`, к которой приведены остальные.
  static const baseUnit = meter;

  /// Единица по умолчанию для новых осей и подписей в интерфейсе.
  static const defaultUnit = meter;

  static final Map<String, LengthUnit> _byId = {
    for (final unit in values) unit.id: unit,
  };

  /// Возвращает единицу по [id] или `null`, если идентификатор неизвестен.
  ///
  /// Подмены на [defaultUnit] не происходит: неизвестный идентификатор — это
  /// повреждённые данные, и решение об обработке принимает вызывающий слой.
  static LengthUnit? tryFromId(String id) => _byId[id];
}
