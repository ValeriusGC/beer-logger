# Реестр: виджеты

**Дата создания:** 2026-09-26 13:49:17 +0300  
**Последнее обновление:** 2026-09-28 08:55 EEST  
**Версия:** 3

Перед созданием нового shared-виджета — проверить эту таблицу и сделать grep по `lib/`.

Корзины `lib/ui/shared/` в проекте нет — виджеты живут в `presentation/` bounded context.

| Имя | Путь | Назначение | Когда использовать |
|-----|------|------------|-------------------|
| `HomePage` | `lib/bounded_contexts/journal/presentation/home/home_page.dart` | Главный экран: баланс, тап, журнал, график | Маршрут `/` |
| `TodayBalanceCard` | `lib/bounded_contexts/journal/presentation/today_balance_card.dart` | Карточка баланса дня | На главной, dumb-виджет с UiModel |
| `TodayClicksSection` | `lib/bounded_contexts/journal/presentation/today_clicks_section.dart` | Список тапов за сегодня с undo | На главной, dumb-виджет с UiModel |
| `WeekChartsCarousel` | `lib/bounded_contexts/journal/presentation/week_charts_carousel.dart` | Карусель недельных графиков по 4 осям | На главной, сам смотрит провайдер |
| `SettingsPage` | `lib/bounded_contexts/portion/presentation/settings_page.dart` | Настройки живой порции | Маршрут `/settings` |
