# Шаг 02 — Cursor MCP и правила агента

**Дата создания:** 2026-09-26 13:35:01 +0300  
**Последнее обновление:** 2026-09-26 13:35:01 +0300  
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
5. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/plan.md` — этот шаг = `step/02-cursor-kit`, сквош `chore: подключить Dart MCP и правила Cursor`
6. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/tools/flutter-cursor-ai-setup/SETUP_PROMPT.md` — порядок установки; расхождения с **этим** промптом решать **по этому промпту**
7. `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/tools/flutter-cursor-ai-setup/README.md` — master kit не копировать в beer-logger
8. `/Users/vvk/AndroidStudioProjects/r/beer-logger/docs/architecture.md` — уже есть; **не** заменять шаблоном kit
9. `/Users/vvk/AndroidStudioProjects/r/beer-logger/pubspec.yaml` и дерево `lib/` — discovery стека, не выдумывать пакеты

Не открывать `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/prompts/_CRITIC.md`.

Не открывать `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/project_pivomer/vitrine/operator.md`.

Не копировать `/Users/vvk/AndroidStudioProjects/r/beer_ledger/AGENTS.md` — там устаревшее дерево. Не копировать `beer_ledger/.github` templates.

Шаблоны только читать и **копировать в beer-logger**:

`/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/tools/flutter-cursor-ai-setup/templates/`

Файлы внутри `templates/` **не править**.

## Issue (человек, до чата; модель не создаёт)

Title и body ниже уходят на GitHub **как есть**. Только язык задачи в репозитории.

**Title**

```
Подключить Cursor MCP и правила агента
```

**Body**

```
## Зачем

Агенту в Cursor нужны Dart MCP, правила проекта, хук git и skills. Без этого анализ и сдача идут вслепую.

## Сделать

- `.cursor/mcp.json` — сервер `dart mcp-server`
- rules, hooks, project skills, `.cursorignore`
- `AGENTS.md` по фактическому стеку приложения
- `docs/registries/`, `docs/AGENT_INVARIANTS.md`
- официальные skills `flutter/agent-plugins`

## Не делать

Не менять `lib/` и `docs/architecture.md`. Не добавлять Drift, Riverpod, flavors, issue/PR templates. Не копировать каталог `tools/flutter-cursor-ai-setup` в этот репозиторий.
```

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
gh label create vitrine --force --description "beer-logger" --color 0E8A16
gh label create step-02 --force --description "шаг 02" --color 1D76DB
gh issue create --repo ValeriusGC/beer-logger --title "Подключить Cursor MCP и правила агента" --label vitrine --label step-02 --body "$(cat <<'EOF'
## Зачем

Агенту в Cursor нужны Dart MCP, правила проекта, хук git и skills. Без этого анализ и сдача идут вслепую.

## Сделать

- `.cursor/mcp.json` — сервер `dart mcp-server`
- rules, hooks, project skills, `.cursorignore`
- `AGENTS.md` по фактическому стеку приложения
- `docs/registries/`, `docs/AGENT_INVARIANTS.md`
- официальные skills `flutter/agent-plugins`

## Не делать

Не менять `lib/` и `docs/architecture.md`. Не добавлять Drift, Riverpod, flavors, issue/PR templates. Не копировать каталог `tools/flutter-cursor-ai-setup` в этот репозиторий.
EOF
)"
```

Модель: `gh issue create` **не** запускать.

## PR (человек, после критика; модель не создаёт)

**Title**

```
chore: подключить Dart MCP и правила Cursor
```

**Body** (`N` — номер issue)

```
Closes #N

Dart MCP, rules, git-hook, project skills, официальные agent-plugins, AGENTS.md, реестры. Код приложения не менялся.
```

```bash
gh pr create --repo ValeriusGC/beer-logger --base main --title "chore: подключить Dart MCP и правила Cursor" --body "$(cat <<EOF
Closes #N

