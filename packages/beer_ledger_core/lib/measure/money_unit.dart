import 'measure_family.dart';
import 'measure_unit.dart';

/// Единицы денежной оси — сколько тап стоит пользователю.
///
/// База семейства — [kopeck], минорная единица валюты: целочисленная база
/// избавляет от накопления ошибки при суммировании копеек за период. Валютные
/// курсы вне зоны ответственности домена — семейство описывает только рубль и
/// копейку одной валюты.
enum MoneyUnit implements MeasureUnit {
  /// Копейка — базовая единица семейства.
  kopeck('money.kop', 'kop', 1.0),

  /// Рубль — единица, в которой пользователь задаёт цену тапа.
  rouble('money.rub', '₽', 100.0);

  const MoneyUnit(this.id, this.symbol, this.ratioToBase);

  @override
  final String id;

  @override
  final String symbol;

  @override
  final double ratioToBase;

  @override
  MeasureFamily get family => MeasureFamily.money;

  /// Единица с коэффициентом `1`, к которой приведены остальные.
  static const baseUnit = kopeck;

  /// Единица по умолчанию для новых осей и подписей в интерфейсе.
  static const defaultUnit = rouble;

  static final Map<String, MoneyUnit> _byId = {
    for (final unit in values) unit.id: unit,
  };

  /// Возвращает единицу по [id] или `null`, если идентификатор неизвестен.
  ///
  /// Подмены на [defaultUnit] не происходит: неизвестный идентификатор — это
  /// повреждённые данные, и решение об обработке принимает вызывающий слой.
  static MoneyUnit? tryFromId(String id) => _byId[id];
}
