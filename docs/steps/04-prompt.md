# Шаг 04 — домен порции и журнала

**Дата создания:** 2026-09-26 15:20:49 +0300  
**Последнее обновление:** 2026-09-26 15:20:49 +0300  
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
5. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/plan.md` — этот шаг = `step/04-domain`, сквош `feat: ввести домен порции и журнала (#‹цифры issue›)`
6. `/Users/vvk/AndroidStudioProjects/r/beer_ledger/docs/project-structure.md` — **смысл** дерева агрегатов. Код приложения донора копировать **только** из таблицы §5.
7. `/Users/vvk/AndroidStudioProjects/r/beer-logger/docs/architecture.md`
8. `/Users/vvk/AndroidStudioProjects/r/beer-logger/pubspec.yaml`
9. `/Users/vvk/AndroidStudioProjects/r/beer-logger/AGENTS.md`
10. `/Users/vvk/AndroidStudioProjects/r/beer-logger/lib/bounded_contexts/portion/portion.dart` и `.../journal/journal.dart`

Затем **прочитай все исходники из таблицы §5** в доноре.

Не открывать `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/prompts/_CRITIC.md`.

Не открывать `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/operator.md`.

Не копировать: `infrastructure/`, `presentation/` кроме уже существующей заглушки home, `*.cg.dart`, `*.g.dart`, Drift, Riverpod, l10n, ADR, `.github` донора.

## Issue (человек, до чата; модель не создаёт)

Title и body ниже уходят на GitHub **как есть**. Только язык задачи в репозитории.

**Title**

```
Ввести домен порции и журнала
```

**Body**

```
## Зачем

Порция отвечает на «что будет при нажатии сейчас», журнал — на «что уже случилось». Смена ккал в настройках не должна переписывать уже записанный тап: вклад замораживается в момент записи.

## Сделать

- агрегат кликера в `portion/domain/clicker/` (пресет «Пиво 0.5 L»)
- агрегат тапа в `journal/domain/click/`: `Click.record` принимает оси журнала, не кликер
- мост `axisRecordInputsFrom` в `journal/application/`
- контракты репозиториев без реализаций
- тесты: запись, разморозка вклада при смене порции, агрегация за период, parse id

## Не делать

Не подключать Drift, Riverpod, экраны учёта, настройки, график. Не класть `Click`/`Clicker` в `beer_ledger_core`. Главный экран остаётся заглушкой.
```

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
gh label create vitrine --force --description "beer-logger" --color 0E8A16
gh label create step-04 --force --description "шаг 04" --color 1D76DB
gh issue create --repo ValeriusGC/beer-logger --title "Ввести домен порции и журнала" --label vitrine --label step-04 --body "$(cat <<'EOF'
## Зачем

Порция отвечает на «что будет при нажатии сейчас», журнал — на «что уже случилось». Смена ккал в настройках не должна переписывать уже записанный тап: вклад замораживается в момент записи.

## Сделать

- агрегат кликера в `portion/domain/clicker/` (пресет «Пиво 0.5 L»)
- агрегат тапа в `journal/domain/click/`: `Click.record` принимает оси журнала, не кликер
- мост `axisRecordInputsFrom` в `journal/application/`
- контракты репозиториев без реализаций
- тесты: запись, разморозка вклада при смене порции, агрегация за период, parse id

## Не делать

Не подключать Drift, Riverpod, экраны учёта, настройки, график. Не класть `Click`/`Clicker` в `beer_ledger_core`. Главный экран остаётся заглушкой.
EOF
)"
```

Модель: `gh issue create` **не** запускать. Номер после создания человек не обязан писать в чат: модель сама снимает его в §2.

## PR (человек запускает; модель подставляет цифры в сдаче, команду не запускает)

Заголовок squash-merge — то же, что title PR. **Цифры issue обязательны.** Буква `N` в title/body/`gh` — брак.

Шаблон (вместо `12` — число из `gh issue list` §2, не это двенадцать, если карточка другая):

**Title**

```
feat: ввести домен порции и журнала (#12)
```

**Body**

```
Closes #12

Агрегаты Clicker и Click, Click.record без Clicker, мост осей в application журнала, контракты репозиториев, тесты заморозки вклада.
```

В сдаче напечатать **готовую** команду с уже подставленными цифрами. Не запускать.

```bash
gh pr create --repo ValeriusGC/beer-logger --base main --title "feat: ввести домен порции и журнала (#12)" --body "$(cat <<EOF
Closes #12

Агрегаты Clicker и Click, Click.record без Clicker, мост осей в application журнала, контракты репозиториев, тесты заморозки вклада.
EOF
)"
```

## 1. Жёсткие запреты

- Писать **только** в `/Users/vvk/AndroidStudioProjects/r/beer-logger`. Штаб и донор не менять.
- `git commit` запрещён, пока человек не приказал в **этом** сообщении. После сдачи коммитов нет: сначала критик. `git push`, `gh pr create`, merge — запрещены всегда.
- Закоммитить или предложить subject **без** `(#` + цифры issue + `)` — запрещено. Писать в git `#N`, `#ISSUE`, пустые `(#)` — запрещено.
- `docs/steps/` не создавать до приказа «закоммить промпт и критик». Первый коммит шага — только `docs/steps/04-prompt.md` и `docs/steps/04-critic.md`.
- `Click.record` **не** принимает тип `Clicker`. В `journal/domain/` нет `import` файла `clicker.dart` (только `clicker_id.dart` — ссылка на чужой агрегат).
- Не добавлять Drift, sqlite, riverpod, go_router, l10n, flavors, desktop, экраны тапа/настроек/графика.
- Не класть `Click`/`Clicker` в `packages/beer_ledger_core`.
- Не создавать `docs/decisions/`.
- В коде витрины не оставлять `package:beer_ledger/` (имя пакета приложения — `beer_logger`). `package:beer_ledger_core/` — оставить.
- `dart format --output=none --set-exit-if-changed .` в корне витрины — выход 0 до сдачи.

## Сообщения коммитов (дубль, обязательно)

> [!CAUTION]
> Все `git commit` и заголовок squash-PR — **Conventional Commits**. После `feat:` / `fix:` / `docs:` / `ci:` / `chore:` сразу глагол в **инфинитиве** (сделать, сохранить, включить, ввести). Не существительное (`feat: домен`), не прошедшее (`feat: added`), не английский глагол (`add`).
>
> **Номер GitHub issue этого шага — в КАЖДОМ коммите и в PR. Это не подсказка, это часть формата.**
>
> Первая строка каждого коммита и `--title` у PR:
> `тип: инфинитив … (#12)`
> `12` — **цифры** открытого issue с меткой `step-04`. Не буква N. Не слово ISSUE. Не пример «12», если `gh` показал другое число.
>
> Тело PR **обязано** начинаться с `Closes #12` (те же цифры). В коммитах **ветки** слово `Closes` не писать — только `(#12)` в subject (иначе GitHub закроет issue на первом коммите).
>
> Первый коммит шага: `docs: сохранить промпт и вердикт критика шага 04 (#12)`.
>
> Squash-заголовок: `feat: ввести домен порции и журнала (#12)`.
>
> Предложить список без `(#цифры)`, закоммитить без `(#цифры)`, напечатать `gh pr create` с `#N` — дефект шага, наравне с упавшим analyze.

Эта секция обязана быть в каждом промпте шага целиком, не «см. _COMMON».

Номер не выдумывать и не оставлять на человека. Снять в §2. Нет ровно одной открытой карточки `step-04` — **стоп**, спросить. После приказа коммитить — снова проверить, что в `-m` есть те же цифры.

## 2. Состояние репозитория

Шаги 01–03 влиты в `main`. Ожидаемая ветка: `step/04-domain`. Если текущая ветка другая — **стоп**, спросить человека.

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
git rev-parse --abbrev-ref HEAD
test -f packages/beer_ledger_core/lib/measure/measure.dart
test -f packages/beer_ledger_core/lib/failure/failure.freezed.dart
test ! -d lib/bounded_contexts/portion/domain/clicker
test ! -d lib/bounded_contexts/journal/domain/click
gh issue list --repo ValeriusGC/beer-logger --label step-04 --state open --json number,title
```

Вывод `gh issue list`: **ровно одна** открытая карточка. Её `number` — единственный номер, который дальше попадает в коммиты и PR. Ноль карточек, две и больше, или пустой `number` — **стоп**, спросить человека. Цифры назвать в первом ответе: `Issue шага: #…`.

## 3. Цель

После шага в `lib/bounded_contexts/` видны два агрегата. `Click.record` замораживает вклады в базовых единицах по списку `AxisRecordInput`. Живой `Clicker` в домен журнала не входит: перевод осей — `axisRecordInputsFrom` в application журнала. Экран — по-прежнему заглушка «Пивомер». Persistence — следующий шаг.

Отвергнуто: `Click.record(Clicker)` — журнал заговорил бы языком порции. Отвергнуто: класть агрегаты в `beer_ledger_core`.

## 4. Зависимости приложения

Корневой `/Users/vvk/AndroidStudioProjects/r/beer-logger/pubspec.yaml` — **добавить**, не копировать pubspec донора:

- `dependencies`: `fpdart: ^1.2.0`, `freezed_annotation: ^3.1.0` (плюс уже существующие flutter / beer_ledger_core / cupertino_icons);
- `dev_dependencies`: `build_runner: ^2.13.0`, `freezed: ^3.2.5` (плюс уже существующие flutter_test / flutter_lints);
- **нет** `drift`, `flutter_riverpod`, `go_router`, `uuid`, `fl_chart`, `intl` как новых зависимостей.

В `analysis_options.yaml` приложения в `analyzer.errors` добавить `invalid_annotation_target: ignore`. Плагин `riverpod_lint` **не** подключать.

## 5. Копирование из донора (только эти файлы)

Корень донора: `/Users/vvk/AndroidStudioProjects/r/beer_ledger/`

Корень цели: `/Users/vvk/AndroidStudioProjects/r/beer-logger/`

Скопируй логику **байт-в-байт**, затем §6. `*.freezed.dart` **не** копировать — сгенерировать. Не изобретай коэффициенты пресета.

| Источник | Цель |
|----------|------|
| `lib/bounded_contexts/portion/domain/clicker/axis_sign.dart` | то же |
| `lib/bounded_contexts/portion/domain/clicker/beer_half_liter.dart` | то же |
| `lib/bounded_contexts/portion/domain/clicker/clicker.dart` | то же |
| `lib/bounded_contexts/portion/domain/clicker/clicker_id.dart` | то же |
| `lib/bounded_contexts/portion/domain/clicker/clicker_settings_repository.dart` | то же |
| `lib/bounded_contexts/portion/domain/clicker/ledger_axis.dart` | то же |
| `lib/bounded_contexts/journal/domain/click/aggregate_for_period.dart` | то же |
| `lib/bounded_contexts/journal/domain/click/axis_contribution.dart` | то же |
| `lib/bounded_contexts/journal/domain/click/axis_record_input.dart` | то же |
| `lib/bounded_contexts/journal/domain/click/click.dart` | то же |
| `lib/bounded_contexts/journal/domain/click/click_id.dart` | то же |
| `lib/bounded_contexts/journal/domain/click/click_repository.dart` | то же |
| `lib/bounded_contexts/journal/domain/click/period_balances.dart` | то же |
| `lib/bounded_contexts/journal/domain/click/signed_base_delta.dart` | то же |
| `lib/bounded_contexts/journal/application/axis_record_inputs.dart` | то же |
| `test/helpers/domain_fixtures.dart` | то же |
| `test/bounded_contexts/portion/domain/clicker/clicker_test.dart` | то же |
| `test/bounded_contexts/portion/domain/clicker/clicker_id_test.dart` | то же |
| `test/bounded_contexts/journal/domain/click/click_record_test.dart` | то же |
| `test/bounded_contexts/journal/domain/click/click_id_test.dart` | то же |
| `test/bounded_contexts/journal/domain/click/aggregate_for_period_test.dart` | то же |

Сигнатура `Click.record` обязана остаться: `ClickId`, `ClickerId`, `DateTime at`, `List<AxisRecordInput> axes`, `factor`. Параметра типа `Clicker` нет.

Контракты `ClickRepository` и `ClickerSettingsRepository` копируются как интерфейсы. Реализаций в `infrastructure/` **нет**.

Удалить `.gitkeep` в каталогах, куда легли файлы (`portion/domain`, `journal/domain`, `journal/application`). В пустых `infrastructure/` и `portion/application/` `.gitkeep` оставить.

## 6. Правки после копирования (обязательно)

### Импорты пакета приложения

Во **всех** скопированных `lib/` и `test/` заменить:

`package:beer_ledger/` → `package:beer_logger/`

`package:beer_ledger_core/` не трогать.

Проверка: `grep -R 'package:beer_ledger/' lib test` в витрине — пусто (кроме совпадения внутри `beer_ledger_core`).

### Баррели — переписать, не копировать донорские

Донорские `portion.dart` / `journal.dart` экспортируют Riverpod и UI. В витрине:

`lib/bounded_contexts/portion/portion.dart` — library comment: контекст «порция», вопрос «что будет при нажатии сейчас». Экспорт только:

- `domain/clicker/axis_sign.dart`
- `domain/clicker/beer_half_liter.dart`
- `domain/clicker/clicker.dart`
- `domain/clicker/clicker_id.dart`
- `domain/clicker/clicker_settings_repository.dart`
- `domain/clicker/ledger_axis.dart`

`lib/bounded_contexts/journal/journal.dart` — вопрос «что уже случилось». Экспорт только domain/click/* и `application/axis_record_inputs.dart`. **Не** экспортировать `home_page.dart` (приложение импортирует его напрямую).

Тесты, которые у донора импортируют `journal.dart` / `portion.dart`, после этого продолжают компилироваться.

`lib/app/app.dart` и `home_page.dart` **не** менять (заглушка).

### DartDoc

Убрать археологию: `ADR 001`/`002`/`003`, `PR 5`, `iter 2`, `beer_ledger` как имя репозитория, `flutter-senior-prep`. Смысл формул и пресета не менять. Имя теста про заморозку вклада — без «ADR»: смена конфигурации Clicker не меняет уже записанный Click.

### Codegen

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
dart pub get
dart run build_runner build --delete-conflicting-outputs
```

Все `*.freezed.dart` рядом с `@freezed` в `lib/bounded_contexts/**`. Руками не править. В git их кладут.

## 7. Документы приложения

### `docs/architecture.md`

Не стирать ядро шага 03. Поднять версию, время шапки — `date '+%Y-%m-%d %H:%M:%S %z'`, две пробела в конце строк шапки кроме последней.

Обязательно, иначе шаг брак:

1. Агрегат порции — папка `portion/domain/clicker/`. Агрегат журнала — `journal/domain/click/`. Не общие корзины `entities/` / `value_objects/`.
2. `Click.record` принимает `List<AxisRecordInput>`, не `Clicker`. Домен журнала импортирует из порции только `ClickerId`.
3. Мост — `axisRecordInputsFrom` в `journal/application/`.
4. Вклад в `AxisContribution` заморожен в базовой единице; смена живой порции уже записанный `Click` не пересчитывает.
5. Контракты репозиториев лежат в папке агрегата. Реализаций Drift нет (шаг 05).
6. Отвергнуто: `Click.record(Clicker)`.
7. Дерево `lib/` — с новыми файлами агрегатов (ASCII). `home_page.dart` — заглушка.

Без TODO, без путей штаба, без имени соседнего репозитория-лаборатории.

### `AGENTS.md`

Факт: в BC появились агрегаты Clicker/Click; Drift/Riverpod по-прежнему не в pubspec.

## 8. Не трогать

- `packages/beer_ledger_core/**` (кроме необходимости — не должно понадобиться)
- `.cursor/`, `.github/workflows/` (CI шага 03 уже гоняет `flutter test`)
- `lib/core/`, `lib/app/`, `lib/main.dart`, `home_page.dart`
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
test -f lib/bounded_contexts/portion/domain/clicker/clicker.dart
test -f lib/bounded_contexts/portion/domain/clicker/clicker.freezed.dart
test -f lib/bounded_contexts/journal/domain/click/click.dart
test -f lib/bounded_contexts/journal/domain/click/click.freezed.dart
test -f lib/bounded_contexts/journal/application/axis_record_inputs.dart
test -f lib/bounded_contexts/journal/domain/click/click_repository.dart
test -f lib/bounded_contexts/portion/domain/clicker/clicker_settings_repository.dart
test ! -f lib/bounded_contexts/journal/infrastructure/drift_click_repository.dart
test ! -d docs/steps
grep -R 'package:beer_ledger/' lib test && echo FAIL_OLD_PACKAGE || echo OK_PACKAGE
grep -R "package:flutter_riverpod" pubspec.yaml lib && echo FAIL_RIVERPOD || echo OK_NO_RIVERPOD
grep -R "package:drift" pubspec.yaml lib && echo FAIL_DRIFT || echo OK_NO_DRIFT
grep -n "Clicker clicker" lib/bounded_contexts/journal/domain/click/click.dart && echo FAIL_RECORD_CLICKER || echo OK_RECORD
grep -R "clicker/clicker.dart" lib/bounded_contexts/journal/domain && echo FAIL_DOMAIN_IMPORT || echo OK_NO_CLICKER_IN_JOURNAL_DOMAIN
```

Любая `test` с ненулевым кодом — шаг не сдан. `flutter test` — все тесты зелёные, включая domain. Analyze с warning — не сдан.

`Click.record` в `click.dart` содержит `List<AxisRecordInput>`.

## 10. Сдача человеку

1. Список созданных/изменённых путей относительно `beer-logger`.
2. Полный вывод §9.
3. Строка `Issue шага: #<цифры>` (из §2). Затем сообщения коммитов **кода**. **Каждая** строка с `(#`те же цифры`)`. Например, если issue = 12:
   - `feat: ввести агрегат кликера и пресет порции (#12)`
   - `feat: ввести Click.record и мост осей журнала (#12)`
   - `test: покрыть запись, заморозку вклада и агрегацию (#12)`
   - `docs: описать домен порции и журнала в architecture (#12)`
   Если `gh` дал не 12 — писать то число, не двенадцать из примера.
4. Готовая команда `gh pr create` из секции PR **уже с этими цифрами** в `--title` и в `Closes #…`. Команду не запускать.
5. Ровно: `Жду критика. Push не делаю. Коммитов нет.`

Не предлагай merge. Не пиши `docs/steps/`. Не коммить.
