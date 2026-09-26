import 'measure_family.dart';
import 'measure_unit.dart';

/// Единицы объёма — основная ось Пивомера: сколько выпито за тап и за период.
///
/// База семейства — [milliliter] (кубический сантиметр), поэтому у [liter]
/// коэффициент `1000`. Кубический сантиметр и кубический дециметр отдельными
/// единицами не выделены: они тождественны миллилитру и литру и различались бы
/// только подписью.
///
/// Пинты приведены к точным определениям: жидкая пинта США — `473.176473` мл
/// (1/8 галлона США), имперская — `568.26125` мл (1/8 галлона в 4.54609 л).
enum VolumeUnit implements MeasureUnit {
  /// Миллилитр — базовая единица семейства.
  milliliter('volume.ml', 'ml', 1.0),

  /// Литр — единица, в которой пользователь задаёт объём тапа («Пиво 0.5 L»).
  liter('volume.liter', 'L', 1000.0),

  /// Кубический метр — верхняя граница шкалы; в интерфейсе v1 не используется.
  cubicMeter('volume.m3', 'm³', 1000000.0),

  /// Жидкая пинта США — 1/8 галлона США.
  pintUs('volume.pint_us', 'pt US', 473.176473),

  /// Имперская пинта — 1/8 имперского галлона; привычная мера подачи пива в UK.
  pintImperial('volume.pint_imperial', 'pt imp', 568.26125);

  const VolumeUnit(this.id, this.symbol, this.ratioToBase);

  @override
  final String id;

  @override
  final String symbol;

  @override
  final double ratioToBase;

  @override
  MeasureFamily get family => MeasureFamily.volume;

  /// Единица с коэффициентом `1`, к которой приведены остальные.
  static const baseUnit = milliliter;

  /// Единица по умолчанию для новых осей и подписей в интерфейсе.
  static const defaultUnit = liter;

  static final Map<String, VolumeUnit> _byId = {
    for (final unit in values) unit.id: unit,
  };

  /// Возвращает единицу по [id] или `null`, если идентификатор неизвестен.
  ///
  /// Подмены на [defaultUnit] не происходит: неизвестный идентификатор — это
  /// повреждённые данные, и решение об обработке принимает вызывающий слой.
  static VolumeUnit? tryFromId(String id) => _byId[id];
}
