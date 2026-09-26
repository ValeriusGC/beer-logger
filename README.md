# Пивомер

**Дата создания:** 2026-09-25 15:23:47 +0300  
**Последнее обновление:** 2026-09-26 14:37:30 +0300  
**Версия:** 2  
**Вид документа:** справочник

[![CI](https://github.com/ValeriusGC/beer-logger/actions/workflows/ci.yml/badge.svg)](https://github.com/ValeriusGC/beer-logger/actions/workflows/ci.yml)

Offline trade-off tap: одно нажатие фиксирует несколько осей учёта — объём, ккал, деньги, удовольствие. Смена настроек сегодня не переписывает вчерашние тапы.

Архитектура: [docs/architecture.md](docs/architecture.md).

## Запуск

```bash
flutter pub get
flutter run
cd packages/beer_ledger_core && dart test
```
