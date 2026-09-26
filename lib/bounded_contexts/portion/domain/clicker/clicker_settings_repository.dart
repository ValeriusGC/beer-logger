import 'package:beer_ledger_core/beer_ledger_core.dart';

import 'clicker.dart';
import 'clicker_id.dart';

/// Текущая порция clicker в SQLite.
///
/// Журнал тапов этот контракт не расширяет: порция и тапы — разные записи.
abstract interface class ClickerSettingsRepository {
  /// Поток [Clicker] с id [id].
  ///
  /// Нет строки — один seed пресета и дальше значение, не вечный пустой поток.
  Stream<Clicker> watchClicker(ClickerId id);

  /// Пишет четыре введённых числа [clicker]. Единицы и знаки в строку не кладёт.
  ///
  /// Ошибка БД — [Failure.storage] с `operation: saveClicker`.
  Future<Result<void>> saveClicker(Clicker clicker);
}
