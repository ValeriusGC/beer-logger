import 'package:beer_logger/bounded_contexts/journal/domain/click/click.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/period_balances.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_projection.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/beer_half_liter.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Собирает [HomeProjection] из AsyncValue application-провайдеров.
class HomeProjectionFactory {
  /// Решения loading/error/empty и флаги кнопок — только здесь.
  static HomeProjection from({
    required AsyncValue<PeriodBalances> balance,
    required AsyncValue<List<Click>> clicks,
    required AsyncValue<void> record,
    required AsyncValue<Clicker> clicker,
    required AsyncValue<void> undo,
  }) {
    final balanceProjection = balance.when(
      loading: () => const HomeBalanceProjection.loading(),
      error: (_, _) => const HomeBalanceProjection.error(),
      data: HomeBalanceProjection.ready,
    );

    final journalProjection = clicks.when(
      loading: () => const HomeJournalProjection.loading(),
      error: (_, _) => const HomeJournalProjection.error(),
      data: (items) => items.isEmpty
          ? const HomeJournalProjection.empty()
          : HomeJournalProjection.items(HomeJournalClickList(items)),
    );

    return HomeProjection(
      tapEnabled: !record.isLoading && !clicker.isLoading,
      buttonClicker: clicker.asData?.value ?? beerHalfLiter(),
      balance: balanceProjection,
      journal: journalProjection,
      undoEnabled: !undo.isLoading,
    );
  }
}
