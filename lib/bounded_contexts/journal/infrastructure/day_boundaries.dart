import 'package:beer_logger/bounded_contexts/journal/infrastructure/click_mapper.dart';

/// Полуинтервал локального календарного дня в UTC ms для SQL-фильтра.
///
/// [dayLocal] — календарная дата в локальной TZ (время суток игнорируется).
/// Возвращает `[startUtcMs, endUtcMs)` — границы `[startOfDay, startOfNextDay)`.
({int startUtcMs, int endUtcMs}) localDayUtcRange(DateTime dayLocal) {
  final startOfDay = DateTime(dayLocal.year, dayLocal.month, dayLocal.day);
  final startOfNextDay = startOfDay.add(const Duration(days: 1));
  return (
    startUtcMs: clickAtUtcMs(startOfDay),
    endUtcMs: clickAtUtcMs(startOfNextDay),
  );
}

/// Полуинтервал нескольких локальных дней в UTC ms: `[startOf(from), startOf(to))`.
///
/// Время суток у [fromLocal] и [toLocal] игнорируется. Перевод в UTC — тот же,
/// что у [localDayUtcRange]: конец диапазона — начало дня [toLocal], не конец
/// предыдущего, посчитанный отдельно.
///
/// Если календарный день [fromLocal] не раньше [toLocal], [startUtcMs] не меньше
/// [endUtcMs]. Пустой поток в этом случае отдаёт репозиторий, не эта функция.
({int startUtcMs, int endUtcMs}) localDaysUtcRange({
  required DateTime fromLocal,
  required DateTime toLocal,
}) {
  return (
    startUtcMs: localDayUtcRange(fromLocal).startUtcMs,
    endUtcMs: localDayUtcRange(toLocal).startUtcMs,
  );
}
