import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/domain_fixtures.dart';

const _beerKinds = [
  LedgerAxisKind.volume,
  LedgerAxisKind.energy,
  LedgerAxisKind.money,
  LedgerAxisKind.joy,
];

DateTime _dayStart(int year, int month, int day) => DateTime(year, month, day);

Click _recordClick({
  required String id,
  required DateTime at,
  double factor = 1,
}) {
  return Click.record(
    id: ClickId.known(id),
    clickerId: beerHalfLiterClicker().id,
    at: at,
    axes: axisRecordInputsFrom(beerHalfLiterClicker()),
    factor: factor,
  ).getOrElse((_) => throw StateError('expected Right'));
}

PeriodBalances _aggregate({
  required List<Click> clicks,
  required DateTime from,
  required DateTime to,
  List<LedgerAxisKind> kinds = _beerKinds,
}) {
  return aggregateForPeriod(
    clicks: clicks,
    kinds: kinds,
    from: from,
    to: to,
  ).getOrElse((_) => throw StateError('expected Right'));
}

void main() {
  final dayFrom = _dayStart(2026, 7, 28);
  final dayTo = _dayStart(2026, 7, 29);

  group('aggregateForPeriod', () {
    test('3 тапа за день — суммы в базовых единицах (spec dashboard)', () {
      final clicks = [
        _recordClick(id: 'c1', at: DateTime(2026, 7, 28, 10)),
        _recordClick(id: 'c2', at: DateTime(2026, 7, 28, 14)),
        _recordClick(id: 'c3', at: DateTime(2026, 7, 28, 20)),
      ];

      final balances = _aggregate(clicks: clicks, from: dayFrom, to: dayTo);

      expect(balances.totalFor(LedgerAxisKind.volume).signedBase, 1500.0);
      expect(balances.totalFor(LedgerAxisKind.energy).signedBase, 300000.0);
      expect(balances.totalFor(LedgerAxisKind.money).signedBase, -45000.0);
      expect(balances.totalFor(LedgerAxisKind.joy).signedBase, 6.0);
    });

    test('1 тап — одна порция', () {
      final balances = _aggregate(
        clicks: [_recordClick(id: 'c1', at: DateTime(2026, 7, 28, 12))],
        from: dayFrom,
        to: dayTo,
      );

      expect(balances.totalFor(LedgerAxisKind.volume).signedBase, 500.0);
      expect(balances.totalFor(LedgerAxisKind.energy).signedBase, 100000.0);
      expect(balances.totalFor(LedgerAxisKind.money).signedBase, -15000.0);
      expect(balances.totalFor(LedgerAxisKind.joy).signedBase, 2.0);
    });

    test('0 тапов — нули по всем kind', () {
      final balances = _aggregate(clicks: [], from: dayFrom, to: dayTo);

      expect(balances.totalFor(LedgerAxisKind.volume).signedBase, 0.0);
      expect(balances.totalFor(LedgerAxisKind.energy).signedBase, 0.0);
      expect(balances.totalFor(LedgerAxisKind.money).signedBase, 0.0);
      expect(balances.totalFor(LedgerAxisKind.joy).signedBase, 0.0);
    });

    test('тапы вне периода — нули', () {
      final clicks = [
        _recordClick(id: 'c1', at: DateTime(2026, 7, 27, 23, 59)),
        _recordClick(id: 'c2', at: DateTime(2026, 7, 29, 0)),
      ];

      final balances = _aggregate(clicks: clicks, from: dayFrom, to: dayTo);

      expect(balances.totalFor(LedgerAxisKind.volume).signedBase, 0.0);
    });

    test('from >= to → Failure.invalidPeriod', () {
      final from = DateTime(2026, 7, 28, 12);
      final to = DateTime(2026, 7, 28, 10);

      final result = aggregateForPeriod(
        clicks: [],
        kinds: _beerKinds,
        from: from,
        to: to,
      );

      expect(
        result,
        Left<Failure, PeriodBalances>(
          Failure.invalidPeriod(from: from, to: to),
        ),
      );
    });

    test('граница: at == from включён', () {
      final balances = _aggregate(
        clicks: [_recordClick(id: 'c1', at: dayFrom)],
        from: dayFrom,
        to: dayTo,
      );

      expect(balances.totalFor(LedgerAxisKind.volume).signedBase, 500.0);
    });

    test('граница: at == to исключён', () {
      final balances = _aggregate(
        clicks: [_recordClick(id: 'c1', at: dayTo)],
        from: dayFrom,
        to: dayTo,
      );

      expect(balances.totalFor(LedgerAxisKind.volume).signedBase, 0.0);
    });

    test('factor=2 на тапе — volume 1000 мл', () {
      final balances = _aggregate(
        clicks: [
          _recordClick(id: 'c1', at: DateTime(2026, 7, 28, 12), factor: 2),
        ],
        from: dayFrom,
        to: dayTo,
      );

      expect(balances.totalFor(LedgerAxisKind.volume).signedBase, 1000.0);
    });

    test('kind вне kinds всё равно попадает в totalsInBase', () {
      final click = _recordClick(id: 'c1', at: DateTime(2026, 7, 28, 12));

      final balances = _aggregate(
        clicks: [click],
        from: dayFrom,
        to: dayTo,
        kinds: [LedgerAxisKind.volume],
      );

      expect(balances.totalFor(LedgerAxisKind.volume).signedBase, 500.0);
      expect(balances.totalFor(LedgerAxisKind.energy).signedBase, 100000.0);
      expect(balances.totalsInBase.containsKey(LedgerAxisKind.money), isTrue);
    });
  });
}