Dart MCP, rules, git-hook, project skills, официальные agent-plugins, AGENTS.md, реестры. Код приложения не менялся.
EOF
)"
```

## 1. Жёсткие запреты

- Писать **только** в `/Users/vvk/AndroidStudioProjects/r/beer-logger`. Штаб и `templates/` не менять. Донор не менять.
- `git commit` запрещён, пока человек не приказал в **этом** сообщении. После сдачи коммитов нет: сначала критик. `git push`, `gh pr create`, merge — запрещены всегда.
- `docs/steps/` не создавать до приказа «закоммить промпт и критик». Первый коммит шага — только `docs/steps/02-prompt.md` и `docs/steps/02-critic.md`.
- Не затирать `/Users/vvk/AndroidStudioProjects/r/beer-logger/docs/architecture.md` файлом `templates/docs/architecture.md`.
- Не класть в beer-logger каталог `tools/flutter-cursor-ai-setup/`.
- Не добавлять issue/PR templates, Drift, Riverpod в pubspec, flavor, desktop, правки `lib/` кроме заполнения реестров фактами из уже существующих виджетов.
- Не копировать `AGENTS.md` из `beer_ledger`.
- `dart format --output=none --set-exit-if-changed .` — выход 0 до сдачи.

## Сообщения коммитов (дубль, обязательно)

> [!CAUTION]
> Все `git commit` и заголовок squash-PR — **Conventional Commits**. После `feat:` / `fix:` / `docs:` / `ci:` / `chore:` сразу глагол в **инфинитиве** (сделать, сохранить, включить, подключить). Не существительное (`chore: MCP`), не прошедшее (`chore: added`), не английский глагол (`add`).
>
> Да: `chore: подключить Dart MCP и правила Cursor`. `docs: сохранить промпт и вердикт критика шага 02`.
>
> Предложить при сдаче или закоммитить иначе — дефект шага, наравне с упавшим analyze.

Эта секция обязана быть в каждом промпте шага целиком, не «см. _COMMON».

## 2. Состояние репозитория

Шаг 01 влит в `main`. Ожидаемая ветка: `step/02-cursor-kit`. Если текущая ветка другая — **стоп**, спросить человека.

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
git rev-parse --abbrev-ref HEAD
test -f docs/architecture.md
test ! -f .cursor/mcp.json
```

## 3. Цель

После шага агент Cursor в этом репозитории видит MCP `dart`, 11 rules, git-hook, 4 project skills, официальные dart/flutter skills, `AGENTS.md` с **фактическим** стеком (два bounded context, stub `beer_ledger_core`, без Drift/Riverpod). Поведение приложения не меняется.

## 4. Discovery (зафиксировать в сдаче, не выдумывать)

Из `pubspec.yaml`, `lib/`, `packages/beer_ledger_core/pubspec.yaml`, `docs/architecture.md`:

- имя пакета приложения
- SDK
- path-зависимость на `beer_ledger_core`
- есть ли flutter_riverpod / drift / go_router / gen-l10n (на шаге 01 их нет — так и писать)
- путь архитектуры: `docs/architecture.md`

## 5. Копирование из templates

Источник: `/Users/vvk/AndroidStudioProjects/r/flutter-senior-prep/tools/flutter-cursor-ai-setup/templates/`

Цель: `/Users/vvk/AndroidStudioProjects/r/beer-logger/`

| Источник | Назначение |
|----------|------------|
| `mcp.json` | `.cursor/mcp.json` |
| `hooks.json` | `.cursor/hooks.json` |
| `hooks/gate-git.sh` | `.cursor/hooks/gate-git.sh` |
| `cursorignore` | `.cursorignore` |
| `rules/*.mdc` | `.cursor/rules/` — все **11** файлов |
| `skills/*/` | `.cursor/skills/` — все 4 skill |
| `docs/registries/*` | `docs/registries/` |
| `docs/AGENT_INVARIANTS.md` | `docs/AGENT_INVARIANTS.md` |
| `AGENTS.md.tmpl` | сгенерировать `AGENTS.md` (не оставлять `{{...}}`) |

Затем:

```bash
chmod +x /Users/vvk/AndroidStudioProjects/r/beer-logger/.cursor/hooks/gate-git.sh
```

