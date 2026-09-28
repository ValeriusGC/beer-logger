import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_projection.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_ui_model.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/today_balance_format.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/today_clicks_format.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

/// Форматирует срезы [HomeProjection] в UiModel. Единственное место `formatToday*`.
class HomeUiModelBuilder {
  /// Карточка баланса.
  static HomeBalanceUiModel balance({
    required HomeBalanceProjection projection,
    required AppLocalizations l10n,
    required String languageCode,
  }) {
    return _balanceUiModel(projection, l10n: l10n, languageCode: languageCode);
  }

  /// Журнал тапов за сегодня.
  static HomeJournalUiModel journal({
    required HomeJournalProjection projection,
    required AppLocalizations l10n,
    required Locale locale,
  }) {
    return _journalUiModel(projection, l10n: l10n, locale: locale);
  }

  /// Подпись кнопки записи: объём текущей порции.
  static String tapLabel({
    required Clicker clicker,
    required AppLocalizations l10n,
    required String languageCode,
  }) {
    return l10n.recordBeerTap(
      formatRecordBeerVolume(clicker, languageCode: languageCode),
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
        compactLine: formatTodayBalanceCompact(
          balances,
          languageCode: languageCode,
        ),
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
