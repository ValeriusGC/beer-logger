# Шаг 01 — каркас DDD и CI

**Дата создания:** 2026-09-25 14:38:08 +0300  
**Последнее обновление:** 2026-09-25 16:44:29 +0300  
**Версия:** 6  
**Вид документа:** инструкция

> [!IMPORTANT]
> В чат кладётся **только этот файл**. Остальное исполнитель открывает сам по абсолютным путям ниже. Человек не вкладывает `_COMMON.md`, `rules.md` и `_CRITIC.md`.
>
> **Модель шага — Composer 2.5** (или слабее автора промпта). Workspace Cursor: `/Users/vvk/AndroidStudioProjects/r/beer-logger`.
>
> Первой фразой ответа назови модель. Не совпало — остановись и попроси переключить; файлы не трогай.

## 0. Прочитать до любой правки (обязательно, по порядку)

Открой каждый файл целиком инструментом чтения. Не угадывай содержимое.

1. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/prompts/_COMMON.md` — git, качество, сдача. Нарушить нельзя.
2. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/rules.md` — один шаг / одна ветка / squash; модель не пушит.
3. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/.cursor/rules/quality-bar.mdc` — минимальный diff, без строк «на будущее».
4. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/.cursor/rules/doc-header-metadata.mdc` — шапка markdown в `docs/architecture.md` и README витрины.
5. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/plan.md` — этот шаг = `step/01-skeleton`, сквош `feat: каркас DDD и CI`.
6. `/Users/vvk/AndroidStudioProjects/r/beer_ledger/docs/project-structure.md` — **смысл** дерева (два контекста, слои внутри). Код, ADR, flavor, `l10n/` **не копировать**.

Не открывать `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/prompts/_CRITIC.md`. Это другой чат.

Не открывать `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/operator.md` — это руки человека, не твоя инструкция.

## Issue (человек, до чата; модель не создаёт)

Title и body ниже уходят на GitHub **как есть**. Писать только язык проекта: что делаем в коде. Не писать про аудиторию, соседние репозитории, штаб, промпты.

Источник для человека: эта секция. Оператор: `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/operator.md` §4 п.1.

Метки: `vitrine`, `step-01` (создать, если нет).

**Title**

```
Каркас DDD и CI
```

**Body**

```
## Зачем

Поднять Flutter-приложение с двумя ограниченными контекстами (порция и журнал) и слоями внутри каждого. Домен учёта и экраны данных — следующие задачи.

## Сделать

- приложение в корне репозитория и пакет `packages/beer_ledger_core` без Flutter (пока пустой API)
- `lib/bounded_contexts/{portion,journal}`: domain, application, infrastructure, presentation
- заглушка главного экрана «Пивомер», `docs/architecture.md`
- GitHub Actions: `flutter analyze --fatal-warnings` на push и pull request в `main`

## Не делать

Drift, Riverpod, локализация, flavors, desktop-таргеты, экраны с цифрами и кнопкой тапа.
```

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
gh label create vitrine --force --description "beer-logger" --color 0E8A16
gh label create step-01 --force --description "шаг 01" --color 1D76DB
gh issue create --repo ValeriusGC/beer-logger --title "Каркас DDD и CI" --label vitrine --label step-01 --body "$(cat <<'EOF'
## Зачем

Поднять Flutter-приложение с двумя ограниченными контекстами (порция и журнал) и слоями внутри каждого. Домен учёта и экраны данных — следующие задачи.

## Сделать

- приложение в корне репозитория и пакет `packages/beer_ledger_core` без Flutter (пока пустой API)
- `lib/bounded_contexts/{portion,journal}`: domain, application, infrastructure, presentation
- заглушка главного экрана «Пивомер», `docs/architecture.md`
- GitHub Actions: `flutter analyze --fatal-warnings` на push и pull request в `main`

## Не делать

Drift, Riverpod, локализация, flavors, desktop-таргеты, экраны с цифрами и кнопкой тапа.
EOF
)"
```

