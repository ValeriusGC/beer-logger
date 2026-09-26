import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_projection.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_ui_model.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/today_balance_format.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/today_clicks_format.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

/// Переводит [HomeProjection] в [HomeUiModel] с l10n и форматтерами.
class HomeUiModelBuilder {
  /// Единственное место вызова `formatToday*` и `formatRecordBeerVolume`.
  static HomeUiModel build({
    required HomeProjection projection,
    required AppLocalizations l10n,
    required Locale locale,
  }) {
    return HomeUiModel(
      balance: _balanceUiModel(
        projection.balance,
        l10n: l10n,
        languageCode: locale.languageCode,
      ),
      journal: _journalUiModel(projection.journal, l10n: l10n, locale: locale),
      tapEnabled: projection.tapEnabled,
      tapLabel: l10n.recordBeerTap(
        formatRecordBeerVolume(
          projection.buttonClicker,
          languageCode: locale.languageCode,
        ),
      ),
      undoEnabled: projection.undoEnabled,
      undoLabel: l10n.undoLastTap,
    );
  }

  static HomeBalanceUiModel _balanceUiModel(
    HomeBalanceProjection balance, {
    required AppLocalizations l10n,
    required String languageCode,
  }) {
    return switch (balance) {
      HomeBalanceProjectionLoading() => const HomeBalanceUiLoading(),
      HomeBalanceProjectionError() => HomeBalanceUiError(
        l10n.todayBalanceLoadError,
      ),
      HomeBalanceProjectionReady(:final balances) => HomeBalanceUiLines(
        formatTodayBalanceLines(balances, languageCode: languageCode),
      ),
    };
  }

  static HomeJournalUiModel _journalUiModel(
    HomeJournalProjection journal, {
    required AppLocalizations l10n,
    required Locale locale,
  }) {
    return switch (journal) {
      HomeJournalProjectionLoading() => const HomeJournalUiLoading(),
      HomeJournalProjectionError() => HomeJournalUiError(
        l10n.todayClicksLoadError,
      ),
      HomeJournalProjectionEmpty() => HomeJournalUiEmpty(l10n.todayClicksEmpty),
      HomeJournalProjectionItems(:final clicks) => HomeJournalUiRows([
        for (final click in clicks.clicks)
          (
            id: click.id.value,
            time: formatTodayClickTime(click, locale),
            volume: formatTodayClickVolume(
              click,
              languageCode: locale.languageCode,
            ),
          ),
      ]),
    };
  }
}
