import 'measure_family.dart';
import 'measure_unit.dart';

/// Единицы массы — для осей, где тап измеряется весом (порция еды в MeaTap).
///
/// База семейства — [gram]. Имперские единицы заданы точными определениями:
/// унция — `28.349523125` г, фунт — `453.59237` г (международный фунт 1959 г.).
enum MassUnit implements MeasureUnit {
  /// Грамм — базовая единица семейства.
  gram('mass.g', 'g', 1.0),

  /// Килограмм.
  kilogram('mass.kg', 'kg', 1000.0),

  /// Метрическая тонна.
  ton('mass.t', 't', 1000000.0),

  /// Унция (avoirdupois).
  ounce('mass.oz', 'oz', 28.349523125),

  /// Фунт (avoirdupois).
  pound('mass.lb', 'lb', 453.59237);

  const MassUnit(this.id, this.symbol, this.ratioToBase);

  @override
  final String id;

  @override
  final String symbol;

  @override
  final double ratioToBase;

  @override
  MeasureFamily get family => MeasureFamily.mass;

  /// Единица с коэффициентом `1`, к которой приведены остальные.
  static const baseUnit = gram;

  /// Единица по умолчанию для новых осей и подписей в интерфейсе.
  static const defaultUnit = kilogram;

  static final Map<String, MassUnit> _byId = {
    for (final unit in values) unit.id: unit,
  };

  /// Возвращает единицу по [id] или `null`, если идентификатор неизвестен.
  ///
  /// Подмены на [defaultUnit] не происходит: неизвестный идентификатор — это
  /// повреждённые данные, и решение об обработке принимает вызывающий слой.
  static MassUnit? tryFromId(String id) => _byId[id];
}
