import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_ui_model.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Журнал тапов за сегодня и кнопка глобального undo.
///
/// Dumb-sliver: рисует [HomeJournalUiModel], undo вызывает [onUndo].
class TodayClicksSection extends StatelessWidget {
  /// Создаёт секцию списка и кнопки undo.
  const TodayClicksSection({
    super.key,
    required this.journal,
    required this.undoEnabled,
    required this.undoLabel,
    required this.onUndo,
  });

  /// Состояние журнала от [HomeUiModelBuilder].
  final HomeJournalUiModel journal;

  /// Кнопка undo активна.
  final bool undoEnabled;

  /// Подпись кнопки undo.
  final String undoLabel;

  /// Вызывается при нажатии undo.
  final VoidCallback onUndo;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              l10n.todayClicksTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: undoEnabled ? onUndo : null,
                child: Text(undoLabel),
              ),
            ),
          ),
        ),
        switch (journal) {
          HomeJournalUiLoading() => const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          HomeJournalUiError(:final message) => SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(message),
            ),
          ),
          HomeJournalUiEmpty(:final message) => SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(message),
            ),
          ),
          HomeJournalUiRows(:final rows) => SliverList.builder(
            itemCount: rows.length,
            itemBuilder: (context, index) {
              final row = rows[index];
              return ListTile(
                key: Key('today-click-${row.id}'),
                title: Text(row.time),
                trailing: row.volume == null ? null : Text(row.volume!),
              );
            },
          ),
        },
      ],
    );
  }
}
