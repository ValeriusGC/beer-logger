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
/// Сам проекцию не смотрит. Секции ниже делают `select` своего среза,
/// чтобы смена кнопки не пересобирала карточку, список и график.
/// SnackBar и haptic — здесь.
class HomePage extends ConsumerWidget {
  /// Создаёт главный экран с карточкой, кнопкой записи, журналом и графиком.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
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
            onPressed: () => context.go('/settings'),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          if (wide)
            const SliverToBoxAdapter(child: _HomeWideHeader())
          else
            const SliverToBoxAdapter(child: _HomeBalanceSection()),
          const SliverToBoxAdapter(child: _HomeTapButton()),
          const _HomeJournalSection(),
          if (!wide) const SliverToBoxAdapter(child: WeekVolumeChart()),
        ],
      ),
    );
  }
}

/// Широкий layout: [TodayBalanceCard] и [WeekVolumeChart] в одной строке.
///
/// Только компоновка — данные каждая секция берёт сама через `select`.
class _HomeWideHeader extends StatelessWidget {
  const _HomeWideHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      key: Key('home-balance-chart-row'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _HomeBalanceSection()),
        Expanded(child: WeekVolumeChart()),
      ],
    );
  }
}

/// Карточка итогов за сегодня.
///
/// Смотрит `homeProjectionProvider.select` только на [HomeBalanceProjection],
/// чтобы смена кнопки записи не пересобирала баланс.
class _HomeBalanceSection extends ConsumerWidget {
  const _HomeBalanceSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(
      homeProjectionProvider.select((projection) => projection.balance),
    );
    final locale = Localizations.localeOf(context);
    return TodayBalanceCard(
      balance: HomeUiModelBuilder.balance(
        projection: balance,
        l10n: AppLocalizations.of(context),
        languageCode: locale.languageCode,
      ),
    );
  }
}

/// Кнопка «записать тап» с подписью объёма текущей порции.
///
/// `select` берёт только [HomeProjection.tapEnabled] и [HomeProjection.buttonClicker].
class _HomeTapButton extends ConsumerWidget {
  const _HomeTapButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tap = ref.watch(
      homeProjectionProvider.select(
        (projection) =>
            (enabled: projection.tapEnabled, clicker: projection.buttonClicker),
      ),
    );
    final locale = Localizations.localeOf(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FilledButton(
        onPressed: tap.enabled
            ? () => ref.read(homeControllerProvider.notifier).record()
            : null,
        child: Text(
          HomeUiModelBuilder.tapLabel(
            clicker: tap.clicker,
            l10n: AppLocalizations.of(context),
            languageCode: locale.languageCode,
          ),
        ),
      ),
    );
  }
}

/// Список тапов за сегодня и кнопка undo.
///
/// `select` берёт журнал и [HomeProjection.undoEnabled], не трогая карточку и кнопку записи.
class _HomeJournalSection extends ConsumerWidget {
  const _HomeJournalSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journal = ref.watch(
      homeProjectionProvider.select(
        (projection) =>
            (items: projection.journal, undoEnabled: projection.undoEnabled),
      ),
    );
    final l10n = AppLocalizations.of(context);
    return TodayClicksSection(
      journal: HomeUiModelBuilder.journal(
        projection: journal.items,
        l10n: l10n,
        locale: Localizations.localeOf(context),
      ),
      undoEnabled: journal.undoEnabled,
      undoLabel: l10n.undoLastTap,
      onUndo: () => ref.read(homeControllerProvider.notifier).undo(),
    );
  }
}
