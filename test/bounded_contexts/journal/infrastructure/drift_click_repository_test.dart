import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:beer_logger/bounded_contexts/journal/infrastructure/click_mapper.dart';
import 'package:beer_logger/bounded_contexts/journal/infrastructure/drift_click_repository.dart';
import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter_test/flutter_test.dart';

Click _recordClick({
  required String id,
  required DateTime at,
  double factor = 1,
}) {
  return Click.record(
    id: ClickId.known(id),
    clickerId: beerHalfLiter().id,
    at: at,
    axes: axisRecordInputsFrom(beerHalfLiter()),
    factor: factor,
  ).getOrElse((_) => throw StateError('expected Right'));
}

Click _withContributionsSortedByKind(Click click) {
  final contributions = [...click.contributions]
    ..sort((a, b) => a.kind.index.compareTo(b.kind.index));
  return click.copyWith(contributions: contributions);
}

Future<Click?> _readClickFromDb(AppDatabase db, String id) async {
  final row = await (db.select(
    db.clicks,
  )..where((t) => t.id.equals(id))).getSingleOrNull();
  if (row == null) return null;

  final contributions = await (db.select(
    db.clickContributions,
  )..where((t) => t.clickId.equals(id))).get();

  return clickFromRows(row: row, contributions: contributions);
}

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.inMemory();
  });

  tearDown(() async {
    await db.close();
  });

  group('DriftClickRepository.addClick', () {
    test('happy path: Click идентичен после read из tables', () async {
      final click = _recordClick(
        id: 'click-persist',
        at: DateTime(2026, 7, 28, 18, 30),
        factor: 2,
      );
      final repository = DriftClickRepository(db);

      final result = await repository.addClick(click);

      expect(result.isRight(), isTrue);
      final restored = await _readClickFromDb(db, click.id.value);
      expect(restored, isNotNull);
      expect(
        _withContributionsSortedByKind(restored!),
        _withContributionsSortedByKind(click),
      );
    });

    test('duplicate id → Failure.storage', () async {
      final click = _recordClick(
        id: 'click-dup',
        at: DateTime(2026, 7, 28, 12),
      );
      final repository = DriftClickRepository(db);

      expect((await repository.addClick(click)).isRight(), isTrue);

      final duplicate = await repository.addClick(click);

      expect(duplicate.isLeft(), isTrue);
      duplicate.fold((failure) {
        expect(failure, isA<StorageFailure>());
        final storage = failure as StorageFailure;
        expect(storage.operation, 'addClick');
        expect(storage.cause, isNotNull);
      }, (_) => fail('expected Left(Failure.storage)'));
    });
  });

  group('DriftClickRepository.watchClicksForDay', () {
    test('пустой день → stream emits []', () async {
      final repository = DriftClickRepository(db);

      expect(
        await repository.watchClicksForDay(DateTime(2026, 7, 28)).first,
        isEmpty,
      );
    });

    test('23:59 дня D виден в D; 00:01 дня D+1 — только в D+1', () async {
      final repository = DriftClickRepository(db);
      final dayD = DateTime(2026, 7, 28);

      final lateTap = _recordClick(
        id: 'click-late',
        at: DateTime(2026, 7, 28, 23, 59),
      );
      final earlyTap = _recordClick(
        id: 'click-early',
        at: DateTime(2026, 7, 29, 0, 1),
      );

      await repository.addClick(lateTap);
      await repository.addClick(earlyTap);

      final clicksOnD = await repository.watchClicksForDay(dayD).first;
      expect(clicksOnD.map((click) => click.id.value), ['click-late']);

      final clicksOnDPlus1 = await repository
          .watchClicksForDay(DateTime(2026, 7, 29))
          .first;
      expect(clicksOnDPlus1.map((click) => click.id.value), ['click-early']);
    });

    test('после addClick stream получает обновление', () async {
      final repository = DriftClickRepository(db);
      final day = DateTime(2026, 7, 28);
      final click = _recordClick(
        id: 'click-stream',
        at: DateTime(2026, 7, 28, 15),
      );

      final expectation = expectLater(
        repository.watchClicksForDay(day),
        emitsInOrder([
          isEmpty,
          [_withContributionsSortedByKind(click)],
        ]),
      );

      await pumpEventQueue();
      expect((await repository.addClick(click)).isRight(), isTrue);
      await expectation;
    });

    test('после undoLastClick stream получает обновление', () async {
      final repository = DriftClickRepository(db);
      final day = DateTime(2026, 7, 28);
      final first = _recordClick(
        id: 'click-keep',
        at: DateTime(2026, 7, 28, 10),
      );
      final last = _recordClick(
        id: 'click-drop',
        at: DateTime(2026, 7, 28, 15),
      );

      await repository.addClick(first);
      await repository.addClick(last);

      final expectation = expectLater(
        repository.watchClicksForDay(day),
        emitsInOrder([
          [
            _withContributionsSortedByKind(last),
            _withContributionsSortedByKind(first),
          ],
          [_withContributionsSortedByKind(first)],
        ]),
      );

      await pumpEventQueue();
      expect((await repository.undoLastClick()).isRight(), isTrue);
      await expectation;
    });
  });

  group('DriftClickRepository.watchClicksInRange', () {
    test('сегодня-6 и сегодня входят; сегодня-7 и завтра — нет', () async {
      final repository = DriftClickRepository(db);
      await repository.addClick(
        _recordClick(id: 'out', at: DateTime(2026, 9, 14, 12)),
      );
      await repository.addClick(
        _recordClick(id: 'oldest', at: DateTime(2026, 9, 15, 0, 1)),
      );
      await repository.addClick(
        _recordClick(id: 'today', at: DateTime(2026, 9, 21, 23, 59)),
      );
      await repository.addClick(
        _recordClick(id: 'tomorrow', at: DateTime(2026, 9, 22, 0, 1)),
      );

      final clicks = await repository
          .watchClicksInRange(
            fromLocal: DateTime(2026, 9, 15, 8),
            toLocal: DateTime(2026, 9, 22, 8),
          )
          .first;

      expect(clicks.map((click) => click.id.value), ['today', 'oldest']);
    });

    test('from не раньше to → пустой поток', () async {
      final repository = DriftClickRepository(db);
      await repository.addClick(
        _recordClick(id: 'kept', at: DateTime(2026, 9, 21, 12)),
      );

      final sameDay = await repository
          .watchClicksInRange(
            fromLocal: DateTime(2026, 9, 21, 1),
            toLocal: DateTime(2026, 9, 21, 23),
          )
          .first;
      final reversed = await repository
          .watchClicksInRange(
            fromLocal: DateTime(2026, 9, 22),
            toLocal: DateTime(2026, 9, 15),
          )
          .first;

      expect(sameDay, isEmpty);
      expect(reversed, isEmpty);
    });
  });

  group('DriftClickRepository.undoLastClick', () {
    test('пустой журнал → Right(null), таблица пуста', () async {
      final repository = DriftClickRepository(db);

      final result = await repository.undoLastClick();

      expect(result.isRight(), isTrue);
      expect(await db.select(db.clicks).get(), isEmpty);
    });

    test('один тап: Click и contributions удалены', () async {
      final click = _recordClick(
        id: 'click-undo-one',
        at: DateTime(2026, 7, 28, 12),
      );
      final repository = DriftClickRepository(db);
      expect((await repository.addClick(click)).isRight(), isTrue);

      expect((await repository.undoLastClick()).isRight(), isTrue);

      expect(await _readClickFromDb(db, click.id.value), isNull);
      expect(
        await (db.select(
          db.clickContributions,
        )..where((t) => t.clickId.equals(click.id.value))).get(),
        isEmpty,
      );
    });

    test('из N тапов уходит самый поздний по at', () async {
      final early = _recordClick(
        id: 'click-early-undo',
        at: DateTime(2026, 7, 28, 10),
      );
      final late = _recordClick(
        id: 'click-late-undo',
        at: DateTime(2026, 7, 28, 18),
      );
      final repository = DriftClickRepository(db);
      await repository.addClick(early);
      await repository.addClick(late);

      expect((await repository.undoLastClick()).isRight(), isTrue);

      expect(await _readClickFromDb(db, late.id.value), isNull);
      expect(await _readClickFromDb(db, early.id.value), isNotNull);
    });

    test('одинаковое at → удаляется id DESC', () async {
      final at = DateTime(2026, 7, 28, 12);
      final lowerId = _recordClick(id: 'click-aaa', at: at);
      final higherId = _recordClick(id: 'click-zzz', at: at);
      final repository = DriftClickRepository(db);
      await repository.addClick(lowerId);
      await repository.addClick(higherId);

      expect((await repository.undoLastClick()).isRight(), isTrue);

      expect(await _readClickFromDb(db, higherId.id.value), isNull);
      expect(await _readClickFromDb(db, lowerId.id.value), isNotNull);
    });

    test('ошибка БД → Failure.storage', () async {
      final repository = DriftClickRepository(db);
      await db.customStatement('DROP TABLE clicks');

      final result = await repository.undoLastClick();

      expect(result.isLeft(), isTrue);
      result.fold((failure) {
        expect(failure, isA<StorageFailure>());
        final storage = failure as StorageFailure;
        expect(storage.operation, 'undoLastClick');
        expect(storage.cause, isNotNull);
      }, (_) => fail('expected Left(Failure.storage)'));
    });
  });
}
