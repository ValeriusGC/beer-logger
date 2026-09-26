import 'measure_family.dart';
import 'measure_unit.dart';

/// Единицы энергии — ось калорий: сколько тап «стоит» в еде.
///
/// База семейства — [calorie], поэтому у [kilocalorie] коэффициент `1000`.
/// Выделены в отдельное семейство от безразмерного счёта осознанно: иначе
/// перевод «порции в килокалории» проходил бы без ошибки.
enum EnergyUnit implements MeasureUnit {
  /// Калория — базовая единица семейства.
  calorie('energy.cal', 'cal', 1.0),

  /// Килокалория — единица, в которой пользователь задаёт калорийность тапа.
  kilocalorie('energy.kcal', 'kcal', 1000.0);

  const EnergyUnit(this.id, this.symbol, this.ratioToBase);

  @override
  final String id;

  @override
  final String symbol;

  @override
  final double ratioToBase;

  @override
  MeasureFamily get family => MeasureFamily.energy;

  /// Единица с коэффициентом `1`, к которой приведены остальные.
  static const baseUnit = calorie;

  /// Единица по умолчанию для новых осей и подписей в интерфейсе.
  static const defaultUnit = kilocalorie;

  static final Map<String, EnergyUnit> _byId = {
    for (final unit in values) unit.id: unit,
  };

  /// Возвращает единицу по [id] или `null`, если идентификатор неизвестен.
  ///
  /// Подмены на [defaultUnit] не происходит: неизвестный идентификатор — это
  /// повреждённые данные, и решение об обработке принимает вызывающий слой.
  static EnergyUnit? tryFromId(String id) => _byId[id];
}