Модель: `gh issue create` **не** запускать. Номер issue не выдумывать.

## PR (человек, после критика; модель не создаёт)

Title и body — тоже публичные. Тот же запрет, что у issue.

**Title** (squash merge — то же сообщение)

```
feat: каркас DDD и CI
```

**Body** (`N` — номер issue, подставляет человек)

```
Closes #N

Flutter-приложение в корне, пакет `beer_ledger_core`, дерево `lib/bounded_contexts` для порции и журнала, заглушка home, `docs/architecture.md`, CI с `flutter analyze --fatal-warnings`.
```

```bash
# после push ветки; N — номер issue
gh pr create --repo ValeriusGC/beer-logger --base main --title "feat: каркас DDD и CI" --body "$(cat <<EOF
Closes #N

Flutter-приложение в корне, пакет \`beer_ledger_core\`, дерево \`lib/bounded_contexts\` для порции и журнала, заглушка home, \`docs/architecture.md\`, CI с \`flutter analyze --fatal-warnings\`.
EOF
)"
```

## 1. Жёсткие запреты (дубль _COMMON, чтобы не пропустить)

- Писать **только** в `/Users/vvk/AndroidStudioProjects/r/beer-logger`. Штаб и донор не менять.
- `git commit` запрещён, пока человек не приказал в **этом** сообщении. После сдачи коммитов нет: сначала критик. `git push`, `gh pr create`, merge — запрещены всегда.
- `docs/steps/` не создавать до приказа «закоммить промпт и критик». Первый коммит шага — только эти два файла; код — следующими коммитами по второму приказу.
- Не копировать dart-файлы из `/Users/vvk/AndroidStudioProjects/r/beer_ledger`.
- Не добавлять: Drift, sqlite, riverpod, freezed, fl_chart, l10n/arb, flavors, `productFlavors`, desktop (macos/linux/windows), issue/PR templates, `lib/features/`, `lib/data/`, корневые `lib/domain/` и `lib/presentation/`.
- Сдать код, который не прошёл `dart format --output=none --set-exit-if-changed .` — запрещено. Форматирует **модель**, до analyze. Человек формат за неё не гоняет.

## 2. Состояние репозитория

Клон уже есть: `/Users/vvk/AndroidStudioProjects/r/beer-logger`. Git инициализирован, **коммитов может не быть**, рабочих файлов нет.

Человек уже на ветке `step/01-skeleton` (или создаст её сам). Ветку не переименовывать. Если текущая ветка не `step/01-skeleton` — **стоп**, спросить человека, не создавать ветку молча.

Проверка первой командой:

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
git rev-parse --abbrev-ref HEAD
ls -la
```

## 3. Цель шага

После шага репозиторий компилируется, `flutter analyze --fatal-warnings` чистый, в `lib/` сразу видно два bounded context, есть `docs/architecture.md` и CI. Home — заглушка без домена. Это **кадр архитектуры**, не продукта.

## 4. Scaffold

В корне витрины (не во вложенной папке):

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
flutter create . \
  --project-name beer_logger \
  --org com.beerlogger \
  --platforms=android,ios,web
```

Если команда откажется из‑за непустого `.git` — повтори с флагом, который `flutter create --help` даёт для существующего каталога (часто `--overwrite`). Не создавай вложенный `beer_logger/`.

После create:

- удали дефолтный счётчик: не оставляй `MyApp` / `_MyHomePageState` / FloatingActionButton `+1`;
- **не** добавляй macos, linux, windows (`flutter create` с `--platforms` выше их не создаёт; если появились — удали каталоги `macos/`, `linux/`, `windows/` из дерева, не коммить);
- android/ios/web оставь.

Имя пакета в `pubspec.yaml`: `beer_logger`. `publish_to: none`.

## 5. Пакет `packages/beer_ledger_core`

Создать path-пакет **без Flutter**:

```
packages/beer_ledger_core/pubspec.yaml
packages/beer_ledger_core/lib/beer_ledger_core.dart
packages/beer_ledger_core/analysis_options.yaml
```

