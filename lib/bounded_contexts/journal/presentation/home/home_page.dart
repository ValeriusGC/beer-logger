import 'package:beer_logger/bounded_contexts/journal/application/record_click.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/application/undo_last_click.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_controller.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_projection.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_ui_model_builder.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/today_balance_card.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/today_clicks_section.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/week_volume_chart.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Порог Material compact: уже окно — колонка, иначе карточка и график в ряд.
const _homeWideWidth = 600.0;

/// Главный экран приложения: баланс, запись тапа, журнал и объём за неделю.
///
/// Оркестратор UI Projection: смотрит [homeProjectionProvider], собирает
/// [HomeUiModelBuilder] и отдаёт dumb-виджеты. Snackbar и haptic — здесь.
class HomePage extends ConsumerWidget {
  /// Создаёт главный экран с карточкой, кнопкой записи, журналом и графиком.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context);
    final projection = ref.watch(homeProjectionProvider);
    final ui = HomeUiModelBuilder.build(
      projection: projection,
      l10n: l10n,
      locale: locale,
    );

    ref.listen(recordClickProvider, (previous, next) {
      if (next.hasError && previous?.hasError != true) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.recordClickError)));
      }
      if (previous?.isLoading == true && !next.isLoading && !next.hasError) {
        HapticFeedback.lightImpact();
      }
    });

    ref.listen(undoLastClickProvider, (previous, next) {
      if (next.hasError && previous?.hasError != true) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.undoLastTapError)));
      }
    });

    final wide = MediaQuery.sizeOf(context).width >= _homeWideWidth;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            tooltip: l10n.homeSettingsTooltip,
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          if (wide)
            SliverToBoxAdapter(
              child: Row(
                key: const Key('home-balance-chart-row'),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: TodayBalanceCard(balance: ui.balance)),
                  const Expanded(child: WeekVolumeChart()),
                ],
              ),
            )
          else
            SliverToBoxAdapter(child: TodayBalanceCard(balance: ui.balance)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton(
                onPressed: ui.tapEnabled
                    ? () => ref.read(homeControllerProvider.notifier).record()
                    : null,
                child: Text(ui.tapLabel),
              ),
            ),
          ),
          TodayClicksSection(
            journal: ui.journal,
            undoEnabled: ui.undoEnabled,
            undoLabel: ui.undoLabel,
            onUndo: () => ref.read(homeControllerProvider.notifier).undo(),
          ),
          if (!wide) const SliverToBoxAdapter(child: WeekVolumeChart()),
        ],
      ),
    );
  }
}