Время шапок: один вызов `date '+%Y-%m-%d %H:%M:%S %z'`, подставить во все **созданные** markdown (реестры, AGENT_INVARIANTS, AGENTS.md). Строки шапки кроме последней — с двумя пробелами в конце.

`{{TODAY}}` и любой `{{` в целевом репо после шага — дефект: `grep -r '{{' --include='*.md' --include='*.tmpl' .` в beer-logger должен быть пуст по задетым файлам (не считать `docs/steps` — его ещё нет).

### AGENTS.md

Плейсхолдеры:

- `{{PROJECT_NAME}}` — из корневого `pubspec.yaml` (`beer_logger` / Пивомер — как в файле)
- `{{STACK_BULLETS}}` — только факты discovery. Обязательно: Flutter app; `packages/beer_ledger_core` без Flutter; два BC `portion` / `journal`; CI `flutter analyze --fatal-warnings`. Не писать Drift/Riverpod как уже подключённые, если их нет в pubspec
- `{{ARCHITECTURE_DOC}}` — `docs/architecture.md`
- `{{REGISTRIES_PATH}}` — `docs/registries/`
- `{{TODAY}}` — из `date`

В Git-секции AGENTS: commit/push только по явной команде человека — это совпадает с правилами витрины.

### Реестры

Не оставлять только `lib/ui/shared/...` из шаблона, если в проекте другой путь. Записать факт: `HomePage` — `lib/bounded_contexts/journal/presentation/home_page.dart` (заглушка). Shared-корзины `lib/ui/shared` нет — так и сказать в таблице или README реестров. Остальные реестры могут остаться с пометкой, что записей пока нет, без выдуманных виджетов.

### Официальные skills

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
npx skills add flutter/agent-plugins --skill '*' --agent universal --yes
```

Нет Node:

```bash
dart run skills@ add https://github.com/flutter/agent-plugins --agent universal
```

Должен появиться `.agents/skills/` с dart и flutter. Если команда падает — **стоп**, текст ошибки человеку, не симулировать каталог.

## 6. Не трогать

- `lib/**` (кроме если реестр ссылается на существующий файл — сам dart не менять)
- `docs/architecture.md`
- `.github/workflows/`
- `packages/beer_ledger_core` код
- `docs/steps/` до приказа после критика

## 7. Приёмка (прогнать самому, вставить полный вывод)

```bash
cd /Users/vvk/AndroidStudioProjects/r/beer-logger
git rev-parse --abbrev-ref HEAD
dart --version
dart mcp-server --help
test -f .cursor/mcp.json
test -f .cursor/hooks.json
test -x .cursor/hooks/gate-git.sh
test -f .cursorignore
test -f AGENTS.md
test -f docs/AGENT_INVARIANTS.md
test -f docs/architecture.md
test -d docs/registries
test -d .cursor/skills
test -d .agents/skills
test ! -d tools/flutter-cursor-ai-setup
find .cursor/rules -name '*.mdc' | wc -l   # 11
grep -r '{{' AGENTS.md docs/registries docs/AGENT_INVARIANTS.md .cursor && echo FAIL_PLACEHOLDERS || echo OK_PLACEHOLDERS
dart format --output=none --set-exit-if-changed .
flutter analyze --fatal-warnings
```

`mcp.json` содержит `"command": "dart"` и `"mcp-server"`. `AGENTS.md` не содержит `lib/data/` и не утверждает, что Drift/Riverpod уже в pubspec, если их нет.

## 8. Сдача человеку

1. Список созданных путей.
2. Полный вывод §7.
3. Сообщения коммитов **кода/kit** (после коммита промпт+критик), инфинитив, например:
   - `chore: подключить Dart MCP, rules и git-hook`
   - `docs: добавить AGENTS.md и реестры`
   - `chore: установить официальные agent-plugins`
4. Ровно: `Жду критика. Push не делаю. Коммитов нет.`
5. Напомнить человеку (не делать самому): после merge включить MCP `dart` в Cursor (Tools, зелёная точка), Reload Window, `chmod +x` если hook не подхватился.

Не предлагай merge. Не пиши `docs/steps/`. Не коммить.