`pubspec.yaml` пакета:

- `name: beer_ledger_core`
- `publish_to: none`
- `environment.sdk` совместим с app (тот же нижний порог, что у корневого `pubspec.yaml` после create)
- **нет** зависимости `flutter`
- `dev_dependencies`: `lints` (не `flutter_lints`)

`lib/beer_ledger_core.dart` — library с DartDoc на русском: это техническое ядро (единицы, Result, маркеры DDD появятся на шаге 02). Сейчас **ни одного** публичного типа, кроме пустого library-комментария. Не добавляй `measure/`, `Click`, `Clicker`.

В корневом `pubspec.yaml` приложения:

```yaml
dependencies:
  beer_ledger_core:
    path: packages/beer_ledger_core
```

Пакет должен резолвиться: `flutter pub get` в корне витрины.

## 6. Дерево `lib/` (создать целиком)

Git не хранит пустые каталоги. В **каждой** пустой папке слоя — файл `.gitkeep` (пустой) **или** один library-файл, как ниже. Смешивать смысл слоёв нельзя.

Точное дерево после шага (плюс то, что создал `flutter create` для android/ios/web):

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
    │   │   └── .gitkeep
    │   ├── application/
    │   │   └── .gitkeep
    │   ├── infrastructure/
    │   │   └── .gitkeep
    │   └── presentation/
    │       └── .gitkeep
    └── journal/
        ├── journal.dart
        ├── domain/
        │   └── .gitkeep
        ├── application/
        │   └── .gitkeep
        ├── infrastructure/
        │   └── .gitkeep
        └── presentation/
            └── home_page.dart
