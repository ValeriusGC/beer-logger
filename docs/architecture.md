# Архитектура Пивомера

**Дата создания:** 2026-09-25 15:23:47 +0300  
**Последнее обновление:** 2026-09-26 15:43:52 +0300  
**Версия:** 3  
**Вид документа:** спецификация

Пивомер — offline-приложение с trade-off tap: одно нажатие фиксирует несколько осей учёта (объём, ккал, деньги, удовольствие). Архитектура разделяет живые настройки и уже случившиеся факты, чтобы изменение ккал сегодня не переписывало вчерашние записи.

## Два bounded context

**Порция** — живые настройки нажатия: что произойдёт, если пользователь тапнет сейчас. Здесь хранятся пресеты, оси учёта и текущая конфигурация кликера.

**Журнал** — факты, которые уже случились: записанные тапы, балансы за период, история. Журнал не знает, какими настройками пользователь тапнет завтра.

Карточка баланса и график — не третий контекст. Это presentation журнала: UI-проекция уже записанных фактов. Появятся на шаге 06.

## Слои внутри контекста

Каждый bounded context содержит четыре слоя:

```
presentation → application → domain ← infrastructure
```

- **presentation** — виджеты и UI-проекции.
- **application** — сценарии использования, оркестрация.
- **domain** — агрегаты, value object'ы, контракты репозиториев.
- **infrastructure** — реализации репозиториев (Drift появится на шаге 05).

Слои живут **внутри** контекста, не вокруг всего приложения. Отвергнутый вариант — слой-first (`lib/domain` на всё приложение): он прячет границу порции и журнала.

## Домен порции и журнала

Агрегаты лежат в папках агрегатов, не в общих `entities/` / `value_objects/`:

- **Порция** — `portion/domain/clicker/`: [Clicker], [LedgerAxis], пресет «Пиво 0.5 L» ([beerHalfLiter]).
- **Журнал** — `journal/domain/click/`: [Click], [AxisContribution], [aggregateForPeriod].

[Click.record] принимает `List<AxisRecordInput>`, не [Clicker]. Домен журнала импортирует из порции только [ClickerId] — ссылку на чужой агрегат, не живую конфигурацию.

Мост порция → журнал — [axisRecordInputsFrom] в `journal/application/`: переводит оси живого [Clicker] на вход [Click.record].

Вклад в [AxisContribution] заморожен в базовой единице семейства; смена живой порции уже записанный [Click] не пересчитывает.

Контракты [ClickRepository] и [ClickerSettingsRepository] лежат в папке агрегата. Реализаций Drift нет — шаг 05.

Отвергнуто: `Click.record(Clicker)` — журнал заговорил бы языком порции. Отвергнуто: класть [Click]/[Clicker] в `beer_ledger_core`.

## Техническое ядро

`packages/beer_ledger_core` — pure Dart-пакет без Flutter. Это не bounded context: ядро не отвечает ни на «что будет при нажатии», ни на «что уже случилось». Два вопроса по-прежнему у `portion` и `journal`.

Содержимое ядра:

1. **Шесть enum-семейств единиц** — volume, mass, money, length, energy, count. Конвертация только внутри семейства по формуле `value * from.ratioToBase / to.ratioToBase`. Масса и длина не оси продукта v1, но держат инвариант «перевод только внутри семейства».
2. **Хранение факта** — учёт хранит значение в **базовой** единице семейства (миллилитр, копейка, калория…). Wire-ключ — `MeasureUnit.id`, не `enum.index`. Реализации записи в приложении ещё нет.
3. **`Result<T> = Either<Failure, T>`** (fpdart): Left — [Failure], Right — успех.
4. **Маркеры DDD** — пустые контракты `AggregateRoot`, `Entity`, `ValueObject`; конкретные типы — в агрегатах bounded context.
5. **`LedgerAxisKind`** — четыре оси продукта (volume, energy, money, joy), общий словарь обоих языков.

Отвергнуто класть `Click`/`Clicker` в этот пакет: это прячет границу двух контекстов. Отвергнуто тащить Flutter в ядро.

## Композиция приложения

`lib/core/` — композиция: DI, общая БД, провайдеры. Не бизнес-контекст. На этом шаге папка пуста.

`lib/app/` — оболочка: `MaterialApp`, позже роутер.

## Границы между контекстами

Соседний `domain/` не импортируется напрямую. Мост порция → журнал — [axisRecordInputsFrom] в `journal/application/`.

## Следующие шаги

| Шаг | Содержание |
|-----|------------|
| 05 | Drift, Riverpod |
| 06 | UI Projection главной |

## Дерево папок

```
lib/
├── main.dart
├── app/
│   └── app.dart
├── core/
│   └── .gitkeep
└── bounded_contexts/
    ├── portion/
    │   ├── portion.dart
    │   ├── domain/
    │   │   └── clicker/
    │   │       ├── axis_sign.dart
    │   │       ├── beer_half_liter.dart
    │   │       ├── clicker.dart
    │   │       ├── clicker_id.dart
    │   │       ├── clicker_settings_repository.dart
    │   │       └── ledger_axis.dart
    │   ├── application/
    │   ├── infrastructure/
    │   └── presentation/
    └── journal/
        ├── journal.dart
        ├── domain/
        │   └── click/
        │       ├── aggregate_for_period.dart
        │       ├── axis_contribution.dart
        │       ├── axis_record_input.dart
        │       ├── click.dart
        │       ├── click_id.dart
        │       ├── click_repository.dart
        │       ├── period_balances.dart
        │       └── signed_base_delta.dart
        ├── application/
        │   └── axis_record_inputs.dart
        ├── infrastructure/
        └── presentation/
            └── home_page.dart
```

`home_page.dart` — заглушка «Пивомер» до шага 06.
