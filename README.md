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


<img width="300" alt="image" src="https://github.com/user-attachments/assets/7958a6eb-f279-4dac-8d27-2b6c2465a7ac" />
<img width="300" alt="image" src="https://github.com/user-attachments/assets/e9ac6390-e4d9-4503-888e-47413318638e" />
<img width="300" alt="image" src="https://github.com/user-attachments/assets/2b4dd785-30ae-4356-b689-9141583a1852" />
<img width="600" alt="image" src="https://github.com/user-attachments/assets/2b82048c-1a29-45e2-9569-c1f5f846da3d" />



## Запуск

```bash
flutter pub get
flutter run
cd packages/beer_ledger_core && dart test
```