```

`lib/bounded_contexts/portion/portion.dart` — library comment: контекст «порция» отвечает на «что будет при нажатии сейчас». Пока без экспортов типов.

`lib/bounded_contexts/journal/journal.dart` — library comment: контекст «журнал» отвечает на «что уже случилось». Пока без экспортов типов.

`lib/app/app.dart` — виджет приложения: `MaterialApp`, `home:` — `HomePage` из журнала. Без `go_router` (шаг 05). Без Riverpod.

`lib/bounded_contexts/journal/presentation/home_page.dart` — `Scaffold` с `AppBar` title **Пивомер** и телом-текстом, что это каркас. Без кнопок тапа, без цифр, без графиков.

`lib/main.dart` — только `runApp(BeerLoggerApp())` (имя класса — как в `app.dart`).

`lib/core/.gitkeep` — папка композиции (DI, БД) **пустая**. Не клади туда `AppDatabase`.

**Запрещено:** `lib/features/`, `lib/data/`, `lib/domain/`, `lib/presentation/` в корне `lib/`.

## 7. Analyze

Корневой `analysis_options.yaml`:

- `include: package:flutter_lints/flutter.yaml`
- не ослаблять линты «чтобы пройти».

`flutter analyze --fatal-warnings` в корне обязан дать 0 issues. Infos, которые `--fatal-warnings` не валит, тоже доведи до нуля, если analyzer их печатает: политика витрины — чистый лог.

В `beer_ledger_core` — свой `analysis_options.yaml` с `include: package:lints/recommended.yaml`.

## 8. `docs/architecture.md`

Создать **как решение**, не как черновик. Шапка по `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/.cursor/rules/doc-header-metadata.mdc`:

- время шапки: вывод `date '+%Y-%m-%d %H:%M:%S %z'` на машине, не выдумывать;
- версия `1`;
- вид: `спецификация`.

Проза на русском. Сначала зачем, потом как. Без TODO, без placeholder, без ссылок на чужие ADR и без пути `flutter-senior-prep`.

Обязательное содержание (все пункты, иначе шаг бракован):

1. Зачем два контекста: **порция** = живые настройки нажатия; **журнал** = факты, которые уже случились.
2. Карточка баланса и график — не третий контекст, а presentation журнала (появится позже).
3. Слои живут **внутри** контекста: presentation → application → domain ← infrastructure.
4. `packages/beer_ledger_core` — техническое ядро (словарь единиц, Result, маркеры DDD), не bounded context.
5. `lib/core/` — композиция приложения, не бизнес-контекст.
6. Соседний `domain/` не импортируется. Мост порция→журнал — в application журнала, не в этом шаге.
7. Дерево папок — как в §6 этого промпта (можно тем же ASCII).

Отвергнутый вариант назвать одной фразой: слой-first (`lib/domain` на всё приложение) прячет границу порции и журнала.

## 9. README.md

Заменить дефолтный README от `flutter create`. Шапка метаданных — как у architecture.

Содержание:

- первая строка после шапки: badge CI (workflow `ci.yml`, репозиторий `ValeriusGC/beer-logger`);
- зачем: offline trade-off tap — один тап фиксирует несколько осей учёта (объём, ккал, деньги, удовольствие);
- ссылка на `docs/architecture.md`;
- команды: `flutter pub get`, `flutter run` (без `--flavor`);
- не обещать Drift, настройки, график, APK, flavors.

## 10. CI

Файл `/Users/vvk/AndroidStudioProjects/r/beer-logger/.github/workflows/ci.yml`:

- `on: push` и `pull_request` на ветку `main` (и на PR в `main`);
- один job на `ubuntu-latest`;
- checkout;
- Flutter **stable** через официальный action (`subosito/flutter-action@v2` или актуальный v2/v3 — зафиксируй tag, не `@master`);
- `flutter pub get`;
- `flutter analyze --fatal-warnings`.

Нет: `flutter build apk`, matrix desktop, `dart test` пакета (шаг 02).

## 11. Тесты приложения

Дефолтный `test/widget_test.dart` от счётчика **сломается**. Заменить на smoke: `pumpWidget` приложения, на экране есть текст **Пивомер**. Без моков, без домена.

`flutter test` должен быть зелёным.

## 12. Приёмка (прогнать самому, вставить полный вывод)

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
git rev-parse --abbrev-ref HEAD
dart format .
dart format --output=none --set-exit-if-changed .
flutter pub get
flutter analyze --fatal-warnings
flutter test
test -d lib/bounded_contexts/portion/domain
test -d lib/bounded_contexts/portion/application
test -d lib/bounded_contexts/portion/infrastructure
test -d lib/bounded_contexts/portion/presentation
test -d lib/bounded_contexts/journal/domain
test -d lib/bounded_contexts/journal/application
test -d lib/bounded_contexts/journal/infrastructure
test -d lib/bounded_contexts/journal/presentation
test -f lib/bounded_contexts/journal/presentation/home_page.dart
test -f lib/app/app.dart
test -f packages/beer_ledger_core/pubspec.yaml
test -f packages/beer_ledger_core/lib/beer_ledger_core.dart
test -f docs/architecture.md
test -f .github/workflows/ci.yml
test ! -d macos
test ! -d linux
test ! -d windows
test ! -d lib/features
test ! -d lib/data
test ! -d lib/domain
test ! -d lib/presentation
test ! -d docs/steps
```

Любая команда `test` с ненулевым кодом — шаг не сдан. `dart format --output=none --set-exit-if-changed .` с ненулевым кодом — шаг не сдан (сначала `dart format .`, потом проверка снова). Analyze с warning — не сдан.

## 13. Сдача человеку

В конце ответа, без push:

1. Список созданных и изменённых путей (относительно корня `beer-logger`).
2. Полный stdout/stderr приёмки §12; при ошибке — не прятать.
3. Предлагаемые сообщения коммитов **кода** (пойдут после первого коммита «промпт и критик», когда человек прикажет). Например:
   - `feat: scaffold Flutter и пакет beer_ledger_core`
   - `feat: дерево bounded_contexts и architecture.md`
   - `ci: analyze на push и PR`
4. Ровно фраза: `Жду критика. Push не делаю. Коммитов нет.`

Не предлагай merge. Не пиши `docs/steps/`. Не коммить. Не вызывай критика сам.
