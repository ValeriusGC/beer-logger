# Шаг 06 — главный экран по UI Projection

**Дата создания:** 2026-09-26 19:37:35 +0300  
**Последнее обновление:** 2026-09-26 19:37:35 +0300  
**Версия:** 1  
**Вид документа:** инструкция

> [!IMPORTANT]
> В чат кладётся **только этот файл**. Остальное исполнитель открывает сам по абсолютным путям ниже. Человек не вкладывает `_COMMON.md`, `rules.md` и `_CRITIC.md`.
>
> **Модель шага — Composer 2.5** (или слабее автора промпта). Workspace Cursor: `/Users/vvk/AndroidStudioProjects/r/beer-logger`.
>
> Первой фразой ответа назови модель. Не совпало — остановись и попроси переключить; файлы не трогай.
>
> **Первый `git commit` этой ветки — только** `docs/steps/06-prompt.md` и `docs/steps/06-critic.md`. Код — следующим коммитом. `git add .` запрещён.

## 0. Прочитать до любой правки (обязательно, по порядку)

Открой каждый файл целиком инструментом чтения. Не угадывай содержимое.

1. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/prompts/_COMMON.md`
2. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/rules.md`
3. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/.cursor/rules/quality-bar.mdc`
4. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/.cursor/rules/doc-header-metadata.mdc`
5. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/plan.md` — этот шаг = `step/06-ui`, сквош `feat: собрать главный экран по UI Projection (#‹цифры issue›)`
6. `/Users/vvk/AndroidStudioProjects/r/beer_ledger/docs/project-structure.md` — смысл: главная в `journal/presentation/home/`, настройки в `portion/presentation/`, карточка и график не третий контекст.
7. `/Users/vvk/AndroidStudioProjects/r/beer-logger/docs/architecture.md`
8. `/Users/vvk/AndroidStudioProjects/r/beer-logger/pubspec.yaml`
9. `/Users/vvk/AndroidStudioProjects/r/beer-logger/AGENTS.md`
10. `/Users/vvk/AndroidStudioProjects/r/beer-logger/lib/app/app.dart`, `lib/main.dart`, заглушка `lib/bounded_contexts/journal/presentation/home_page.dart`

Затем **прочитай все исходники из таблицы §5** в доноре.

Не открывать `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/prompts/_CRITIC.md`.

Не открывать `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/operator.md`.

Не копировать: `lib/app/flavor.dart`, `default-flavor`, desktop-таргеты, workflow APK, ADR, `.github` донора, `*.g.dart`, `*.cg.g.dart`, `*.freezed.dart`.

`_COMMON` §6 YAGNI запрещает l10n / go_router / fl_chart / экраны **на чужих шагах**. Этот шаг их подключает. Flavors по-прежнему нельзя.

## Issue (человек, до чата; модель не создаёт)

Title и body ниже уходят на GitHub **как есть**. Только язык задачи в репозитории.

**Title**

```
Собрать главный экран
```

**Body**

```
## Зачем

Тап должен быть виден: баланс за день, список с отменой, объём за семь дней, живая порция в настройках. Виджет не складывает миллилитры сам — на главной цепочка Factory → Projection → Builder → UiModel.

## Сделать

- главная: карточка, кнопка тапа, журнал, undo, график 7 дней
- настройки порции (четыре числа)
- RU и EN
- смена ккал в настройках не переписывает уже записанные тапы

## Не делать

Не вводить flavors, второй сорт, периоды месяц/год, облако. График не переписывать под Factory: он уже рисует готовые литры.
```

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
gh label create vitrine --force --description "beer-logger" --color 0E8A16
gh label create step-06 --force --description "шаг 06" --color 1D76DB
gh issue create --repo ValeriusGC/beer-logger --title "Собрать главный экран" --label vitrine --label step-06 --body "$(cat <<'EOF'
## Зачем

Тап должен быть виден: баланс за день, список с отменой, объём за семь дней, живая порция в настройках. Виджет не складывает миллилитры сам — на главной цепочка Factory → Projection → Builder → UiModel.

## Сделать

- главная: карточка, кнопка тапа, журнал, undo, график 7 дней
- настройки порции (четыре числа)
- RU и EN
- смена ккал в настройках не переписывает уже записанные тапы

## Не делать

Не вводить flavors, второй сорт, периоды месяц/год, облако. График не переписывать под Factory: он уже рисует готовые литры.
EOF
)"
```

Модель: `gh issue create` **не** запускать. Номер после создания человек не обязан писать в чат: модель сама снимает его в §2.

## PR (человек запускает; модель подставляет цифры в сдаче, команду не запускает)

Заголовок squash-merge — то же, что title PR. **Цифры issue обязательны.** Буква `N` в title/body/`gh` — брак.

Шаблон (вместо `12` — число из `gh issue list` §2, не это двенадцать, если карточка другая):

**Title**

```
feat: собрать главный экран по UI Projection (#12)
```

**Body**

```
Closes #12

Главная: Factory → Builder → глупые виджеты. Настройки порции, журнал с undo, график объёма за 7 дней, RU и EN. Смена живой порции уже записанные тапы не пересчитывает.
```

В сдаче напечатать **готовую** команду с уже подставленными цифрами. Не запускать.

```bash
gh pr create --repo ValeriusGC/beer-logger --base main --title "feat: собрать главный экран по UI Projection (#12)" --body "$(cat <<EOF
Closes #12

Главная: Factory → Builder → глупые виджеты. Настройки порции, журнал с undo, график объёма за 7 дней, RU и EN. Смена живой порции уже записанные тапы не пересчитывает.
EOF
)"
```

## 1. Жёсткие запреты

- Писать **только** в `/Users/vvk/AndroidStudioProjects/r/beer-logger`. Штаб и донор не менять.
- `git commit` запрещён, пока человек не приказал в **этом** сообщении. После сдачи коммитов нет: сначала критик. `git push`, `gh pr create`, merge — запрещены всегда.
- `git add .` / `git add -A` / `git add -u` — **запрещены**. В индекс только явно названные пути.
- Закоммитить или предложить subject **без** `(#` + цифры issue + `)` — запрещено. Писать в git `#N`, `#ISSUE`, пустые `(#)` — запрещено.
- `docs/steps/` не создавать до приказа «Закоммить ТОЛЬКО промпт и вердикт». **Первый** коммит шага — **только** `docs/steps/06-prompt.md` и `docs/steps/06-critic.md`. Код в этом коммите — дефект.
- Нет `lib/app/flavor.dart`, нет `default-flavor` в pubspec, нет `isDevFlavor`, нет DEV-бейджа в AppBar.
- Нет второго clicker, месяца/года, облака, flavors, desktop-таргетов, `lib/features/`, `lib/ui/screens/`, `lib/app/providers/`.
- `fromBase` / сложение осей в виджете **запрещены**. Суммы считает `todayBalance` / `aggregateForPeriod`.
- `WeekVolumeChart` **не** втягивать в Factory: файл копируется как продукт, провайдер тот же.
- Настройки **не** переписывать под UI Projection: поля и Save, без Factory.
- Ключи тестов не переименовывать: `today-balance-volume|energy|money|joy`, `today-click-<id>`, `home-balance-chart-row`, `settings-energy`.
- В коде витрины не оставлять `package:beer_ledger/` (пакет приложения — `beer_logger`). `package:beer_ledger_core/` — оставить.
- Пользовательские строки UI — из l10n, не литералы в `build` (кроме ключей `Key` и чисел в тестах).
- `dart format --output=none --set-exit-if-changed .` в корне витрины — выход 0 до сдачи.

## Сообщения коммитов (дубль, обязательно)

> [!CAUTION]
> Все `git commit` и заголовок squash-PR — **Conventional Commits**. После `feat:` / `fix:` / `docs:` / `ci:` / `chore:` сразу глагол в **инфинитиве** (сделать, сохранить, включить, собрать). Не существительное (`feat: UI`), не прошедшее (`feat: added`), не английский глагол (`add`).
>
> **Номер GitHub issue этого шага — в КАЖДОМ коммите и в PR. Это не подсказка, это часть формата.**
>
> Первая строка каждого коммита и `--title` у PR:
> `тип: инфинитив … (#12)`
> `12` — **цифры** открытого issue с меткой `step-06`. Не буква N. Не слово ISSUE. Не пример «12», если `gh` показал другое число.
>
> Тело PR **обязано** начинаться с `Closes #12` (те же цифры). В коммитах **ветки** слово `Closes` не писать — только `(#12)` в subject.
>
> Первый коммит шага (единственные файлы в индексе): `docs: сохранить промпт и вердикт критика шага 06 (#12)`.
>
> Squash-заголовок: `feat: собрать главный экран по UI Projection (#12)`.
>
> Предложить список без `(#цифры)`, закоммитить без `(#цифры)`, напечатать `gh pr create` с `#N` — дефект шага, наравне с упавшим analyze.

Эта секция обязана быть в каждом промпте шага целиком, не «см. _COMMON».

Номер не выдумывать. Снять в §2. Нет ровно одной открытой карточки `step-06` — **стоп**. После приказа коммитить — в `-m` те же цифры.

## Когда человек приказал коммитить (дубль, обязательно)

> [!CAUTION]
> **Первый `git commit` на этой ветке — ВСЕГДА и ТОЛЬКО промпт + вердикт критика.** Не код. Не `lib/`. Не `pubspec`. Не тесты. Не `docs/architecture.md`.
>
> В индексе ровно два пути:
> 1. `docs/steps/06-prompt.md`
> 2. `docs/steps/06-critic.md`
>
> `git add .` / `git add -A` / `git add -u` — запрещены. Только эти два пути: `git add docs/steps/06-prompt.md docs/steps/06-critic.md`.
>
> Перед `git commit` выполнить `git diff --cached --name-only`. Вывод — **ровно** эти две строки. Третий путь — **стоп**: `git restore --staged -- <лишнее>`, не коммитить.
>
> Пока в `git log --oneline main..HEAD` нет коммита `docs: сохранить промпт и вердикт критика шага 06`, любой приказ «закоммить», «сделай коммиты», «commit all», «закоммить всё» означает **только эти два файла**. Код не трогать.
>
> Код — отдельный **следующий** приказ человека, и только когда первый коммит уже виден в `git log -1`. В коммиты кода `docs/steps/` не класть.
>
> Закоммитить код раньше промпта+критика — дефект, наравне с упавшим analyze. Историю самой не чинить. Стоп, сказать человеку.

## 2. Состояние репозитория

Шаги 01–05 влиты в `main`. Ожидаемая ветка: `step/06-ui`. Если текущая ветка другая — **стоп**, спросить человека.

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
git rev-parse --abbrev-ref HEAD
test -f lib/core/persistence/app_database.dart
test -f lib/bounded_contexts/journal/application/record_click.cg.dart
test -f lib/bounded_contexts/journal/presentation/home_page.dart
test ! -d lib/bounded_contexts/journal/presentation/home
test ! -f lib/bounded_contexts/portion/presentation/settings_page.dart
grep -q go_router pubspec.yaml && echo FAIL_ALREADY_ROUTER || echo OK_NO_ROUTER
grep -q fl_chart pubspec.yaml && echo FAIL_ALREADY_CHART || echo OK_NO_CHART
gh issue list --repo ValeriusGC/beer-logger --label step-06 --state open --json number,title
```

Вывод `gh issue list`: **ровно одна** открытая карточка. Её `number` — единственный номер для коммитов и PR. Иначе — **стоп**. В первом ответе: `Issue шага: #…`.

Каталог `presentation/home/` с Factory уже есть — **стоп**, шаг сделан.

## 3. Цель

После шага человек на главной видит баланс дня, тапает, отменяет, смотрит столбцы за неделю, меняет порцию в настройках. Главная собрана по UI Projection: решения в Factory, строки в Builder, карточка и список — глупые. Отвергнуто: считать оси в `build`. Отвергнуто: третий контекст «витрина». Отвергнуто: flavors.

Цепочка (не MVVM рядом):

```
факты application/domain
        → Factory (пустой день? кнопка активна?)
        → Projection (данные без строк UI)
        → Builder (l10n + formatToday*)
        → UiModel (готовые строки)
        → dumb Widget (рисует UiModel, зовёт callback)
```

`HomePage` оркестрирует: `watch(homeProjectionProvider)`, Builder, `ref.listen` записи/undo, layout `>= 600`. `HomeController` — только `record` / `undo`. Навигация в настройки — `context.push('/settings')`, не Factory.

Ширина окна — layout в `HomePage` через `MediaQuery`, не учёт.

## 4. Зависимости приложения

Корневой `pubspec.yaml` — **добавить** к уже существующим, не копировать pubspec донора:

`dependencies`:

- `go_router: ^18.0.1`
- `fl_chart: ^1.2.0`
- `flutter_localizations:` (sdk: flutter)
- `intl: any`

В блоке `flutter:` добавить `generate: true`. **Не** добавлять `default-flavor`.

Уже есть: Drift, Riverpod, uuid, path_provider, fpdart, freezed. **Не** добавлять flavor-плагины.

Если `pub get` конфликтует — стоп, текст ошибки человеку, не выдумывать override молча.

## 5. Копирование из донора (только эти файлы)

Корень донора: `/Users/vvk/AndroidStudioProjects/r/beer_ledger/`

Корень цели: `/Users/vvk/AndroidStudioProjects/r/beer-logger/`

Скопируй логику, затем §6. `*.g.dart`, `*.cg.g.dart`, `*.freezed.dart` **не** копировать — сгенерировать. Сгенерированные `lib/l10n/app_localizations*.dart` — после правки arb (§6), командой `flutter gen-l10n` (или `flutter pub get` при `generate: true`). Руками не писать.

| Источник | Цель |
|----------|------|
| `l10n.yaml` | то же в корне |
| `lib/l10n/app_en.arb` | то же, затем правки §6 |
| `lib/l10n/app_ru.arb` | то же, затем правки §6 |
| `lib/app/router.dart` | то же, затем правки §6 |
| `lib/bounded_contexts/journal/presentation/home/home_controller.cg.dart` | то же |
| `lib/bounded_contexts/journal/presentation/home/home_page.dart` | то же, затем правки §6 |
| `lib/bounded_contexts/journal/presentation/home/home_projection.cg.dart` | то же |
| `lib/bounded_contexts/journal/presentation/home/home_projection.dart` | то же |
| `lib/bounded_contexts/journal/presentation/home/home_projection_factory.dart` | то же |
| `lib/bounded_contexts/journal/presentation/home/home_ui_model.dart` | то же |
| `lib/bounded_contexts/journal/presentation/home/home_ui_model_builder.dart` | то же |
| `lib/bounded_contexts/journal/presentation/today_balance_card.dart` | то же |
| `lib/bounded_contexts/journal/presentation/today_balance_format.dart` | то же |
| `lib/bounded_contexts/journal/presentation/today_clicks_format.dart` | то же |
| `lib/bounded_contexts/journal/presentation/today_clicks_section.dart` | то же |
| `lib/bounded_contexts/journal/presentation/week_volume_chart.dart` | то же |
| `lib/bounded_contexts/portion/presentation/portion_input.dart` | то же |
| `lib/bounded_contexts/portion/presentation/settings_page.dart` | то же |
| `test/bounded_contexts/journal/presentation/home/home_projection_factory_test.dart` | то же |
| `test/bounded_contexts/journal/presentation/home_breakpoints_test.dart` | то же |
| `test/bounded_contexts/journal/presentation/record_beer_tap_button_test.dart` | то же |
| `test/bounded_contexts/journal/presentation/today_balance_card_test.dart` | то же |
| `test/bounded_contexts/journal/presentation/today_clicks_section_test.dart` | то же |
| `test/bounded_contexts/journal/presentation/week_volume_chart_test.dart` | то же |
| `test/bounded_contexts/portion/presentation/portion_input_test.dart` | то же |
| `test/bounded_contexts/portion/presentation/settings_page_test.dart` | то же |

Не копировать `lib/app/flavor.dart`, `lib/main.dart` донора, `lib/app/` целиком (в витрине оболочка — `lib/app/app.dart`).

Удалить заглушку `lib/bounded_contexts/journal/presentation/home_page.dart`. Удалить `.gitkeep` в `portion/presentation/`.

## 6. Правки после копирования (обязательно)

### Импорты

Во всех новых `lib/` и `test/`: `package:beer_ledger/` → `package:beer_logger/`.

`package:beer_ledger_core/` не трогать.

Проверка: `grep -R 'package:beer_ledger/' lib test` — пусто (кроме `beer_ledger_core`).

### Flavors — вырезать, не «оставить на потом»

- `home_page.dart`: удалить `import` `flavor.dart` и весь блок `if (isDevFlavor)` с бейджем. Иконка настроек остаётся.
- `router.dart`: `beerLedgerRoutes` / `beerLedgerRouter` → `beerLoggerRoutes` / `beerLoggerRouter`. Импорты баррелей — `package:beer_logger/...`.
- Не создавать `flavor.dart`.

### l10n

После копирования arb:

- en `appTitle`: `Pivomer` (не `Beer Ledger`);
- ru `appTitle`: `Пивомер` (уже так);
- удалить ключи `devBadge` и `@devBadge` из обоих arb.

Затем `flutter gen-l10n`. Сгенерированные `app_localizations*.dart` кладут в git.

### `BeerLoggerApp` и `main`

`ProviderScope` остаётся **внутри** `BeerLoggerApp` (как после шага 05), вокруг `MaterialApp.router`:

- `onGenerateTitle` → `AppLocalizations.of(context).appTitle`;
- `localizationsDelegates` / `supportedLocales` — из `AppLocalizations`;
- `routerConfig: beerLoggerRouter`;
- `theme` — Material 3, `ColorScheme.fromSeed(seedColor: Colors.amber)` как у донора;
- **нет** `debugShowCheckedModeBanner: isDevFlavor`.

`main.dart` по-прежнему `runApp(const BeerLoggerApp())`. Не копировать `main` донора: там `ProviderScope` снаружи и flavor.

### Баррели

`journal.dart` — добавить экспорты presentation:

- `presentation/home/home_page.dart`
- `presentation/home/home_ui_model.dart`
- `presentation/today_balance_card.dart`
- `presentation/today_balance_format.dart`
- `presentation/today_clicks_format.dart`
- `presentation/today_clicks_section.dart`
- `presentation/week_volume_chart.dart`

`axis_record_inputs.dart` и application-сценарии **оставить**.

`portion.dart` — добавить:

- `presentation/portion_input.dart`
- `presentation/settings_page.dart`

### `test/widget_test.dart`

Качать `BeerLoggerApp` **запрещено**: главная откроет SQLite без overrides. Заменить smoke на короткий тест как `home_breakpoints_test`: `ProviderScope` + overrides application-провайдеров + `MaterialApp` с l10n + `HomePage`. Проверить, что на `locale: Locale('en')` видна кнопка `Beer 0.5` (подпись из l10n). Не искать заглушку «Каркас приложения».

### DartDoc

Убрать ADR, имя репозитория-лаборатории, номера PR донора. Смысл: виджет не считает оси; график не в Factory.

### Codegen

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
dart pub get
flutter gen-l10n
dart run build_runner build --delete-conflicting-outputs
```

Должны появиться `home_projection.freezed.dart`, `home_projection.cg.g.dart`, `home_controller.cg.g.dart`, `lib/l10n/app_localizations*.dart`. Руками не править. В git их кладут.

## 7. Документы приложения

### `docs/architecture.md`

Не стирать persistence шага 05. Поднять версию, время шапки — `date '+%Y-%m-%d %H:%M:%S %z'`.

Обязательно:

1. Главная — UI Projection в `journal/presentation/home/`. Отвергнуто: считать оси в виджете; третий контекст «витрина».
2. `TodayBalanceCard` и `TodayClicksSection` получают UiModel конструктором. `WeekVolumeChart` смотрит провайдер сам — в Factory не входит.
3. Настройки — `portion/presentation/`, без Factory.
4. Два маршрута: `/` и `/settings`. Flavors нет.
5. Смена живой порции уже записанный тап не пересчитывает (вклад в базовой единице).
6. Дерево `lib/`: `app/router.dart`, `l10n/`, `journal/presentation/home/`, `portion/presentation/settings_page.dart`. Старого `presentation/home_page.dart` нет.
7. Таблицу «Следующие шаги» с пунктом 06 — убрать (этот шаг закрывает UI v1).

Без TODO, без путей штаба, без имени соседнего репозитория-лаборатории.

### `README.md`

Шапку поднять. Абзац про trade-off **оставить** (смена настроек не переписывает вчерашние тапы). Добавить, что на главной: тап, баланс дня, список с undo, график 7 дней; настройки порции; UI на русском и английском.

### `AGENTS.md`

Факт: go_router, gen-l10n RU+EN, fl_chart подключены; flavors нет. Главная — UI Projection.

### Реестры

`docs/registries/widgets.md` — `HomePage` (новый путь), карточка, список, график, `SettingsPage`. Строку про заглушку `home_page.dart` убрать.

`docs/registries/formatters.md` — `formatTodayBalanceLines`, `formatTodayClickTime` / volume, `formatPortionInput`.

`docs/registries/providers_and_services.md` — `homeProjectionProvider`, `homeControllerProvider`. Если application-провайдеры шага 05 в таблице всё ещё «—» — дописать существующие, не выдумывать новые.

## 8. Не трогать

- `packages/beer_ledger_core/**`
- `.cursor/`, `.github/workflows/`
- `lib/core/persistence/**` (схема)
- `docs/steps/` до приказа после критика
- донор и штаб

## 9. Приёмка (прогнать самому, вставить полный вывод)

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
git rev-parse --abbrev-ref HEAD
dart format .
dart format --output=none --set-exit-if-changed .
flutter pub get
flutter gen-l10n
flutter analyze --fatal-warnings
flutter test
( cd packages/beer_ledger_core && dart analyze --fatal-warnings && dart test )
test -f lib/bounded_contexts/journal/presentation/home/home_projection_factory.dart
test -f lib/bounded_contexts/journal/presentation/home/home_page.dart
test ! -f lib/bounded_contexts/journal/presentation/home_page.dart
test -f lib/bounded_contexts/portion/presentation/settings_page.dart
test -f lib/app/router.dart
test ! -f lib/app/flavor.dart
test -f lib/l10n/app_ru.arb
test -f lib/l10n/app_en.arb
test -f lib/l10n/app_localizations.dart
test ! -d docs/steps
grep -n "default-flavor" pubspec.yaml && echo FAIL_FLAVOR || echo OK_NO_FLAVOR
grep -R "isDevFlavor" lib && echo FAIL_FLAVOR_CODE || echo OK_NO_DEV_BADGE
grep -R 'package:beer_ledger/' lib test && echo FAIL_OLD_PACKAGE || echo OK_PACKAGE
grep -n "go_router" pubspec.yaml && echo OK_ROUTER || echo FAIL_NO_ROUTER
grep -n "fl_chart" pubspec.yaml && echo OK_CHART || echo FAIL_NO_CHART
grep -n "ConsumerWidget" lib/bounded_contexts/journal/presentation/today_balance_card.dart && echo FAIL_SMART_CARD || echo OK_DUMB_CARD
grep -n "ConsumerWidget" lib/bounded_contexts/journal/presentation/today_clicks_section.dart && echo FAIL_SMART_LIST || echo OK_DUMB_LIST
```

Любая `test` с ненулевым кодом — шаг не сдан. `flutter test` — все тесты зелёные, включая presentation. Analyze с warning — не сдан.

В arb en нет строки `Beer Ledger`. В `home_page.dart` нет `flavor`.

## 10. Сдача человеку

1. Список созданных/изменённых путей относительно `beer-logger`.
2. Полный вывод §9.
3. Строка `Issue шага: #<цифры>` (из §2). Затем сообщения коммитов **кода** (это второй коммит, не первый). **Каждая** строка с `(#`те же цифры`)`. Например, если issue = 12:
   - `feat: собрать главную по UI Projection (#12)`
   - `feat: добавить настройки порции и график недели (#12)`
   - `feat: подключить l10n RU и EN (#12)`
   - `test: покрыть карточку, журнал, график и настройки (#12)`
   - `docs: описать UI Projection в architecture (#12)`
   Если `gh` дал не 12 — писать то число.
4. Готовая команда `gh pr create` из секции PR **уже с этими цифрами**. Команду не запускать.
5. Ровно: `Жду критика. Push не делаю. Коммитов нет. Первый коммит потом — только docs/steps.`

Не предлагай merge. Не пиши `docs/steps/`. Не коммить.
