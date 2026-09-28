import 'package:beer_logger/core/di/app_database.cg.dart';
import 'package:beer_logger/core/di/click_repository.cg.dart';
import 'package:beer_logger/core/di/now.cg.dart';
import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_ledger_core/ledger_axis_kind.dart';
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
ProviderContainer _container({required AppDatabase db, required DateTime now}) {
  return ProviderContainer.test(
    overrides: [
      appDatabaseProvider.overrideWithValue(db),
      nowProvider.overrideWithValue(now),
    ],
  );
}

Future<void> _flushWatch() => pumpEventQueue();

WeekAxisChartSeries _series(
  List<WeekAxisChartSeries> charts,
  LedgerAxisKind kind,
) {
  return charts.firstWhere((series) => series.kind == kind);
}

void main() {
  late AppDatabase db;
  final now = DateTime(2026, 9, 21, 12);

  setUp(() {
    db = AppDatabase.inMemory();
  });

  tearDown(() async {
    await db.close();
  });

  group('weekAxisChartsForLast7Days', () {
    test('пусто → 4 оси, 7 нулей, дни 15…21 сентября', () async {
      final container = _container(db: db, now: now);
      final charts = await container
          .listen(weekAxisChartsForLast7DaysProvider.future, (_, _) {})
          .read();

      expect(charts, hasLength(4));
      for (final series in charts) {
        expect(series.days, hasLength(7));
        expect(
          series.days.map((day) => day.day),
          List.generate(7, (index) => DateTime(2026, 9, 15 + index)),
        );
        expect(series.days.map((day) => day.value), List.filled(7, 0));
      }
    });

    test('тап 21-го → объём 0.5 L, энергия +100, деньги −150, радость +2', () async {
      final container = _container(db: db, now: now);
      final added = await container
          .read(clickRepositoryProvider)
          .addClick(_recordClick(id: 'today', at: DateTime(2026, 9, 21, 18)));
      expect(added.isRight(), isTrue);

      final charts = await container
          .listen(weekAxisChartsForLast7DaysProvider.future, (_, _) {})
          .read();

      expect(_series(charts, LedgerAxisKind.volume).days[6].value, 0.5);
      expect(_series(charts, LedgerAxisKind.energy).days[6].value, 100);
      expect(_series(charts, LedgerAxisKind.money).days[6].value, -150);
      expect(_series(charts, LedgerAxisKind.joy).days[6].value, 2);
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

      final charts = await container
          .listen(weekAxisChartsForLast7DaysProvider.future, (_, _) {})
          .read();

      final volume = _series(charts, LedgerAxisKind.volume);
      expect(volume.days.first.value, 0.5);
      expect(volume.days.first.day, DateTime(2026, 9, 15));
      expect(volume.days.skip(1).map((day) => day.value), List.filled(6, 0));
    });
  });
}
