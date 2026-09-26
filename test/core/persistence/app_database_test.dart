import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.inMemory();
  });

  tearDown(() async {
    await db.close();
  });

  test('fresh db — schema 1 и seed пресета', () async {
    expect(db.schemaVersion, 1);
    final row = await db.select(db.clickerSettings).getSingle();
    final preset = beerHalfLiter();
    expect(row.clickerId, preset.id.value);
    expect(row.volumeEntered, 0.5);
    expect(row.energyEntered, 100);
    expect(row.moneyEntered, 150);
    expect(row.joyEntered, 2);
  });

  test('customSelect runs without error', () async {
    final row = await db.customSelect('SELECT 1 AS x').getSingle();
    expect(row.read<int>('x'), 1);
  });
}
