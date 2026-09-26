import 'package:beer_logger/core/di/app_database.cg.dart';
import 'package:beer_logger/core/di/click_repository.cg.dart';
import 'package:beer_logger/core/di/now.cg.dart';
import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
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

List<String> _ids(List<Click> clicks) =>
    clicks.map((click) => click.id.value).toList();

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

/// Ждём emit drift `watch()` после add/undo. Без этого снимок списка ещё прежний.
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

  group('clicksForToday', () {
    test('пустой день → пустой список, не ошибка', () async {
      final container = _container(db: db, now: DateTime(2026, 8, 24, 12));
      final clicks = await container
          .listen(clicksForTodayProvider.future, (_, _) {})
          .read();

      expect(clicks, isEmpty);
    });

    test('тап сегодня → список обновляется', () async {
      final container = _container(db: db, now: DateTime(2026, 8, 24, 12));
      final today = container.listen(clicksForTodayProvider, (_, _) {});
      expect(await container.read(clicksForTodayProvider.future), isEmpty);

      final added = await container
          .read(clickRepositoryProvider)
          .addClick(_recordClick(id: 'today', at: DateTime(2026, 8, 24, 9)));
      expect(added.isRight(), isTrue);
      await _flushWatch();

      expect(_ids(today.read().requireValue), ['today']);
    });

    test('undo последнего → список обновляется', () async {
      final container = _container(db: db, now: DateTime(2026, 8, 24, 12));
      final repository = container.read(clickRepositoryProvider);
      expect(
        (await repository.addClick(
          _recordClick(id: 'to-undo', at: DateTime(2026, 8, 24, 9)),
        )).isRight(),
        isTrue,
      );

      final today = container.listen(clicksForTodayProvider, (_, _) {});
      expect(_ids(await container.read(clicksForTodayProvider.future)), [
        'to-undo',
      ]);

      expect((await repository.undoLastClick()).isRight(), isTrue);
      await _flushWatch();

      expect(_ids(today.read().requireValue), isEmpty);
    });

    test('вчерашний тап не в сегодняшнем списке', () async {
      final now = DateTime(2026, 8, 24, 12);
      final container = _container(db: db, now: now);
      final repository = container.read(clickRepositoryProvider);
      final today = container.listen(clicksForTodayProvider, (_, _) {});
      await container.read(clicksForTodayProvider.future);

      // 23-е — предыдущий календарный день относительно now, не «N часов назад».
      await repository.addClick(
        _recordClick(id: 'yesterday', at: DateTime(2026, 8, 23, 18)),
      );
      await repository.addClick(
        _recordClick(id: 'today', at: DateTime(2026, 8, 24, 9)),
      );
      await _flushWatch();

      expect(_ids(today.read().requireValue), ['today']);
    });

    test('тап после полуночи при подменённом now', () async {
      // «Сейчас» уже 25-е; 23:59 24-го для журнала — вчера.
      final container = _container(db: db, now: DateTime(2026, 8, 25, 0, 1));
      final repository = container.read(clickRepositoryProvider);
      final today = container.listen(clicksForTodayProvider, (_, _) {});
      await container.read(clicksForTodayProvider.future);

      await repository.addClick(
        _recordClick(id: 'before-midnight', at: DateTime(2026, 8, 24, 23, 59)),
      );
      await repository.addClick(
        _recordClick(id: 'after-midnight', at: DateTime(2026, 8, 25, 0, 1)),
      );
      await _flushWatch();

      expect(_ids(today.read().requireValue), ['after-midnight']);
    });
  });
}
