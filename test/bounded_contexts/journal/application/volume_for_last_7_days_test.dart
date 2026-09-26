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

Future<void> _flushWatch() => pumpEventQueue();

void main() {
  late AppDatabase db;
  final now = DateTime(2026, 9, 21, 12);

  setUp(() {
    db = AppDatabase.inMemory();
  });

  tearDown(() async {
    await db.close();
  });

  group('volumeForLast7Days', () {
    test('пусто → 7 нулей, дни 15…21 сентября', () async {
      final container = _container(db: db, now: now);
      final volumes = await container
          .listen(volumeForLast7DaysProvider.future, (_, _) {})
          .read();

      expect(volumes, hasLength(7));
      expect(
        volumes.map((day) => day.day),
        List.generate(7, (index) => DateTime(2026, 9, 15 + index)),
      );
      expect(volumes.map((day) => day.liters), List.filled(7, 0));
    });

    test('тап 21-го 0.5 L → бар 6, остальные нули', () async {
      final container = _container(db: db, now: now);
      final added = await container
          .read(clickRepositoryProvider)
          .addClick(_recordClick(id: 'today', at: DateTime(2026, 9, 21, 18)));
      expect(added.isRight(), isTrue);

      final volumes = await container
          .listen(volumeForLast7DaysProvider.future, (_, _) {})
          .read();

      expect(volumes[6].liters, 0.5);
      expect(volumes[6].day, DateTime(2026, 9, 21));
      expect(volumes.take(6).map((day) => day.liters), List.filled(6, 0));
    });

    test('тап 15-го входит, тап 14-го нет', () async {
      final container = _container(db: db, now: now);
      final repository = container.read(clickRepositoryProvider);
      expect(
        (await repository.addClick(
          _recordClick(id: 'edge', at: DateTime(2026, 9, 15, 9)),
        )).isRight(),
        isTrue,
      );
      expect(
        (await repository.addClick(
          _recordClick(id: 'out', at: DateTime(2026, 9, 14, 23)),
        )).isRight(),
        isTrue,
      );
      await _flushWatch();

      final volumes = await container
          .listen(volumeForLast7DaysProvider.future, (_, _) {})
          .read();

      expect(volumes.first.liters, 0.5);
      expect(volumes.first.day, DateTime(2026, 9, 15));
      expect(volumes.skip(1).map((day) => day.liters), List.filled(6, 0));
    });
  });
}
