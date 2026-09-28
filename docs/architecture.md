# Архитектура Пивомера

**Дата создания:** 2026-09-25 15:23:47 +0300  
**Последнее обновление:** 2026-09-28 08:30 EEST  
**Версия:** 11  
**Вид документа:** спецификация

Пивомер — offline-приложение с trade-off tap: одно нажатие фиксирует несколько осей учёта (объём, ккал, деньги, удовольствие). Архитектура разделяет живые настройки и уже случившиеся факты, чтобы изменение ккал сегодня не переписывало вчерашние записи.

## Два bounded context

**Порция** — живые настройки нажатия: что произойдёт, если пользователь тапнет сейчас. Здесь хранятся пресеты, оси учёта и текущая конфигурация кликера.

**Журнал** — факты, которые уже случились: записанные тапы, балансы за период, история. Журнал не знает, какими настройками пользователь тапнет завтра.

Карточка баланса и график — не третий контекст. Это presentation журнала: UI-проекция уже записанных фактов.

## Слои внутри контекста

Каждый bounded context содержит четыре слоя:

```
presentation → application → domain ← infrastructure
```

- **presentation** — виджеты и UI-проекции.
- **application** — сценарии использования, оркестрация.
- **domain** — агрегаты, value object'ы, контракты репозиториев.
- **infrastructure** — Drift-реализации репозиториев.

Слои живут **внутри** контекста, не вокруг всего приложения. Отвергнутый вариант — слой-first (`lib/domain` на всё приложение): он прячет границу порции и журнала.

## Домен порции и журнала

Агрегаты лежат в папках агрегатов, не в общих `entities/` / `value_objects/`:

- **Порция** — `portion/domain/clicker/`: [Clicker], [LedgerAxis], пресет «Пиво 0.5 L» ([beerHalfLiter]).
- **Журнал** — `journal/domain/click/`: [Click], [AxisContribution], [aggregateForPeriod].

[Click.record] принимает `List<AxisRecordInput>`, не [Clicker]. Домен журнала импортирует из порции только [ClickerId] — ссылку на чужой агрегат, не живую конфигурацию.

Мост порция → журнал — [axisRecordInputsFrom] в `journal/application/`: переводит оси живого [Clicker] на вход [Click.record].

Вклад в [AxisContribution] заморожен в базовой единице семейства; смена живой порции уже записанный [Click] не пересчитывает.

Контракты [ClickRepository] и [ClickerSettingsRepository] лежат в папке агрегата. Реализации — [DriftClickRepository] и [DriftClickerSettingsRepository] в `infrastructure/` своего контекста.

Отвергнуто: `Click.record(Clicker)` — журнал заговорил бы языком порции. Отвергнуто: класть [Click]/[Clicker] в `beer_ledger_core`.

## Техническое ядро

`packages/beer_ledger_core` — pure Dart-пакет без Flutter. Это не bounded context: ядро не отвечает ни на «что будет при нажатии», ни на «что уже случилось». Два вопроса по-прежнему у `portion` и `journal`.

Содержимое ядра:

1. **Шесть enum-семейств единиц** — volume, mass, money, length, energy, count. Конвертация только внутри семейства по формуле `value * from.ratioToBase / to.ratioToBase`. Масса и длина не оси продукта v1, но держат инвариант «перевод только внутри семейства».
2. **Хранение факта** — учёт хранит значение в **базовой** единице семейства (миллилитр, копейка, калория…). Wire-ключ — `MeasureUnit.id`, не `enum.index`. В приложении факт пишется в SQLite через Drift.
3. **`Result<T> = Either<Failure, T>`** (fpdart): Left — [Failure], Right — успех.
4. **Маркеры DDD** — пустые контракты `AggregateRoot`, `Entity`, `ValueObject`; конкретные типы — в агрегатах bounded context.
5. **`LedgerAxisKind`** — четыре оси продукта (volume, energy, money, joy), общий словарь обоих языков.

Отвергнуто класть `Click`/`Clicker` в этот пакет: это прячет границу двух контекстов. Отвергнуто тащить Flutter в ядро.

## Композиция приложения

`lib/core/` — композиция: одна БД и DI. Не бизнес-контекст.

- `core/persistence/` — [AppDatabase] (`schemaVersion: 1`, файл `beer_logger`).
- `core/di/` — провайдеры `appDatabase`, `clickRepository`, `clickerSettingsRepository`, `now`.

`lib/app/` — оболочка: [ProviderScope] вокруг `MaterialApp.router`, маршруты в `router.dart`.

## Persistence и Riverpod

