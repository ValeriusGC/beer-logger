# Реестр: провайдеры и сервисы

**Дата создания:** 2026-09-26 13:49:17 +0300  
**Последнее обновление:** 2026-09-28 08:55 EEST  
**Версия:** 3

Перед новым переиспользуемым провайдером или сервисом — проверить таблицу и grep по `lib/`.

| Имя | Путь | Назначение | Когда использовать |
|-----|------|------------|-------------------|
| `appDatabase` | `lib/core/di/app_database.cg.dart` | Единая Drift-БД | DI репозиториев |
| `clickRepository` | `lib/core/di/click_repository.cg.dart` | Репозиторий тапов | Application журнала |
| `clickerSettingsRepository` | `lib/core/di/clicker_settings_repository.cg.dart` | Репозиторий живой порции | Application порции |
| `now` | `lib/core/di/now.cg.dart` | Текущее время | Запись тапа, границы дня |
| `recordClickProvider` | `lib/bounded_contexts/journal/application/record_click.cg.dart` | Запись тапа | Главная, HomeController |
| `undoLastClickProvider` | `lib/bounded_contexts/journal/application/undo_last_click.cg.dart` | Отмена последнего тапа | Главная, HomeController |
| `clicksForTodayProvider` | `lib/bounded_contexts/journal/application/clicks_for_today.cg.dart` | Тапы за сегодня | HomeProjection |
| `todayBalanceProvider` | `lib/bounded_contexts/journal/application/today_balance.cg.dart` | Баланс за сегодня | HomeProjection |
| `weekAxisChartsForLast7DaysProvider` | `lib/bounded_contexts/journal/application/week_axis_charts_for_last_7_days.cg.dart` | Четыре оси по дням за неделю | WeekChartsCarousel |
| `currentClickerProvider` | `lib/bounded_contexts/portion/application/current_clicker.cg.dart` | Живая порция | Запись тапа, настройки |
| `homeProjectionProvider` | `lib/bounded_contexts/journal/presentation/home/home_projection.cg.dart` | UI Projection главной | HomePage |
| `homeControllerProvider` | `lib/bounded_contexts/journal/presentation/home/home_controller.cg.dart` | record / undo на главной | HomePage |
