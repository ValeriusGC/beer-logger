import 'package:beer_logger/bounded_contexts/portion/infrastructure/drift_clicker_settings_repository.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter_test/flutter_test.dart';

double _entered(Clicker clicker, LedgerAxisKind kind) {
  return clicker.axes.firstWhere((axis) => axis.kind == kind).enteredValue;
}

Clicker _clickerWithEntered({
  required Clicker current,
  double? volume,
  double? energy,
  double? money,
  double? joy,
}) {
  return current.copyWith(
    axes: [
      for (final axis in current.axes)
        switch (axis.kind) {
          LedgerAxisKind.volume => axis.copyWith(
            enteredValue: volume ?? axis.enteredValue,
          ),
          LedgerAxisKind.energy => axis.copyWith(
            enteredValue: energy ?? axis.enteredValue,
          ),
          LedgerAxisKind.money => axis.copyWith(
            enteredValue: money ?? axis.enteredValue,
          ),
          LedgerAxisKind.joy => axis.copyWith(
            enteredValue: joy ?? axis.enteredValue,
          ),
        },
    ],
  );
}

void main() {
  late AppDatabase db;
  late DriftClickerSettingsRepository repository;

  setUp(() {
    db = AppDatabase.inMemory();
    repository = DriftClickerSettingsRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('нет строки — один seed, watch отдаёт пресет', () async {
    await db.delete(db.clickerSettings).go();

    final clicker = await repository.watchClicker(beerHalfLiter().id).first;

    expect(clicker.id, beerHalfLiter().id);
    expect(_entered(clicker, LedgerAxisKind.volume), 0.5);
    expect(_entered(clicker, LedgerAxisKind.energy), 100);
    expect(_entered(clicker, LedgerAxisKind.money), 150);
    expect(_entered(clicker, LedgerAxisKind.joy), 2);
    expect(
      clicker.axes.firstWhere((axis) => axis.kind == LedgerAxisKind.money).sign,
      AxisSign.minus,
    );
    final rows = await db.select(db.clickerSettings).get();
    expect(rows, hasLength(1));
  });

  test('save energy 180 не стирает остальные поля', () async {
    final current = await repository.watchClicker(beerHalfLiter().id).first;
    final updated = _clickerWithEntered(
      current: current,
      volume: 0.5,
      energy: 180,
      money: 150,
      joy: 2,
    );

    final saved = await repository.saveClicker(updated);

    expect(saved.isRight(), isTrue);
    final again = await repository.watchClicker(beerHalfLiter().id).first;
    expect(_entered(again, LedgerAxisKind.energy), 180);
    expect(_entered(again, LedgerAxisKind.volume), 0.5);
    expect(_entered(again, LedgerAxisKind.money), 150);
    expect(_entered(again, LedgerAxisKind.joy), 2);
    expect(
      again.axes.firstWhere((axis) => axis.kind == LedgerAxisKind.money).sign,
      AxisSign.minus,
    );
    expect(
      again.axes
          .firstWhere((axis) => axis.kind == LedgerAxisKind.energy)
          .enteredInId,
      EnergyUnit.kilocalorie.id,
    );
  });

  test('закрытая БД — Failure.storage saveClicker', () async {
    final clicker = await repository.watchClicker(beerHalfLiter().id).first;
    await db.close();

    final result = await repository.saveClicker(clicker);

    expect(
      result.fold((failure) => failure, (_) => null),
      isA<StorageFailure>().having(
        (failure) => failure.operation,
        'operation',
        'saveClicker',
      ),
    );
  });
}
