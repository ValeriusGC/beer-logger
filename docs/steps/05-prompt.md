# Шаг 05 — Drift и Riverpod

**Дата создания:** 2026-09-26 16:15:30 +0300  
**Последнее обновление:** 2026-09-26 16:15:30 +0300  
**Версия:** 1  
**Вид документа:** инструкция

> [!IMPORTANT]
> В чат кладётся **только этот файл**. Остальное исполнитель открывает сам по абсолютным путям ниже. Человек не вкладывает `_COMMON.md`, `rules.md` и `_CRITIC.md`.
>
> **Модель шага — Composer 2.5** (или слабее автора промпта). Workspace Cursor: `/Users/vvk/AndroidStudioProjects/r/beer-logger`.
>
> Первой фразой ответа назови модель. Не совпало — остановись и попроси переключить; файлы не трогай.

## 0. Прочитать до любой правки (обязательно, по порядку)

Открой каждый файл целиком инструментом чтения. Не угадывай содержимое.

1. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/prompts/_COMMON.md`
2. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/rules.md`
3. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/.cursor/rules/quality-bar.mdc`
4. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/.cursor/rules/doc-header-metadata.mdc`
5. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/plan.md` — этот шаг = `step/05-persistence`, сквош `feat: подключить Drift и Riverpod (#‹цифры issue›)`
6. `/Users/vvk/AndroidStudioProjects/r/beer_ledger/docs/project-structure.md` — смысл: одна `AppDatabase` в `lib/core/persistence/`, реализации в `infrastructure/` контекста, сценарии в `application/`, DI в `lib/core/di/`.
7. `/Users/vvk/AndroidStudioProjects/r/beer-logger/docs/architecture.md`
8. `/Users/vvk/AndroidStudioProjects/r/beer-logger/pubspec.yaml`
9. `/Users/vvk/AndroidStudioProjects/r/beer-logger/AGENTS.md`
10. `/Users/vvk/AndroidStudioProjects/r/beer-logger/lib/main.dart`, `lib/app/app.dart`, контракты `click_repository.dart` и `clicker_settings_repository.dart`

Затем **прочитай все исходники из таблицы §5** в доноре.

Не открывать `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/prompts/_CRITIC.md`.

Не открывать `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/operator.md`.

Не копировать: `presentation/` (кроме уже существующей заглушки home), `l10n/`, flavor, router, `fl_chart`, ADR, `.github` донора, `*.g.dart`, `*.cg.g.dart`.

`_COMMON` §6 YAGNI запрещает Drift/Riverpod **на чужих шагах**. Этот шаг их как раз подключает.

## Issue (человек, до чата; модель не создаёт)

Title и body ниже уходят на GitHub **как есть**. Только язык задачи в репозитории.

**Title**

```
Подключить Drift и Riverpod
```

**Body**

```
## Зачем

Тап должен переживать перезапуск: факты в SQLite, живая порция — отдельная таблица. Экраны пока не рисуют цифры; слой приложения отдаёт потоки списка, баланса и записи.

## Сделать

- одна `AppDatabase` в `lib/core/persistence/`
- Drift-репозитории в infrastructure порции и журнала
- Riverpod: DI в `lib/core/di/`, сценарии в `application/` контекстов
- тесты in-memory: запись, undo, сегодня, семь дней, настройки порции

## Не делать

Не собирать UI Projection, настройки, график, l10n, flavors, go_router. Главный экран остаётся заглушкой. Не класть провайдеры в `lib/app/providers`.
```

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
gh label create vitrine --force --description "beer-logger" --color 0E8A16
gh label create step-05 --force --description "шаг 05" --color 1D76DB
gh issue create --repo ValeriusGC/beer-logger --title "Подключить Drift и Riverpod" --label vitrine --label step-05 --body "$(cat <<'EOF'
## Зачем

Тап должен переживать перезапуск: факты в SQLite, живая порция — отдельная таблица. Экраны пока не рисуют цифры; слой приложения отдаёт потоки списка, баланса и записи.

## Сделать

- одна `AppDatabase` в `lib/core/persistence/`
- Drift-репозитории в infrastructure порции и журнала
- Riverpod: DI в `lib/core/di/`, сценарии в `application/` контекстов
- тесты in-memory: запись, undo, сегодня, семь дней, настройки порции

## Не делать

Не собирать UI Projection, настройки, график, l10n, flavors, go_router. Главный экран остаётся заглушкой. Не класть провайдеры в `lib/app/providers`.
EOF
)"
```

Модель: `gh issue create` **не** запускать. Номер после создания человек не обязан писать в чат: модель сама снимает его в §2.

## PR (человек запускает; модель подставляет цифры в сдаче, команду не запускает)

Заголовок squash-merge — то же, что title PR. **Цифры issue обязательны.** Буква `N` в title/body/`gh` — брак.

Шаблон (вместо `12` — число из `gh issue list` §2, не это двенадцать, если карточка другая):

**Title**

```
feat: подключить Drift и Riverpod (#12)
```

**Body**

```
Closes #12

Одна SQLite на оба контекста, Drift-репозитории, сценарии записи/отмены/сегодня/неделя и текущая порция через Riverpod. Главный экран без данных.
```

В сдаче напечатать **готовую** команду с уже подставленными цифрами. Не запускать.

```bash
gh pr create --repo ValeriusGC/beer-logger --base main --title "feat: подключить Drift и Riverpod (#12)" --body "$(cat <<EOF
Closes #12

Одна SQLite на оба контекста, Drift-репозитории, сценарии записи/отмены/сегодня/неделя и текущая порция через Riverpod. Главный экран без данных.
EOF
)"
```

## 1. Жёсткие запреты

- Писать **только** в `/Users/vvk/AndroidStudioProjects/r/beer-logger`. Штаб и донор не менять.
- `git commit` запрещён, пока человек не приказал в **этом** сообщении. После сдачи коммитов нет: сначала критик. `git push`, `gh pr create`, merge — запрещены всегда.
- Закоммитить или предложить subject **без** `(#` + цифры issue + `)` — запрещено. Писать в git `#N`, `#ISSUE`, пустые `(#)` — запрещено.
- `docs/steps/` не создавать до приказа «закоммить промпт и критик». Первый коммит шага — только `docs/steps/05-prompt.md` и `docs/steps/05-critic.md`.
- Нет `lib/app/providers/`, нет второй базы, нет `lib/data/`.
- Нет `go_router`, `flutter_localizations` / arb, flavors, `fl_chart`, desktop-таргетов.
- `home_page.dart` остаётся заглушкой без цифр и без `ConsumerWidget`.
- В коде витрины не оставлять `package:beer_ledger/` (пакет приложения — `beer_logger`). `package:beer_ledger_core/` — оставить.
- `dart format --output=none --set-exit-if-changed .` в корне витрины — выход 0 до сдачи.

## Сообщения коммитов (дубль, обязательно)

> [!CAUTION]
> Все `git commit` и заголовок squash-PR — **Conventional Commits**. После `feat:` / `fix:` / `docs:` / `ci:` / `chore:` сразу глагол в **инфинитиве** (сделать, сохранить, включить, подключить). Не существительное (`feat: persistence`), не прошедшее (`feat: added`), не английский глагол (`add`).
>
> **Номер GitHub issue этого шага — в КАЖДОМ коммите и в PR. Это не подсказка, это часть формата.**
>
> Первая строка каждого коммита и `--title` у PR:
> `тип: инфинитив … (#12)`
> `12` — **цифры** открытого issue с меткой `step-05`. Не буква N. Не слово ISSUE. Не пример «12», если `gh` показал другое число.
>
> Тело PR **обязано** начинаться с `Closes #12` (те же цифры). В коммитах **ветки** слово `Closes` не писать — только `(#12)` в subject.
>
> Первый коммит шага: `docs: сохранить промпт и вердикт критика шага 05 (#12)`.
>
> Squash-заголовок: `feat: подключить Drift и Riverpod (#12)`.
>
> Предложить список без `(#цифры)`, закоммитить без `(#цифры)`, напечатать `gh pr create` с `#N` — дефект шага, наравне с упавшим analyze.

Эта секция обязана быть в каждом промпте шага целиком, не «см. _COMMON».

Номер не выдумывать. Снять в §2. Нет ровно одной открытой карточки `step-05` — **стоп**. После приказа коммитить — в `-m` те же цифры.

## 2. Состояние репозитория

Шаги 01–04 влиты в `main`. Ожидаемая ветка: `step/05-persistence`. Если текущая ветка другая — **стоп**, спросить человека.

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
git rev-parse --abbrev-ref HEAD
test -f lib/bounded_contexts/journal/domain/click/click.dart
test -f lib/bounded_contexts/journal/application/axis_record_inputs.dart
test ! -f lib/core/persistence/app_database.dart
test ! -f lib/bounded_contexts/journal/infrastructure/drift_click_repository.dart
grep -q flutter_riverpod pubspec.yaml && echo FAIL_ALREADY_RIVERPOD || echo OK_NO_RIVERPOD
gh issue list --repo ValeriusGC/beer-logger --label step-05 --state open --json number,title
```

Вывод `gh issue list`: **ровно одна** открытая карточка. Её `number` — единственный номер для коммитов и PR. Иначе — **стоп**. В первом ответе: `Issue шага: #…`.

## 3. Цель

После шага факты пишутся в SQLite и читаются потоками Riverpod. Одна база на оба контекста. Главный экран **не** показывает баланс — это шаг 06. Отвергнуто: две SQLite или SharedPreferences рядом. Отвергнуто: провайдеры в `lib/app/providers` — сценарии живут в `application/` своего контекста.

## 4. Зависимости приложения

Корневой `pubspec.yaml` — **добавить** к уже существующим, не копировать pubspec донора:

`dependencies`:

- `drift: ^2.34.3`
- `drift_flutter: ^0.3.1`
- `flutter_riverpod: ^3.3.2`
- `riverpod_annotation: ^4.0.3`
- `uuid: ^4.6.0`
- `path_provider: ^2.1.6`

`dev_dependencies`:

- `drift_dev: ^2.34.5`
- `riverpod_generator: ^4.0.4`
- `sqlite3: ^3.5.1`

Уже есть: `fpdart`, `freezed_annotation`, `build_runner`, `freezed`, `flutter_test`, `flutter_lints`. **Не** добавлять `go_router`, `fl_chart`, `intl` как прямую зависимость, `flutter_localizations`.

Если `build_runner` конфликтует с `drift_dev` — стоп, текст ошибки человеку, не выдумывать override молча.

В `analysis_options.yaml` приложения в `analyzer.exclude` добавить `**/*.g.dart`. Плагин `riverpod_lint` **не** подключать.

## 5. Копирование из донора (только эти файлы)

Корень донора: `/Users/vvk/AndroidStudioProjects/r/beer_ledger/`

Корень цели: `/Users/vvk/AndroidStudioProjects/r/beer-logger/`

Скопируй логику, затем §6. `*.g.dart` и `*.cg.g.dart` **не** копировать — сгенерировать.

| Источник | Цель |
|----------|------|
| `lib/core/persistence/app_database.dart` | то же, затем правки §6 |
| `lib/core/di/app_database.cg.dart` | то же |
| `lib/core/di/now.cg.dart` | то же |
| `lib/core/di/click_repository.cg.dart` | то же |
| `lib/core/di/clicker_settings_repository.cg.dart` | то же |
| `lib/bounded_contexts/journal/infrastructure/click_mapper.dart` | то же |
| `lib/bounded_contexts/journal/infrastructure/day_boundaries.dart` | то же |
| `lib/bounded_contexts/journal/infrastructure/ledger_axis_kind_wire.dart` | то же |
| `lib/bounded_contexts/journal/infrastructure/drift_click_repository.dart` | то же |
| `lib/bounded_contexts/portion/infrastructure/clicker_settings_mapper.dart` | то же |
| `lib/bounded_contexts/portion/infrastructure/drift_clicker_settings_repository.dart` | то же |
| `lib/bounded_contexts/journal/application/clicks_for_today.cg.dart` | то же |
| `lib/bounded_contexts/journal/application/record_click.cg.dart` | то же |
| `lib/bounded_contexts/journal/application/today_balance.cg.dart` | то же |
| `lib/bounded_contexts/journal/application/undo_last_click.cg.dart` | то же |
| `lib/bounded_contexts/journal/application/volume_for_last_7_days.cg.dart` | то же |
| `lib/bounded_contexts/portion/application/current_clicker.cg.dart` | то же |
| `test/bounded_contexts/journal/infrastructure/click_mapper_test.dart` | то же |
| `test/bounded_contexts/journal/infrastructure/drift_click_repository_test.dart` | то же |
| `test/bounded_contexts/journal/application/clicks_for_today_test.dart` | то же |
| `test/bounded_contexts/journal/application/record_click_test.dart` | то же |
| `test/bounded_contexts/journal/application/today_balance_test.dart` | то же |
| `test/bounded_contexts/journal/application/undo_last_click_test.dart` | то же |
| `test/bounded_contexts/journal/application/volume_for_last_7_days_test.dart` | то же |
| `test/core/persistence/app_database_test.dart` | то же, затем правки §6 |
| `test/bounded_contexts/portion/infrastructure/drift_clicker_settings_repository_test.dart` | то же, затем правки §6 |

`axis_record_inputs.dart` уже есть — не дублировать.

Не копировать `test/bounded_contexts/*/presentation/**`. Не копировать `portion_input.dart`.

Удалить `.gitkeep` в каталогах, куда легли файлы (`lib/core`, `infrastructure` обоих контекстов, `portion/application`).

## 6. Правки после копирования (обязательно)

### Импорты

Во всех новых `lib/` и `test/`: `package:beer_ledger/` → `package:beer_logger/`.

`package:beer_ledger_core/` не трогать.

Проверка: `grep -R 'package:beer_ledger/' lib test` — пусто (кроме `beer_ledger_core`).

### `AppDatabase` — не слепое копирование схемы «как у живого донора»

У витрины нет пользователей со schema 1. После копирования:

- `driftDatabase(name: 'beer_logger', …)` — не `beer_ledger`;
- `schemaVersion => 1`;
- `onCreate`: `createAll` + `ensurePresetClickerSettings`;
- **нет** ветки `onUpgrade` / `from < 2`. Три таблицы создаются сразу.

Конструкторы `AppDatabase()` (файл) и `AppDatabase.inMemory()` оставить.

### Тест `app_database_test.dart`

Не копировать тест про `user_version 1` / `onUpgrade`. Оставить (адаптировать) проверку seed пресета: `schemaVersion` равен **1**, строка `clickerSettings` = пресет «Пиво 0.5 L».

### Тест `drift_clicker_settings_repository_test.dart`

У донора он тянет `PortionField` / `portionEntered` / `clickerWithPortion` из UI настроек. Этих символов в витрине **нет**. Переписать проверки через `LedgerAxis.enteredValue` и `copyWith` по `LedgerAxisKind`. Файл `portion_input.dart` не создавать.

### Баррели

`portion.dart` — к уже существующим domain-экспортам добавить `application/current_clicker.cg.dart`. UI настроек не экспортировать.

`journal.dart` — к domain + `axis_record_inputs` добавить:

- `application/clicks_for_today.cg.dart`
- `application/record_click.cg.dart`
- `application/today_balance.cg.dart`
- `application/undo_last_click.cg.dart`
- `application/volume_for_last_7_days.cg.dart`

`home_page.dart` в баррель **не** класть.

### `BeerLoggerApp` и `main`

`ProviderScope` — внутри `BeerLoggerApp`, вокруг существующего `MaterialApp` с заглушкой home. `main.dart` по-прежнему `runApp(const BeerLoggerApp())`. Не копировать router, flavor, l10n, `MaterialApp.router`.

Smoke `test/widget_test.dart` должен остаться зелёным без правок логики (заголовок «Пивомер»). Если без `ProviderScope` в `BeerLoggerApp` он падает — обернуть здесь, не в тесте, и не подставлять in-memory БД в smoke: заглушка базу не открывает.

### DartDoc

Убрать `ADR 001`/`003`, имя репозитория-лаборатории, номера PR донора. Смысл: факт в базовой единице, undo глобальный по `(at DESC, id DESC)`, `now` кэшируется и для записи освежается `ref.refresh`.

### Codegen

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
dart pub get
dart run build_runner build --delete-conflicting-outputs
```

Должны появиться `app_database.g.dart` и `*.cg.g.dart`. Руками не править. В git их кладут.

## 7. Документы приложения

### `docs/architecture.md`

Не стирать домен шага 04. Поднять версию, время шапки — `date '+%Y-%m-%d %H:%M:%S %z'`.

Обязательно:

1. Одна `AppDatabase` в `lib/core/persistence/` на оба контекста. Отвергнуто: две базы или SharedPreferences рядом.
2. Реализации — `infrastructure/` своего контекста. Контракты остаются в папке агрегата.
3. Riverpod: DI (`appDatabase`, репозитории, `now`) в `lib/core/di/`; сценарии — в `application/` порции и журнала. Отвергнуто: `lib/app/providers`.
4. Запись тапа берёт текущую порцию из потока настроек, не зашитый пресет; `Click.record` по-прежнему без `Clicker`.
5. Главная — заглушка до шага 06. Карточка/график не появляются.
6. Дерево `lib/` — с `core/persistence`, `core/di`, infrastructure, application-сценариями.

Без TODO, без путей штаба, без имени соседнего репозитория-лаборатории.

### `AGENTS.md`

Факт: Drift + Riverpod 3 подключены; l10n / go_router / fl_chart — нет.

## 8. Не трогать

- `packages/beer_ledger_core/**`
- `.cursor/`, `.github/workflows/`
- `home_page.dart` смысл заглушки
- `docs/steps/` до приказа после критика
- донор и штаб

## 9. Приёмка (прогнать самому, вставить полный вывод)

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
git rev-parse --abbrev-ref HEAD
dart format .
dart format --output=none --set-exit-if-changed .
flutter pub get
flutter analyze --fatal-warnings
flutter test
( cd packages/beer_ledger_core && dart analyze --fatal-warnings && dart test )
test -f lib/core/persistence/app_database.dart
test -f lib/core/persistence/app_database.g.dart
test -f lib/core/di/app_database.cg.dart
test -f lib/bounded_contexts/journal/infrastructure/drift_click_repository.dart
test -f lib/bounded_contexts/portion/infrastructure/drift_clicker_settings_repository.dart
test -f lib/bounded_contexts/journal/application/record_click.cg.dart
test -f lib/bounded_contexts/portion/application/current_clicker.cg.dart
test ! -d lib/app/providers
test ! -d lib/data
test ! -d docs/steps
grep -R 'package:beer_ledger/' lib test && echo FAIL_OLD_PACKAGE || echo OK_PACKAGE
grep -n "go_router" pubspec.yaml && echo FAIL_ROUTER || echo OK_NO_ROUTER
grep -n "fl_chart" pubspec.yaml && echo FAIL_CHART || echo OK_NO_CHART
grep -n "ConsumerWidget\|Consumer " lib/bounded_contexts/journal/presentation/home_page.dart && echo FAIL_HOME_DATA || echo OK_HOME_STUB
```

Любая `test` с ненулевым кодом — шаг не сдан. `flutter test` — все тесты зелёные, включая persistence и application. Analyze с warning — не сдан.

В `app_database.dart`: `schemaVersion` равен 1, имя файла БД содержит `beer_logger`.

## 10. Сдача человеку

1. Список созданных/изменённых путей относительно `beer-logger`.
2. Полный вывод §9.
3. Строка `Issue шага: #<цифры>` (из §2). Затем сообщения коммитов **кода**. **Каждая** строка с `(#`те же цифры`)`. Например, если issue = 12:
   - `feat: добавить AppDatabase и Drift-репозитории (#12)`
   - `feat: подключить сценарии журнала и порции на Riverpod (#12)`
   - `test: покрыть запись, undo, сегодня и настройки порции (#12)`
   - `docs: описать persistence в architecture (#12)`
   Если `gh` дал не 12 — писать то число.
4. Готовая команда `gh pr create` из секции PR **уже с этими цифрами**. Команду не запускать.
5. Ровно: `Жду критика. Push не делаю. Коммитов нет.`

Не предлагай merge. Не пиши `docs/steps/`. Не коммить.
