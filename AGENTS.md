# AGENTS.md — beer_logger (Пивомер)

**Дата создания:** 2026-09-26 13:49:17 +0300  
**Последнее обновление:** 2026-09-26 14:37:30 +0300  
**Версия:** 2

Инструкции для AI-агентов в Cursor. Flutter/Dart-проект.

## Стек

- Flutter-приложение `beer_logger` (Пивомер), SDK `^3.13.4`
- Path-зависимость `packages/beer_ledger_core` — pure Dart без Flutter; fpdart + freezed `Failure`; VM-тесты `dart test`
- Два bounded context: `portion` и `journal` в `lib/bounded_contexts/`
- `flutter_riverpod`, `drift`, `go_router`, gen-l10n — **не подключены** (появятся на шаге 05)
- CI: job `core` — `dart analyze` и `dart test` пакета; job `app` — `flutter analyze --fatal-warnings` и `flutter test`

## Архитектура

Стандарты команды: **планка качества** (`quality-bar`), **DDD**, **UI Projection**, **SOLID / YAGNI / KISS / DRY**.

| Документ | Назначение |
|---|---|
| docs/architecture.md | Архитектура и UI Projection |

При сложных UI-задачах подключать архитектурную документацию через `@`.

## Реестры общих артефактов

Путь: `docs/registries/`

Перед новым shared-кодом — **обязательно** `/registry-before-create`.

| Реестр | Файл |
|--------|------|
| Виджеты | `docs/registries/widgets.md` |
| Диалоги / modals | `docs/registries/dialogs_and_modals.md` |
| Форматтеры | `docs/registries/formatters.md` |
| Extensions | `docs/registries/extensions.md` |
| Утилиты | `docs/registries/utilities.md` |
| Провайдеры | `docs/registries/providers_and_services.md` |

## Cursor Rules

**Always-on (5):** `quality-bar`, `team-principles`, `dry-and-registries`, `honesty-time-no-fabrication`, `git-sovereignty`

**По globs `**/*.dart` / `lib/**`:** `no-reinvent-wheel`, `dart-cg-file-naming`, `riverpod-first-reactivity`, `pre-delivery-analyzer-and-logs-check`, `dart-dartdoc-comments`

**По globs `**/*.md`:** `doc-header-metadata` — шапка **Дата создания / Последнее обновление / Версия**

## Git и Hooks

**Commit, push, PR — только пользователь**, если явно не попросил agent («Сделай коммит», «Сделай пуш»).

- Rule `git-sovereignty.mdc` — agent **не предлагает** commit/push; plan/todos не отменяют.
- Hook `.cursor/hooks/gate-git.sh` — `git commit`, `git push`, `gh pr create` → **Ask** в UI Cursor (`failClosed`).
- Read-only git (`status`, `diff`, `log`) — без ограничений.

После развёртывания: `chmod +x .cursor/hooks/gate-git.sh` → **Reload Window** → Settings → Hooks.

## MCP

Dart & Flutter MCP: `.cursor/mcp.json`

```json
{ "command": "dart", "args": ["mcp-server"] }
```

Требует Dart ≥ 3.9. Инструменты: analyze, pub.dev, runtime errors, widget tree, tests.

При сбоях roots: `"args": ["mcp-server", "--force-roots-fallback"]`

## Skills

### Проектные (`.cursor/skills/`)

| Skill | Вызов | Когда |
|---|---|---|
| `architecture-ui-workflow` | `/architecture-ui-workflow` | Новый экран/виджет, UI Projection |
| `riverpod-codegen` | `/riverpod-codegen` | @riverpod, @freezed, build_runner |
| `registry-before-create` | `/registry-before-create` | Перед новым shared-кодом |
| `delivery-checklist` | `/delivery-checklist` | Перед сдачей / PR |

### Официальные (`.agents/skills/`)

Источник (2026-07+): [flutter/agent-plugins](https://github.com/flutter/agent-plugins).

```bash
npx skills add flutter/agent-plugins --skill '*' --agent universal --yes
npx skills update
```

После зависимостей с bundled skills: `dart run skills@ get --agent universal`

Приоритетные:

- `dart-run-static-analysis`, `dart-fix-runtime-errors`, `dart-add-unit-test`, `dart-use-primary-constructors`
- `flutter-fix-layout-issues`, `flutter-setup-declarative-routing`, `flutter-add-widget-test`

**Осторожно:** `flutter-apply-architecture-best-practices` — сверять с UI Projection проекта.

## Codegen

```bash
dart run build_runner build --delete-conflicting-outputs
```

Файлы с codegen: `*.cg.dart` → `gen/*.g.dart`, `gen/*.freezed.dart`

## Pre-delivery

1. `flutter analyze` — без новых errors в затронутых файлах
2. `/delivery-checklist`
3. Реестры обновлены при новом shared-коде
4. Тесты при изменении логики: `flutter test <path>`

## Типовые промпты

- «Добавь экран по UI Projection, dumb widgets only»
- «Проверь static + runtime analysis, исправь layout issues»
- «Перед созданием диалога — проверь реестры»
- «Добавь @riverpod провайдер, запусти codegen»
