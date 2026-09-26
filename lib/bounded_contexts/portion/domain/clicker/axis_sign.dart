/// Направление вклада оси в баланс: прибавляет или вычитает.
///
/// Знак задаётся на конфигурации оси ([LedgerAxis.sign]) и применяется один раз
/// при записи тапа в [AxisContribution.delta] снимка [AxisContribution].
enum AxisSign {
  /// Увеличивает баланс оси (объём, ккал, удовольствие).
  plus,

  /// Уменьшает баланс оси (деньги в v1).
  minus;

  /// Множитель для расчёта [AxisContribution.delta]: `1` или `-1`.
  int get multiplier => switch (this) {
    AxisSign.plus => 1,
    AxisSign.minus => -1,
  };
}
