# Пивомер

**Дата создания:** 2026-09-25 15:23:47 +0300  
**Последнее обновление:** 2026-09-28 09:52:28 +0300  
**Версия:** 4  
**Вид документа:** справочник

[![CI](https://github.com/ValeriusGC/beer-logger/actions/workflows/ci.yml/badge.svg)](https://github.com/ValeriusGC/beer-logger/actions/workflows/ci.yml)

## Про проект

Небольшой учебный репозиторий: trade-off tap с несколькими осями учёта: **живой пример**, как раскладывать Flutter-приложение по DDD и UI Projection, не раздувая код.

Два bounded context (`portion`, `journal`), слои domain → application → infrastructure → presentation, dumb-виджеты с UiModel, Drift для локального хранения, Riverpod и go_router — всё по делу, без лишних фич. 

Подробности — в [docs/architecture.md](docs/architecture.md).

## Функционал

Offline trade-off tap: одно нажатие фиксирует несколько осей учёта — объём, ккал, деньги, удовольствие. Смена настроек сегодня не переписывает вчерашние тапы.

На главной: тап, баланс дня, список с undo, график объёма за 7 дней. Настройки порции — четыре числа живой порции. UI на русском и английском.

## Запуск

```bash
flutter pub get
flutter run
cd packages/beer_ledger_core && dart test
```
