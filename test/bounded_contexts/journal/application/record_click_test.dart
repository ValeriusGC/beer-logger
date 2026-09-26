import 'package:beer_logger/core/di/app_database.cg.dart';
import 'package:beer_logger/core/di/click_repository.cg.dart';
import 'package:beer_logger/core/di/clicker_settings_repository.cg.dart';
import 'package:beer_logger/bounded_contexts/portion/application/current_clicker.cg.dart';
import 'package:beer_logger/core/di/now.cg.dart';
import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Порции пресета «Пиво 0.5»: 500 мл, 100000 cal, −15000 коп, 2 joy.
void _expectPortions(PeriodBalances balances, int count) {
  expect(balances.totalFor(LedgerAxisKind.volume).signedBase, 500.0 * count);
  expect(balances.totalFor(LedgerAxisKind.energy).signedBase, 100000.0 * count);
  expect(balances.totalFor(LedgerAxisKind.money).signedBase, -15000.0 * count);
  expect(balances.totalFor(LedgerAxisKind.joy).signedBase, 2.0 * count);
}

/// In-memory БД и замороженные часы.
///
/// Без override [appDatabase] откроет файл, [now] — реальный [DateTime.now].
ProviderContainer _container({required AppDatabase db, required DateTime now}) {
  return ProviderContainer.test(
    overrides: [
      appDatabaseProvider.overrideWithValue(db),
      nowProvider.overrideWithValue(now),
    ],
  );
}

/// Ждём emit drift `watch()` после записи. Без этого баланс ещё прежний.
Future<void> _flushWatch() => pumpEventQueue();

/// Порция приходит из БД. Пока поток грузится, [RecordClick.record] не пишет.
Future<void> _waitForClicker(ProviderContainer container) {
  container.listen(currentClickerProvider, (_, _) {});
  return container.read(currentClickerProvider.future);
}

void main() {
  late AppDatabase db;
  final now = DateTime(2026, 8, 24, 12);

  setUp(() {
    db = AppDatabase.inMemory();
  });

  tearDown(() async {
    await db.close();
  });

  group('RecordClick', () {
    test('record → баланс одной порции пресета', () async {
      final container = _container(db: db, now: now);
      container.listen(recordClickProvider, (_, _) {});
      await _waitForClicker(container);

      await container.read(recordClickProvider.notifier).record();
      await _flushWatch();

      final balances = await container
          .listen(todayBalanceProvider.future, (_, _) {})
          .read();
      _expectPortions(balances, 1);
    });

    test('второй record → две порции', () async {
      final container = _container(db: db, now: now);
      container.listen(recordClickProvider, (_, _) {});
      await _waitForClicker(container);
      final notifier = container.read(recordClickProvider.notifier);

      await notifier.record();
      await notifier.record();
      await _flushWatch();

      final balances = await container
          .listen(todayBalanceProvider.future, (_, _) {})
          .read();
      _expectPortions(balances, 2);
    });

    test('пока loading второй record не пишет второй тап', () async {
      final container = _container(db: db, now: now);
      container.listen(recordClickProvider, (_, _) {});
      await _waitForClicker(container);
      final notifier = container.read(recordClickProvider.notifier);

      final first = notifier.record();
      expect(container.read(recordClickProvider).isLoading, isTrue);
      final second = notifier.record();
      await Future.wait([first, second]);
      await _flushWatch();

      final balances = await container
          .listen(todayBalanceProvider.future, (_, _) {})
          .read();
      _expectPortions(balances, 1);
    });

    test('старый тап не переезжает, новый несёт 180 ккал', () async {
      final container = _container(db: db, now: now);
      container.listen(recordClickProvider, (_, _) {});
      container.listen(currentClickerProvider, (_, _) {});
      await _waitForClicker(container);
      final notifier = container.read(recordClickProvider.notifier);

      await notifier.record();
      await _flushWatch();

      final clicks = container.read(clickRepositoryProvider);
      final before = await clicks.watchClicksForDay(now).first;
      final old = before.single;
      final oldEnergy = old.contributions
          .firstWhere(
            (contribution) => contribution.kind == LedgerAxisKind.energy,
          )
          .delta
          .signedBase;
      expect(oldEnergy, 100000);

      final current = container.read(currentClickerProvider).requireValue;
      final saved = await container
          .read(clickerSettingsRepositoryProvider)
          .saveClicker(
            current.copyWith(
              axes: [
                for (final axis in current.axes)
                  axis.kind == LedgerAxisKind.energy
                      ? axis.copyWith(enteredValue: 180)
                      : axis,
              ],
            ),
          );
      expect(saved.isRight(), isTrue);
      await _flushWatch();

      final afterSave = await clicks.watchClicksForDay(now).first;
      expect(
        afterSave.single.contributions
            .firstWhere(
              (contribution) => contribution.kind == LedgerAxisKind.energy,
            )
            .delta
            .signedBase,
        oldEnergy,
      );
      final balance = await container
          .listen(todayBalanceProvider.future, (_, _) {})
          .read();
      expect(balance.totalFor(LedgerAxisKind.energy).signedBase, 100000);

      final updated = container.read(currentClickerProvider).requireValue;
      expect(
        updated.axes
            .firstWhere((axis) => axis.kind == LedgerAxisKind.energy)
            .enteredValue,
        180,
      );

      await notifier.record();
      await _flushWatch();

      final both = await clicks.watchClicksForDay(now).first;
      final fresh = both.singleWhere((click) => click.id != old.id);
      expect(
        fresh.contributions
            .firstWhere(
              (contribution) => contribution.kind == LedgerAxisKind.energy,
            )
            .delta
            .signedBase,
        180 * 1000,
      );
      final summed = await container
          .listen(todayBalanceProvider.future, (_, _) {})
          .read();
      expect(
        summed.totalFor(LedgerAxisKind.energy).signedBase,
        100000 + 180000,
      );
    });

    test('два тапа получают разное время, новый сверху', () async {
      final container = ProviderContainer.test(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
      );
      container.listen(recordClickProvider, (_, _) {});
      container.listen(currentClickerProvider, (_, _) {});
      await _waitForClicker(container);
      final notifier = container.read(recordClickProvider.notifier);

      await notifier.record();
      await notifier.record();
      await _flushWatch();

      final clicks = await container
          .read(clickRepositoryProvider)
          .watchClicksForDay(DateTime.now())
          .first;
      expect(clicks, hasLength(2));
      expect(clicks.first.at.isAfter(clicks.last.at), isTrue);
    });
  });
}
