import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_ui_model.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Карточка четырёх итогов за сегодня.
///
/// Dumb-виджет: рисует [HomeBalanceUiModel], не ходит в провайдеры и не
/// форматирует суммы сам.
class TodayBalanceCard extends StatelessWidget {
  /// Создаёт карточку с готовыми строками баланса.
  const TodayBalanceCard({super.key, required this.balance});

  /// Состояние карточки от [HomeUiModelBuilder].
  final HomeBalanceUiModel balance;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return switch (balance) {
      HomeBalanceUiLoading() => const CircularProgressIndicator(),
      HomeBalanceUiError(:final message) => Text(message),
      HomeBalanceUiLines(:final lines) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BalanceAxis(
                label: l10n.todayBalanceVolumeLabel,
                value: lines.volume,
                valueKey: const Key('today-balance-volume'),
              ),
              const SizedBox(height: 12),
              _BalanceAxis(
                label: l10n.todayBalanceEnergyLabel,
                value: lines.energy,
                valueKey: const Key('today-balance-energy'),
              ),
              const SizedBox(height: 12),
              _BalanceAxis(
                label: l10n.todayBalanceMoneyLabel,
                value: lines.money,
                valueKey: const Key('today-balance-money'),
              ),
              const SizedBox(height: 12),
              _BalanceAxis(
                label: l10n.todayBalanceJoyLabel,
                value: lines.joy,
                valueKey: const Key('today-balance-joy'),
              ),
            ],
          ),
        ),
      ),
    };
  }
}

class _BalanceAxis extends StatelessWidget {
  const _BalanceAxis({
    required this.label,
    required this.value,
    required this.valueKey,
  });

  final String label;
  final String value;
  final Key valueKey;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textTheme.bodyMedium),
        Text(value, key: valueKey, style: textTheme.titleLarge),
      ],
    );
  }
}