1. **Одна [AppDatabase]** в `lib/core/persistence/` на оба bounded context. Три таблицы: тапы, вклады осей, живая порция. Отвергнуто: две SQLite или SharedPreferences рядом.
2. **Реализации** — в `infrastructure/` своего контекста; контракты остаются в `domain/click/` и `domain/clicker/`.
3. **Riverpod:** DI в `lib/core/di/`; сценарии в `application/`:
   - журнал: `record_click`, `undo_last_click`, `clicks_for_today`, `today_balance`, `volume_for_last_7_days`;
   - порция: `current_clicker`.
   - Отвергнуто: `lib/app/providers/`.
4. **Запись тапа** — [record_click] берёт текущую порцию из `currentClicker`, не из зашитого пресета. [Click.record] по-прежнему принимает `List<AxisRecordInput>`, не [Clicker]. Момент тапа — свежий `DateTime.now()` в тот же календарный день, без [Ref.refresh] кэша `now`. Инвалидация границ дня на каждый тап переводила запросы в reload и на кадр подменяла карточки индикатором.

## UI Projection главной

Главная собрана в `journal/presentation/home/` по цепочке:

```
факты application/domain
        → Factory (пустой день? кнопка активна?)
        → Projection (данные без строк UI)
        → Builder (l10n + formatToday*)
        → UiModel (готовые строки)
        → dumb Widget (рисует UiModel, зовёт callback)
```

[HomePage] не смотрит всю проекцию: секции баланса, кнопки и журнала берут свой срез через `select`, чтобы тап не пересобирал карточку, список и график. [HomeUiModelBuilder] форматирует только этот срез. Snackbar и haptic — `ref.listen` на [HomePage]. Кнопка записи — `Scaffold.bottomNavigationBar` плюс `SafeArea`, не sliver: не уезжает со скроллом и не прячется под home indicator. Compact: pinned [SliverAppBar] (только chrome) и карточка баланса отдельным sliver с intrinsic-высотой; при скролле вверх те же оси — слеш-строка в title по позиции карточки. Wide: pinned-бар, карточка и график в одном ряду. Layout `>= 600` — `LayoutBuilder` выбирает compact или wide body целиком. [HomeController] — только `record` / `undo`. Навигация в настройки — `context.go('/settings')`.

[TodayBalanceCard] и [TodayClicksSection] получают UiModel конструктором — dumb-виджеты без `ConsumerWidget`. [WeekVolumeChart] смотрит `volumeForLast7DaysProvider` сам и в Factory не входит: график рисует готовые литры.

Отвергнуто: считать оси в `build` виджета. Отвергнуто: третий bounded context «витрина».

## Настройки порции

Экран `portion/presentation/settings_page.dart` — поля и Save, без Factory. Четыре числа живой порции; смена ккал не переписывает уже записанные тапы.

## Маршрутизация и локализация

Один корень `/` (главная) и дочерний `settings` — полный путь `/settings` (порция). Переход — `go`: стек берётся из дерева маршрутов, под настройками остаётся главная. `push` отвергнут: он кладёт страницу императивно, мимо этого дерева. Flavors нет.

Локализация gen-l10n: русский и английский (`lib/l10n/`). Пользовательские строки UI — из l10n, не литералы в `build`.

## Границы между контекстами

Соседний `domain/` не импортируется напрямую. Мост порция → журнал — [axisRecordInputsFrom] в `journal/application/`.

## Дерево папок

```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── router.dart
├── l10n/
│   ├── app_en.arb
│   ├── app_ru.arb
│   └── app_localizations.dart
├── core/
│   ├── di/
│   │   ├── app_database.cg.dart
│   │   ├── click_repository.cg.dart
│   │   ├── clicker_settings_repository.cg.dart
│   │   └── now.cg.dart
│   └── persistence/
│       └── app_database.dart
└── bounded_contexts/
    ├── portion/
    │   ├── portion.dart
    │   ├── domain/clicker/…
    │   ├── application/current_clicker.cg.dart
    │   ├── infrastructure/…
    │   └── presentation/
    │       ├── portion_input.dart
    │       └── settings_page.dart
    └── journal/
        ├── journal.dart
        ├── domain/click/…
        ├── application/…
        ├── infrastructure/…
        └── presentation/
            ├── home/
            │   ├── home_page.dart
            │   ├── home_projection_factory.dart
            │   ├── home_ui_model_builder.dart
            │   └── …
            ├── today_balance_card.dart
            ├── today_clicks_section.dart
            └── week_volume_chart.dart
```
