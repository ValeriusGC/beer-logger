import 'package:beer_logger/bounded_contexts/journal/domain/click/click.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/period_balances.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_projection.freezed.dart';

/// Тапы за сегодня для проекции главной.
class HomeJournalClickList {
  /// Создаёт обёртку над списком [Click].
  const HomeJournalClickList(this.clicks);

  /// Записи журнала за текущий день.
  final List<Click> clicks;
}

/// Состояние карточки баланса без UI-строк.
@freezed
sealed class HomeBalanceProjection with _$HomeBalanceProjection {
  /// Данные баланса ещё грузятся.
  const factory HomeBalanceProjection.loading() = HomeBalanceProjectionLoading;

  /// Загрузка баланса завершилась ошибкой.
  const factory HomeBalanceProjection.error() = HomeBalanceProjectionError;

  /// Итоги за сегодня готовы, в том числе нули за пустой день.
  const factory HomeBalanceProjection.ready(PeriodBalances balances) =
      HomeBalanceProjectionReady;
}

/// Состояние журнала тапов без UI-строк.
@freezed
sealed class HomeJournalProjection with _$HomeJournalProjection {
  /// Список тапов ещё грузится.
  const factory HomeJournalProjection.loading() = HomeJournalProjectionLoading;

  /// Загрузка списка завершилась ошибкой.
  const factory HomeJournalProjection.error() = HomeJournalProjectionError;

  /// За сегодня тапов нет — не ошибка.
  const factory HomeJournalProjection.empty() = HomeJournalProjectionEmpty;

  /// Есть хотя бы один тап за сегодня.
  const factory HomeJournalProjection.items(HomeJournalClickList clicks) =
      HomeJournalProjectionItems;
}

/// Проекция главной: решения Factory без l10n и форматирования.
@freezed
abstract class HomeProjection with _$HomeProjection {
  /// Собирает факты application-слоя в одну проекцию экрана.
  const factory HomeProjection({
    required bool tapEnabled,
    required Clicker buttonClicker,
    required HomeBalanceProjection balance,
    required HomeJournalProjection journal,
    required bool undoEnabled,
  }) = _HomeProjection;
}
