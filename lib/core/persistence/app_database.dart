import 'package:beer_logger/bounded_contexts/portion/domain/clicker/beer_half_liter.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Тап в SQLite. Data class — [ClickRow], не domain [Click].
@DataClassName('ClickRow')
@TableIndex(
  name: 'idx_clicks_at',
  columns: {IndexedColumn(#atUtcMs, orderBy: OrderingMode.desc)},
)
class Clicks extends Table {
  /// UUID v4 строкой.
  TextColumn get id => text()();

  /// Ссылка на preset/config clicker.
  TextColumn get clickerId => text()();

  /// Момент тапа — UTC, миллисекунды с epoch.
  IntColumn get atUtcMs => integer()();

  /// Множитель тапа.
  RealColumn get factor => real().withDefault(const Constant(1.0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Вклад оси по тапу. Data class — [ClickContributionRow].
@DataClassName('ClickContributionRow')
class ClickContributions extends Table {
  TextColumn get clickId =>
      text().references(Clicks, #id, onDelete: KeyAction.cascade)();

  /// Wire: `volume`, `energy`, `money`, `joy`.
  TextColumn get kind => text()();

  /// Факт в базовой единице × знак.
  RealColumn get signedBaseDelta => real()();

  /// Wire-id единицы ввода для UI.
  TextColumn get enteredInId => text()();

  @override
  Set<Column<Object>> get primaryKey => {clickId, kind};
}

/// Текущая порция clicker.
///
/// Data class — [ClickerSettingsRow], не domain [Clicker]. В строке только
/// четыре введённых числа. Название, единицы и знаки при сборке [Clicker]
/// берутся с [beerHalfLiter].
@DataClassName('ClickerSettingsRow')
class ClickerSettings extends Table {
  /// Id пресета, v1 — `clicker-beer`.
  TextColumn get clickerId => text()();

  /// Объём в литрах, как на оси пресета.
  RealColumn get volumeEntered => real()();

  /// Ккал, как на оси пресета.
  RealColumn get energyEntered => real()();

  /// Цена в рублях, величина без знака. Знак оси остаётся minus.
  RealColumn get moneyEntered => real()();

  /// Радость в пунктах пресета.
  RealColumn get joyEntered => real()();

  @override
  Set<Column<Object>> get primaryKey => {clickerId};
}

/// Локальная SQLite БД тапов.
@DriftDatabase(tables: [Clicks, ClickContributions, ClickerSettings])
class AppDatabase extends _$AppDatabase {
  /// Файловая БД приложения.
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// In-memory БД для unit-тестов.
  AppDatabase.inMemory()
    : super(
        NativeDatabase.memory(
          setup: (raw) => raw.execute('PRAGMA foreign_keys = ON'),
        ),
      );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
      await ensurePresetClickerSettings();
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// Кладёт строку пресета, если её ещё нет.
  ///
  /// `insertOrIgnore`: повторный вызов и гонка двух читателей не затирают
  /// уже сохранённую порцию и не роняют открытие базы.
  Future<void> ensurePresetClickerSettings() {
    final preset = beerHalfLiter();
    return into(clickerSettings).insert(
      ClickerSettingsCompanion.insert(
        clickerId: preset.id.value,
        volumeEntered: _presetEntered(preset, LedgerAxisKind.volume),
        energyEntered: _presetEntered(preset, LedgerAxisKind.energy),
        moneyEntered: _presetEntered(preset, LedgerAxisKind.money),
        joyEntered: _presetEntered(preset, LedgerAxisKind.joy),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }

  static double _presetEntered(Clicker preset, LedgerAxisKind kind) {
    return preset.axes.firstWhere((axis) => axis.kind == kind).enteredValue;
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'beer_logger',
      native: DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
        setup: (raw) => raw.execute('PRAGMA foreign_keys = ON'),
      ),
    );
  }
}
