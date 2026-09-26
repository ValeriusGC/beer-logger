import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:beer_logger/bounded_contexts/portion/infrastructure/clicker_settings_mapper.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker_id.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker_settings_repository.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';

/// Drift-реализация [ClickerSettingsRepository].
final class DriftClickerSettingsRepository
    implements ClickerSettingsRepository {
  /// [db] — in-memory в тестах, файловая БД в runtime.
  DriftClickerSettingsRepository(this._db);

  final AppDatabase _db;

  static const _saveOperation = 'saveClicker';

  @override
  Stream<Clicker> watchClicker(ClickerId id) async* {
    final query = _db.select(_db.clickerSettings)
      ..where((row) => row.clickerId.equals(id.value));
    var seeded = false;

    await for (final rows in query.watch()) {
      if (rows.isEmpty) {
        if (seeded) continue;
        seeded = true;
        await _db.ensurePresetClickerSettings();
        final row = await query.getSingleOrNull();
        if (row != null) yield clickerFromSettingsRow(row);
        continue;
      }
      yield clickerFromSettingsRow(rows.single);
    }
  }

  @override
  Future<Result<void>> saveClicker(Clicker clicker) async {
    try {
      await _db
          .into(_db.clickerSettings)
          .insert(
            ClickerSettingsCompanion.insert(
              clickerId: clicker.id.value,
              volumeEntered: _entered(clicker, LedgerAxisKind.volume),
              energyEntered: _entered(clicker, LedgerAxisKind.energy),
              moneyEntered: _entered(clicker, LedgerAxisKind.money),
              joyEntered: _entered(clicker, LedgerAxisKind.joy),
            ),
            mode: InsertMode.insertOrReplace,
          );
      return const Right(null);
    } on Object catch (error) {
      return Left(Failure.storage(operation: _saveOperation, cause: error));
    }
  }

  static double _entered(Clicker clicker, LedgerAxisKind kind) {
    return clicker.axes.firstWhere((axis) => axis.kind == kind).enteredValue;
  }
}
