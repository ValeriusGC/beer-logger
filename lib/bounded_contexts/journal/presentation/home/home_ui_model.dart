import 'package:beer_logger/bounded_contexts/journal/presentation/today_balance_format.dart';

/// Строка журнала тапов для dumb-виджета.
typedef HomeJournalRowUiModel = ({String id, String time, String? volume});

/// Состояние карточки баланса для отрисовки.
sealed class HomeBalanceUiModel {
  const HomeBalanceUiModel();
}

/// Карточка баланса ждёт данные.
final class HomeBalanceUiLoading extends HomeBalanceUiModel {
  const HomeBalanceUiLoading();
}

/// Карточка баланса не загрузилась.
final class HomeBalanceUiError extends HomeBalanceUiModel {
  /// Текст ошибки из l10n.
  const HomeBalanceUiError(this.message);

  /// Готовая подпись для пользователя.
  final String message;
}

/// Карточка баланса с отформатированными строками осей.
final class HomeBalanceUiLines extends HomeBalanceUiModel {
  /// Четыре подписи: объём, энергия, деньги, радость.
  const HomeBalanceUiLines(this.lines);

  /// Строки карточки в порядке пресета.
  final TodayBalanceLines lines;
}

/// Состояние журнала тапов для отрисовки.
sealed class HomeJournalUiModel {
  const HomeJournalUiModel();
}

/// Журнал ждёт данные.
final class HomeJournalUiLoading extends HomeJournalUiModel {
  const HomeJournalUiLoading();
}

/// Журнал не загрузился.
final class HomeJournalUiError extends HomeJournalUiModel {
  /// Текст ошибки из l10n.
  const HomeJournalUiError(this.message);

  /// Готовая подпись для пользователя.
  final String message;
}

/// За сегодня тапов нет.
final class HomeJournalUiEmpty extends HomeJournalUiModel {
  /// Текст empty-state из l10n.
  const HomeJournalUiEmpty(this.message);

  /// Готовая подпись для пользователя.
  final String message;
}

/// Список тапов за сегодня.
final class HomeJournalUiRows extends HomeJournalUiModel {
  /// Строки в порядке провайдера.
  const HomeJournalUiRows(this.rows);

  /// Отформатированные строки списка.
  final List<HomeJournalRowUiModel> rows;
}

/// Готовые строки и флаги главной для dumb-виджетов.
class HomeUiModel {
  /// Собирает данные экрана после Builder.
  const HomeUiModel({
    required this.balance,
    required this.journal,
    required this.tapEnabled,
    required this.tapLabel,
    required this.undoEnabled,
    required this.undoLabel,
  });

  /// Состояние карточки четырёх итогов.
  final HomeBalanceUiModel balance;

  /// Состояние журнала тапов.
  final HomeJournalUiModel journal;

  /// Кнопка записи активна.
  final bool tapEnabled;

  /// Подпись кнопки записи.
  final String tapLabel;

  /// Кнопка undo активна.
  final bool undoEnabled;

  /// Подпись кнопки undo.
  final String undoLabel;
}
