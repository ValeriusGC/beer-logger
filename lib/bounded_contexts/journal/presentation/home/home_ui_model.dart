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
  /// Четыре подписи карточки и сегменты слеш-строки для сжатого AppBar.
  const HomeBalanceUiLines(this.lines, {required this.compactSegments});

  /// Строки карточки в порядке пресета.
  final TodayBalanceLines lines;

  /// Те же оси для compact title: объём, энергия, деньги, радость.
  final List<FormattedAxisValue> compactSegments;
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
