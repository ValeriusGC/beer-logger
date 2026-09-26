import 'package:beer_logger/core/di/app_database.cg.dart';
import 'package:beer_logger/core/di/click_repository.cg.dart';
import 'package:beer_logger/core/di/now.cg.dart';
import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Click _recordClick({required String id, required DateTime at}) {
  return Click.record(
    id: ClickId.known(id),
    clickerId: beerHalfLiter().id,
    at: at,
    axes: axisRecordInputsFrom(beerHalfLiter()),
  ).getOrElse((_) => throw StateError('expected Right'));
}

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

/// Ждём emit drift `watch()` после add/undo. Без этого баланс ещё прежний.
Future<void> _flushWatch() => pumpEventQueue();

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.inMemory();
  });

  tearDown(() async {
    // overrideWithValue не вызывает create() — onDispose базы не сработает.
    await db.close();
  });

  group('todayBalance', () {
    test('пустой день → нули по четырём осям, не ошибка', () async {
      final container = _container(db: db, now: DateTime(2026, 8, 24, 12));
      final balances = await container
          .listen(todayBalanceProvider.future, (_, _) {})
          .read();

      _expectPortions(balances, 0);
    });

    test('один тап → цифры одной порции', () async {
      final container = _container(db: db, now: DateTime(2026, 8, 24, 12));
      final repository = container.read(clickRepositoryProvider);
      expect(
        (await repository.addClick(
          _recordClick(id: 'one', at: DateTime(2026, 8, 24, 9)),
        )).isRight(),
        isTrue,
      );

      final balances = await container
          .listen(todayBalanceProvider.future, (_, _) {})
          .read();
      _expectPortions(balances, 1);
    });

    test('несколько тапов → сумма порций', () async {
      final container = _container(db: db, now: DateTime(2026, 8, 24, 12));
      final repository = container.read(clickRepositoryProvider);
      expect(
        (await repository.addClick(
          _recordClick(id: 'a', at: DateTime(2026, 8, 24, 9)),
        )).isRight(),
        isTrue,
      );
      expect(
        (await repository.addClick(
          _recordClick(id: 'b', at: DateTime(2026, 8, 24, 11)),
        )).isRight(),
        isTrue,
      );

      final balances = await container
          .listen(todayBalanceProvider.future, (_, _) {})
          .read();
      _expectPortions(balances, 2);
    });

    test('undo последнего → баланс без этой порции', () async {
      final container = _container(db: db, now: DateTime(2026, 8, 24, 12));
      final repository = container.read(clickRepositoryProvider);
      await repository.addClick(
        _recordClick(id: 'keep', at: DateTime(2026, 8, 24, 9)),
      );
      await repository.addClick(
        _recordClick(id: 'drop', at: DateTime(2026, 8, 24, 11)),
      );

      final balance = container.listen(todayBalanceProvider, (_, _) {});
      _expectPortions(await container.read(todayBalanceProvider.future), 2);

      expect((await repository.undoLastClick()).isRight(), isTrue);
      await _flushWatch();

      _expectPortions(balance.read().requireValue, 1);
    });

    test('вчерашний тап не двигает сегодняшний баланс', () async {
      final now = DateTime(2026, 8, 24, 12);
      final container = _container(db: db, now: now);
      final repository = container.read(clickRepositoryProvider);
      final balance = container.listen(todayBalanceProvider, (_, _) {});
      await container.read(todayBalanceProvider.future);

      // 23-е — предыдущий календарный день относительно now, не «N часов назад».
      await repository.addClick(
        _recordClick(id: 'yesterday', at: DateTime(2026, 8, 23, 18)),
      );
      await repository.addClick(
        _recordClick(id: 'today', at: DateTime(2026, 8, 24, 9)),
      );
      await _flushWatch();

      _expectPortions(balance.read().requireValue, 1);
    });
  });
}
