# Реестр: форматтеры

**Дата создания:** 2026-09-26 13:49:17 +0300  
**Последнее обновление:** 2026-09-28 07:45:59 +0300  
**Версия:** 3

Перед новым форматтером дат, строк, масок — проверить таблицу и grep по `lib/`.

| Имя | Путь | Назначение | Когда использовать |
|-----|------|------------|-------------------|
| `formatTodayBalanceLines` | `lib/bounded_contexts/journal/presentation/today_balance_format.dart` | Строки осей баланса дня | Builder главной |
| `formatTodayBalanceCompact` | `lib/bounded_contexts/journal/presentation/today_balance_format.dart` | Слеш-строка тех же осей для сжатого AppBar | Builder главной |
| `formatTodayClickTime` | `lib/bounded_contexts/journal/presentation/today_clicks_format.dart` | Время тапа в списке | Builder журнала на главной |
| `formatTodayClickVolume` | `lib/bounded_contexts/journal/presentation/today_clicks_format.dart` | Объём тапа в списке | Builder журнала на главной |
| `formatPortionInput` | `lib/bounded_contexts/portion/presentation/portion_input.dart` | Парсинг полей порции | Экран настроек |
