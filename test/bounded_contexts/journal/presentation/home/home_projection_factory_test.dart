import 'package:beer_logger/bounded_contexts/journal/domain/click/click.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/period_balances.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/signed_base_delta.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_projection.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_projection_factory.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/beer_half_liter.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

PeriodBalances _emptyBalances() {
  return PeriodBalances(
    totalsInBase: {
      LedgerAxisKind.volume: SignedBaseDelta.volume(0),
      LedgerAxisKind.energy: SignedBaseDelta.energy(0),
      LedgerAxisKind.money: SignedBaseDelta.money(0),
      LedgerAxisKind.joy: SignedBaseDelta.joy(0),
    },
  );
}

HomeProjection _projection({
  AsyncValue<PeriodBalances>? balance,
  AsyncValue<List<Click>>? clicks,
  AsyncValue<void>? record,
  AsyncValue<Clicker>? clicker,
  AsyncValue<void>? undo,
}) {
  balance ??= const AsyncLoading();
  clicks ??= const AsyncLoading();
  record ??= const AsyncData(null);
  clicker ??= AsyncData(beerHalfLiter());
  undo ??= const AsyncData(null);
  return HomeProjectionFactory.from(
    balance: balance,
    clicks: clicks,
    record: record,
    clicker: clicker,
    undo: undo,
  );
}

void main() {
  test('clicker loading — tapEnabled false', () {
    final projection = _projection(clicker: const AsyncLoading());

    expect(projection.tapEnabled, isFalse);
  });

  test('clicks AsyncData([]) — журнал empty, не items', () {
    final projection = _projection(clicks: const AsyncData([]));

    expect(projection.journal, isA<HomeJournalProjectionEmpty>());
  });

  test('balance AsyncData с нулями — ready, не error', () {
    final projection = _projection(
      balance: AsyncData(_emptyBalances()),
      clicks: const AsyncData([]),
    );

    expect(projection.balance, isA<HomeBalanceProjectionReady>());
  });

  test('balance AsyncLoading — loading', () {
    final projection = _projection(balance: const AsyncLoading());

    expect(projection.balance, isA<HomeBalanceProjectionLoading>());
  });
}
