import 'package:beer_logger/bounded_contexts/journal/domain/click/click.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';

/// Контракт persistence тапов. Реализация — шаг 05 (Drift).
abstract interface class ClickRepository {
  /// Сохраняет тап и вклады осей в одной транзакции.
  Future<Result<void>> addClick(Click click);

  /// Поток тапов за локальный календарный день `[dayLocal]`.
  Stream<List<Click>> watchClicksForDay(DateTime dayLocal);

  /// Поток тапов за полуинтервал локальных дат `[fromLocal, toLocal)`.
  ///
  /// [fromLocal] входит с начала своего календарного дня, [toLocal] исключается
  /// с начала своего. Перевод в UTC ms — `localDaysUtcRange`. Сортировка как у
  /// дня: `at DESC`, `id DESC`.
  ///
  /// Если календарная дата [fromLocal] не раньше [toLocal] — пустой поток,
  /// не ошибка. Watch не возвращает [Result].
  Stream<List<Click>> watchClicksInRange({
    required DateTime fromLocal,
    required DateTime toLocal,
  });

  /// Удаляет последний тап по `(at DESC, id DESC)` — undo v1 глобальный.
  Future<Result<void>> undoLastClick();
}
