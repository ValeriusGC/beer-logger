import 'package:beer_logger/core/di/app_database.cg.dart';
import 'package:beer_logger/core/di/click_repository.cg.dart';
import 'package:beer_logger/core/di/now.cg.dart';
import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Click _record({required String id, required DateTime at}) {
  return Click.record(
    id: ClickId.known(id),
    clickerId: beerHalfLiter().id,
    at: at,
    axes: axisRecordInputsFrom(beerHalfLiter()),
  ).getOrElse((_) => throw StateError('expected Right'));
}

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
  final now = DateTime(2026, 8, 24, 12);

  setUp(() {
    db = AppDatabase.inMemory();
  });

  tearDown(() async {
    await db.close();
  });

  group('UndoLastClick', () {
    test('два тапа → undo → остался не последний по времени', () async {
      final container = _container(db: db, now: now);
      final repository = container.read(clickRepositoryProvider);
      final early = _record(id: 'click-early', at: DateTime(2026, 8, 24, 10));
      final late = _record(id: 'click-late', at: DateTime(2026, 8, 24, 18));
      expect((await repository.addClick(early)).isRight(), isTrue);
      expect((await repository.addClick(late)).isRight(), isTrue);

      container.listen(undoLastClickProvider, (_, _) {});
      container.listen(clicksForTodayProvider, (_, _) {});
      await container.read(clicksForTodayProvider.future);

      await container.read(undoLastClickProvider.notifier).undo();
      await _flushWatch();

      expect(
        (await container.read(clicksForTodayProvider.future)).map((c) => c.id),
        [early.id],
      );
    });
  });
}
