import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:beer_logger/bounded_contexts/journal/infrastructure/day_boundaries.dart';
import 'package:beer_logger/bounded_contexts/journal/infrastructure/click_mapper.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click_repository.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';

/// Drift-реализация [ClickRepository].
final class DriftClickRepository implements ClickRepository {
  /// [db] — in-memory в тестах, файловая БД в runtime.
  DriftClickRepository(this._db);

  final AppDatabase _db;

  static const _addClickOperation = 'addClick';
  static const _undoLastClickOperation = 'undoLastClick';

  @override
  Future<Result<void>> addClick(Click click) async {
    try {
      await _db.transaction(() async {
        await _db.into(_db.clicks).insert(clickToCompanion(click));
        await _db.batch((batch) {
          batch.insertAll(
            _db.clickContributions,
            contributionsToCompanions(click),
          );
        });
      });
      return const Right(null);
    } on Object catch (error) {
      return Left(Failure.storage(operation: _addClickOperation, cause: error));
    }
  }

  @override
  Stream<List<Click>> watchClicksForDay(DateTime dayLocal) {
    final (:startUtcMs, :endUtcMs) = localDayUtcRange(dayLocal);
    return _watchUtcRange(startUtcMs, endUtcMs);
  }

  @override
  Stream<List<Click>> watchClicksInRange({
    required DateTime fromLocal,
    required DateTime toLocal,
  }) {
    final fromDay = DateTime(fromLocal.year, fromLocal.month, fromLocal.day);
    final toDay = DateTime(toLocal.year, toLocal.month, toLocal.day);
    if (!fromDay.isBefore(toDay)) {
      return Stream.value(const []);
    }

    final (:startUtcMs, :endUtcMs) = localDaysUtcRange(
      fromLocal: fromLocal,
      toLocal: toLocal,
    );
    return _watchUtcRange(startUtcMs, endUtcMs);
  }

  Stream<List<Click>> _watchUtcRange(int startUtcMs, int endUtcMs) {
    final query = _db.select(_db.clicks)
      ..where(
        (row) =>
            row.atUtcMs.isBiggerOrEqualValue(startUtcMs) &
            row.atUtcMs.isSmallerThanValue(endUtcMs),
      )
      ..orderBy([
        (row) => OrderingTerm.desc(row.atUtcMs),
        (row) => OrderingTerm.desc(row.id),
      ]);

    return query.watch().asyncMap(_clicksFromRows);
  }

  Future<List<Click>> _clicksFromRows(List<ClickRow> rows) async {
    final clicks = <Click>[];
    for (final row in rows) {
      final contributions = await (_db.select(
        _db.clickContributions,
      )..where((t) => t.clickId.equals(row.id))).get();
      clicks.add(clickFromRows(row: row, contributions: contributions));
    }
    return clicks;
  }

  @override
  Future<Result<void>> undoLastClick() async {
    try {
      await _db.transaction(() async {
        final last =
            await (_db.select(_db.clicks)
                  ..orderBy([
                    (row) => OrderingTerm.desc(row.atUtcMs),
                    (row) => OrderingTerm.desc(row.id),
                  ])
                  ..limit(1))
                .getSingleOrNull();
        if (last == null) {
          return;
        }
        await (_db.delete(_db.clicks)..where((t) => t.id.equals(last.id))).go();
      });
      return const Right(null);
    } on Object catch (error) {
      return Left(
        Failure.storage(operation: _undoLastClickOperation, cause: error),
      );
    }
  }
}
