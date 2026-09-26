# Шаг 03 — техническое ядро beer_ledger_core

**Дата создания:** 2026-09-26 14:20:53 +0300  
**Последнее обновление:** 2026-09-26 15:00:47 +0300  
**Версия:** 2  
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
5. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/plan.md` — этот шаг = `step/03-core`, сквош `feat: добавить техническое ядро beer_ledger_core (#‹цифры issue›)`
6. `/Users/vvk/AndroidStudioProjects/r/beer_ledger/docs/project-structure.md` — **смысл**: ядро = словарь + arch, не bounded context. Код приложения донора **не** копировать.
7. `/Users/vvk/AndroidStudioProjects/r/beer-logger/docs/architecture.md` — обновить, не заменять с нуля.
8. `/Users/vvk/AndroidStudioProjects/r/beer-logger/packages/beer_ledger_core/pubspec.yaml` и `lib/beer_ledger_core.dart` — сейчас stub.
9. `/Users/vvk/AndroidStudioProjects/r/beer-logger/AGENTS.md` — стек обязан совпасть с фактом после шага.
10. `/Users/vvk/AndroidStudioProjects/r/beer-logger/.github/workflows/ci.yml`

Затем **прочитай все исходники из таблицы §5** в доноре. Копируешь только их.

Не открывать `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/prompts/_CRITIC.md`.

Не открывать `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/operator.md`.

Не копировать из донора: `Click`, `Clicker`, `lib/bounded_contexts/`, ADR, `docs/`, `.github` приложения, `src/beer_ledger_core_base.dart`, `test/beer_ledger_core_test.dart`, `CHANGELOG.md`, README пакета донора.

## Issue (человек, до чата; модель не создаёт)

Title и body ниже уходят на GitHub **как есть**. Только язык задачи в репозитории.

**Title**

```
Добавить техническое ядро: единицы, Result, маркеры DDD
```

**Body**

```
## Зачем

Порция и журнал говорят на одном словаре единиц и ошибок. Этот словарь — не третий контекст и не Flutter: его можно тестировать на Dart VM.

## Сделать

- пакет `packages/beer_ledger_core`: шесть семейств единиц, `convert` / `toBase` / `fromBase` / `deltaInBase`
- `Failure` (freezed) и `Result` = `Either<Failure, T>` (fpdart)
- маркеры `AggregateRoot` / `Entity` / `ValueObject`, enum `LedgerAxisKind`
- VM-тесты; CI: `dart analyze` и `dart test` пакета

## Не делать

Не добавлять `Click` / `Clicker` в ядро. Не подключать Drift, Riverpod, экраны учёта. Не менять дерево `lib/bounded_contexts/` кроме необходимости (не должно понадобиться).
```

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
gh label create vitrine --force --description "beer-logger" --color 0E8A16
gh label create step-03 --force --description "шаг 03" --color 1D76DB
gh issue create --repo ValeriusGC/beer-logger --title "Добавить техническое ядро: единицы, Result, маркеры DDD" --label vitrine --label step-03 --body "$(cat <<'EOF'
## Зачем

Порция и журнал говорят на одном словаре единиц и ошибок. Этот словарь — не третий контекст и не Flutter: его можно тестировать на Dart VM.

## Сделать

- пакет `packages/beer_ledger_core`: шесть семейств единиц, `convert` / `toBase` / `fromBase` / `deltaInBase`
- `Failure` (freezed) и `Result` = `Either<Failure, T>` (fpdart)
- маркеры `AggregateRoot` / `Entity` / `ValueObject`, enum `LedgerAxisKind`
- VM-тесты; CI: `dart analyze` и `dart test` пакета

## Не делать

Не добавлять `Click` / `Clicker` в ядро. Не подключать Drift, Riverpod, экраны учёта. Не менять дерево `lib/bounded_contexts/` кроме необходимости (не должно понадобиться).
EOF
)"
```

Модель: `gh issue create` **не** запускать. Номер после создания человек не обязан писать в чат: модель сама снимает его в §2.

## PR (человек запускает; модель подставляет цифры в сдаче, команду не запускает)

Заголовок squash-merge — то же, что title PR. **Цифры issue обязательны.** Буква `N` в title/body/`gh` — брак.

Шаблон (вместо `12` — число из `gh issue list` §2, не это двенадцать, если карточка другая):

**Title**

```
feat: добавить техническое ядро beer_ledger_core (#12)
```

**Body**

```
Closes #12

Словарь единиц, convert через базовую единицу, Failure/Result, маркеры DDD, LedgerAxisKind. Пакет без Flutter, тесты на Dart VM.
```

В сдаче напечатать **готовую** команду с уже подставленными цифрами. Не запускать.

```bash
gh pr create --repo ValeriusGC/beer-logger --base main --title "feat: добавить техническое ядро beer_ledger_core (#12)" --body "$(cat <<EOF
Closes #12

Словарь единиц, convert через базовую единицу, Failure/Result, маркеры DDD, LedgerAxisKind. Пакет без Flutter, тесты на Dart VM.
EOF
)"
```

## 1. Жёсткие запреты

- Писать **только** в `/Users/vvk/AndroidStudioProjects/r/beer-logger`. Штаб и донор не менять.
- `git commit` запрещён, пока человек не приказал в **этом** сообщении. После сдачи коммитов нет: сначала критик. `git push`, `gh pr create`, merge — запрещены всегда.
- Закоммитить или предложить subject **без** `(#` + цифры issue + `)` — запрещено. Писать в git `#N`, `#ISSUE`, пустые `(#)` — запрещено.
- `docs/steps/` не создавать до приказа «закоммить промпт и критик». Первый коммит шага — только `docs/steps/03-prompt.md` и `docs/steps/03-critic.md`.
- В ядре **нет** типов `Click` и `Clicker`. Нет `import 'package:flutter/`.
- Не добавлять Drift, Riverpod, go_router, l10n, flavors, desktop, экраны тапа.
- Не создавать `docs/decisions/`. Решения — абзацами в `docs/architecture.md`.
- `dart format --output=none --set-exit-if-changed .` в корне витрины — выход 0 до сдачи.

## Сообщения коммитов (дубль, обязательно)

> [!CAUTION]
> Все `git commit` и заголовок squash-PR — **Conventional Commits**. После `feat:` / `fix:` / `docs:` / `ci:` / `chore:` сразу глагол в **инфинитиве** (сделать, сохранить, включить, добавить). Не существительное (`feat: ядро`), не прошедшее (`feat: added`), не английский глагол (`add`).
>
> **Номер GitHub issue этого шага — в КАЖДОМ коммите и в PR. Это не подсказка, это часть формата.**
>
> Первая строка каждого коммита и `--title` у PR:
> `тип: инфинитив … (#12)`
> `12` — **цифры** открытого issue с меткой `step-03`. Не буква N. Не слово ISSUE. Не пример «12», если `gh` показал другое число.
>
> Тело PR **обязано** начинаться с `Closes #12` (те же цифры). В коммитах **ветки** слово `Closes` не писать — только `(#12)` в subject (иначе GitHub закроет issue на первом коммите).
>
> Первый коммит шага: `docs: сохранить промпт и вердикт критика шага 03 (#12)`.
>
> Squash-заголовок: `feat: добавить техническое ядро beer_ledger_core (#12)`.
>
> Предложить список без `(#цифры)`, закоммитить без `(#цифры)`, напечатать `gh pr create` с `#N` — дефект шага, наравне с упавшим analyze.

Эта секция обязана быть в каждом промпте шага целиком, не «см. _COMMON».

Номер не выдумывать и не оставлять на человека. Снять в §2. Нет ровно одной открытой карточки `step-03` — **стоп**, спросить. После приказа коммитить — снова проверить, что в `-m` есть те же цифры.

## 2. Состояние репозитория

Шаги 01 и 02 влиты в `main`. Ожидаемая ветка: `step/03-core`. Если текущая ветка другая — **стоп**, спросить человека.

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
git rev-parse --abbrev-ref HEAD
test -f .cursor/mcp.json
test -f packages/beer_ledger_core/lib/beer_ledger_core.dart
test ! -d packages/beer_ledger_core/lib/measure
gh issue list --repo ValeriusGC/beer-logger --label step-03 --state open --json number,title
```

Вывод `gh issue list`: **ровно одна** открытая карточка. Её `number` — единственный номер, который дальше попадает в коммиты и PR. Ноль карточек, две и больше, или пустой `number` — **стоп**, спросить человека. Цифры назвать в первом ответе: `Issue шага: #…`.

## 3. Цель

После шага `packages/beer_ledger_core` — полноценное **техническое ядро** без Flutter: замкнутые enum-семейства единиц, перевод через базовую единицу, `Result`/`Failure`, пустые маркеры DDD, четыре вида осей продукта. Приложение по-прежнему показывает заглушку «Пивомер». Домен порции и журнала — следующий шаг.

Отвергнуто класть `Click`/`Clicker` в пакет: это прячет границу двух контекстов (они отвечают на разные вопросы). Отвергнуто тащить Flutter в ядро ради `@visibleForTesting`.

## 4. Зависимости пакета

`/Users/vvk/AndroidStudioProjects/r/beer-logger/packages/beer_ledger_core/pubspec.yaml`:

- оставить `name: beer_ledger_core`, `publish_to: none`, `environment.sdk` **как сейчас у stub** (не копировать `^3.12.2` донора);
- `description`: техническое ядро — единицы, Result, маркеры DDD (без слов «clicker» как содержимое пакета);
- `dependencies`: `fpdart: ^1.2.0`, `freezed_annotation: ^3.1.0`;
- `dev_dependencies`: `build_runner: ^2.13.0`, `freezed: ^3.2.5`, `lints: ^6.0.0`, `test: ^1.26.3`;
- **нет** `flutter`, `flutter_lints`, `flutter_test`.

`analysis_options.yaml` пакета:

```yaml
include: package:lints/recommended.yaml

analyzer:
  errors:
    invalid_annotation_target: ignore
```

Корневой `pubspec.yaml` приложения **не** получает fpdart/freezed — они живут в пакете.

## 5. Копирование из донора (только эти файлы)

Корень донора: `/Users/vvk/AndroidStudioProjects/r/beer_ledger/packages/beer_ledger_core/`

Корень цели: `/Users/vvk/AndroidStudioProjects/r/beer-logger/packages/beer_ledger_core/`

Скопируй **байт-в-байт**, затем правки DartDoc из §6. Не изобретай коэффициенты и id.

| Источник (относительно пакета донора) | Цель |
|---------------------------------------|------|
| `lib/arch/aggregate_root.dart` | то же |
| `lib/arch/entity.dart` | то же |
| `lib/arch/value_object.dart` | то же |
| `lib/arch/arch.dart` | то же |
| `lib/convert/convert.dart` | то же |
| `lib/failure/failure.dart` | то же; `failure.freezed.dart` **не** копировать — сгенерировать |
| `lib/ledger_axis_kind.dart` | то же |
| `lib/measure/count_unit.dart` | то же |
| `lib/measure/energy_unit.dart` | то же |
| `lib/measure/length_unit.dart` | то же |
| `lib/measure/mass_unit.dart` | то же |
| `lib/measure/measure.dart` | то же |
| `lib/measure/measure_family.dart` | то же |
| `lib/measure/measure_registry.dart` | то же |
| `lib/measure/measure_unit.dart` | то же |
| `lib/measure/money_unit.dart` | то же |
| `lib/measure/volume_unit.dart` | то же |
| `lib/result/result.dart` | то же |
| `test/convert/convert_test.dart` | то же |
| `test/measure/measure_units_test.dart` | то же |
| `test/measure/measure_wire_format_test.dart` | то же |
| `test/result/result_test.dart` | то же |

Шесть семейств (volume, mass, money, length, energy, count) — **все**. Масса и длина не оси продукта v1; они держат инвариант «конвертация только внутри семейства». Четыре оси кнопки — `LedgerAxisKind`.

`Failure` копируется **целиком**, включая `invalidPeriod`, `unknownUnitId`, `emptyId`, `storage`. Реализаций БД и `Click.record` нет — это словарь ошибок наперёд на один sealed-union, чтобы не ломать `when` на следующих шагах. Новых вариантов не выдумывать.

После копирования `failure.dart`:

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger/packages/beer_ledger_core
dart pub get
dart run build_runner build --delete-conflicting-outputs
```

`lib/failure/failure.freezed.dart` должен появиться. В git его кладут (как у донора). Руками файл не править.

Баррель `lib/beer_ledger_core.dart` **переписать** (не копировать донорский: там `export 'src/beer_ledger_core_base.dart'`):

```dart
/// Техническое ядро Пивомера: словарь единиц, ошибки, маркеры DDD.
///
/// Не bounded context. Агрегаты порции и журнала — в приложении,
/// `lib/bounded_contexts/`. См. `docs/architecture.md`.
library;

export 'arch/arch.dart';
export 'convert/convert.dart';
export 'failure/failure.dart';
export 'ledger_axis_kind.dart';
export 'measure/measure.dart';
export 'result/result.dart';
```

Каталога `lib/src/` в пакете **нет**. Константы версии пакета нет.

## 6. Зачистка текстов после копирования

В скопированных файлах (включая тесты) не должно остаться археологии чужого репозитория. Имеется в виду содержимое `packages/beer_ledger_core/` витрины.

Убрать или переформулировать:

- пути и имя репозитория `beer_ledger` (пакет `beer_ledger_core` и `package:beer_ledger_core/` — оставить);
- `fast_2020`, номера PR донора, `ADR 001`/`002`/`003`, `iter 1.1`, `docs/project-structure.md`, `flutter-senior-prep`;
- «появится на PR 4» / «модели осей (PR 4)» → знак оси задаёт домен порции, не `convert`;
- «используется в Click.record» → «при записи факта журнала»; id единицы хранится строкой, не ссылкой на enum.

Смысл формул, коэффициентов и тестов **не менять**.

Проверка (из корня витрины; совпадения по имени пакета `beer_ledger_core` допустимы):

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger/packages/beer_ledger_core
grep -REn 'fast_2020|ADR 00|project-structure|flutter-senior-prep|iter 1\.1|PR [0-9]' lib test || true
```

Имя пакета `beer_ledger_core` в импортах — норма. Строка про репозиторий-лабораторию, ADR и PR донора — дефект: поправить DartDoc и повторить.

## 7. Документы приложения

### `docs/architecture.md`

Не стирать каркас шага 01. Поднять версию, время шапки — `date '+%Y-%m-%d %H:%M:%S %z'`, две пробела в конце строк шапки кроме последней.

В секции ядра **заменить обещание** на факт. Обязательно, иначе шаг брак:

1. Ядро — не контекст. Два вопроса («что будет при нажатии» / «что уже случилось») по-прежнему у `portion` и `journal`.
2. Шесть enum-семейств; конвертация только внутри семейства; формула `value * from.ratioToBase / to.ratioToBase`.
3. Факт учёта будут хранить в **базовой** единице семейства (миллилитр, копейка, калория…); `id` единицы — wire-ключ, не `enum.index`. Реализации записи ещё нет.
4. `typedef Result<T> = Either<Failure, T>` (fpdart); Left = ошибка.
5. Маркеры `AggregateRoot` / `Entity` / `ValueObject` — пустые контракты роли; конкретные типы — в папках агрегатов на следующем шаге.
6. `LedgerAxisKind` — четыре оси продукта, общий словарь обоих языков.
7. Отвергнуто: `Click`/`Clicker` в этом пакете.
8. Номера следующих шагов (исправить старые, если они ещё в файле): домен порции и журнала — **04**; Drift/Riverpod — **05**; UI Projection главной — **06**. Мост порция→журнал — application журнала, шаг 04, не этот.

Без TODO, без путей штаба, без имени соседнего репозитория-лаборатории.

### `AGENTS.md`

Строка про stub ядра — ложь после этого шага. Написать факт: path-пакет без Flutter; fpdart + freezed `Failure`; VM-тесты `dart test`; Drift/Riverpod по-прежнему не в pubspec приложения.

### `README.md`

В блок запуска добавить проверки пакета (тот же шапочный бамп версии):

```bash
cd packages/beer_ledger_core && dart test
```

Не обещать тап, Drift, график.

## 8. CI

`/Users/vvk/AndroidStudioProjects/r/beer-logger/.github/workflows/ci.yml` — **два** job на `ubuntu-latest`:

1. `core`: `working-directory: packages/beer_ledger_core`; `dart-lang/setup-dart@v1` channel/sdk `stable`; `dart pub get`; `dart analyze --fatal-warnings`; `dart test`.
2. `app`: как сейчас (Flutter stable, `flutter pub get`, `flutter analyze --fatal-warnings`) **плюс** `flutter test` (smoke шага 01 должен остаться зелёным).

Не добавлять `flutter build apk`, matrix desktop.

## 9. Не трогать

- `lib/bounded_contexts/**`, `lib/app/`, `lib/main.dart`, `lib/core/`
- `.cursor/` (kit шага 02)
- `docs/steps/` до приказа после критика
- донор и штаб

## 10. Приёмка (прогнать самому, вставить полный вывод)

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
git rev-parse --abbrev-ref HEAD
dart format .
dart format --output=none --set-exit-if-changed .
flutter pub get
flutter analyze --fatal-warnings
flutter test
(
  cd packages/beer_ledger_core
  dart pub get
  dart analyze --fatal-warnings
  dart test
)
test -f packages/beer_ledger_core/lib/measure/measure.dart
test -f packages/beer_ledger_core/lib/convert/convert.dart
test -f packages/beer_ledger_core/lib/failure/failure.dart
test -f packages/beer_ledger_core/lib/failure/failure.freezed.dart
test -f packages/beer_ledger_core/lib/result/result.dart
test -d packages/beer_ledger_core/lib/arch
test -f packages/beer_ledger_core/lib/ledger_axis_kind.dart
test ! -f packages/beer_ledger_core/lib/src/beer_ledger_core_base.dart
test ! -d docs/steps
grep -REn "class Click[^a-zA-Z]|class Clicker" packages/beer_ledger_core/lib && echo FAIL_DOMAIN_IN_CORE || echo OK_NO_CLICK
grep -REn "package:flutter/" packages/beer_ledger_core/lib && echo FAIL_FLUTTER || echo OK_NO_FLUTTER
```

Любая `test` с ненулевым кодом — шаг не сдан. `dart test` пакета — все тесты зелёные. Analyze с warning — не сдан.

## 11. Сдача человеку

1. Список созданных/изменённых путей относительно `beer-logger`.
2. Полный вывод §10.
3. Строка `Issue шага: #<цифры>` (из §2). Затем сообщения коммитов **кода** (после коммита промпт+критик). **Каждая** строка с `(#`те же цифры`)`. Без цифр — сдача бракованная. Например, если issue = 12:
   - `feat: добавить единицы, convert и Failure в beer_ledger_core (#12)`
   - `test: покрыть меры, convert и Result на Dart VM (#12)`
   - `ci: включить analyze и тесты пакета core (#12)`
   - `docs: описать техническое ядро в architecture (#12)`
   Если `gh` дал не 12 — писать то число, не двенадцать из примера.
4. Готовая команда `gh pr create` из секции PR **уже с этими цифрами** в `--title` и в `Closes #…`. Команду не запускать.
5. Ровно: `Жду критика. Push не делаю. Коммитов нет.`

Не предлагай merge. Не пиши `docs/steps/`. Не коммить.
