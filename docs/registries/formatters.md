# Реестр: форматтеры

**Дата создания:** 2026-09-26 13:49:17 +0300  
**Последнее обновление:** 2026-09-28 09:27 EEST  
**Версия:** 4

Перед новым форматтером дат, строк, масок — проверить таблицу и grep по `lib/`.

| Имя | Путь | Назначение | Когда использовать |
|-----|------|------------|-------------------|
| `formatTodayBalanceLines` | `lib/bounded_contexts/journal/presentation/today_balance_format.dart` | Строки осей баланса дня (`FormattedAxisValue`) | Builder главной |
| `formatTodayBalanceCompact` | `lib/bounded_contexts/journal/presentation/today_balance_format.dart` | Сегменты слеш-строки для сжатого AppBar | Builder главной |
| `formatWeekChartAxisTotal` | `lib/bounded_contexts/journal/presentation/today_balance_format.dart` | Итог оси за 7 дней для заголовка графика | WeekChartsCarousel |
| `formatTodayClickTime` | `lib/bounded_contexts/journal/presentation/today_clicks_format.dart` | Время тапа в списке | Builder журнала на главной |
| `formatTodayClickVolume` | `lib/bounded_contexts/journal/presentation/today_clicks_format.dart` | Объём тапа в списке | Builder журнала на главной |
| `formatPortionInput` | `lib/bounded_contexts/portion/presentation/portion_input.dart` | Парсинг полей порции | Экран настроек |
