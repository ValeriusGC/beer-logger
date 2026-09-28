import 'dart:async';

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

/// Порог Material compact: шире — [_HomeWideBody], иначе [_HomeCompactBody].
///
/// Сравнивается с [BoxConstraints.maxWidth] body, не с размером окна.
const _homeWideWidth = 600.0;

/// Главный экран приложения: баланс, запись тапа, журнал и объём за неделю.
///
/// Сам проекцию не смотрит. [LayoutBuilder] выбирает целиком compact или wide
/// body. Кнопка записи — слот [Scaffold.bottomNavigationBar], не в скролле:
/// [SafeArea] учитывает home indicator и жестовую навигацию, SnackBar не
/// накрывает кнопку. Секции внутри body делают `select` своего среза, чтобы
/// смена кнопки не пересобирала карточку, список и график.
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
        unawaited(HapticFeedback.lightImpact());
      }
    });

    ref.listen(undoLastClickProvider, (previous, next) {
      if (next.hasError && previous?.hasError != true) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.undoLastTapError)));
      }
    });

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= _homeWideWidth) {
            return const _HomeWideBody();
          }
          return const _HomeCompactBody();
        },
      ),
      bottomNavigationBar: const _HomeTapBar(),
    );
  }
}

/// Компактный layout главной: колонка баланс → журнал → график.
///
/// Свой [CustomScrollView], список slivers без ветвлений. Кнопка записи
/// живёт в [_HomeTapBar], не здесь. Проекцию не смотрит — данные берёт
/// каждая секция через `select`.
class _HomeCompactBody extends StatelessWidget {
  /// Собирает узкую главную.
  const _HomeCompactBody();

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      key: Key('home-compact-body'),
      slivers: [
        SliverToBoxAdapter(child: _HomeBalanceSection()),
        _HomeJournalSliverSection(),
        SliverToBoxAdapter(child: WeekVolumeChart()),
      ],
    );
  }
}

/// Широкий layout главной: баланс и график в ряду, ниже журнал.
///
/// Свой [CustomScrollView], список slivers без ветвлений. График только в ряду,
/// под журналом не дублируется. Кнопка записи — [_HomeTapBar]. Проекцию не смотрит.
class _HomeWideBody extends StatelessWidget {
  /// Собирает широкую главную.
  const _HomeWideBody();

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      key: Key('home-wide-body'),
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            key: Key('home-balance-chart-row'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _HomeBalanceSection()),
              Expanded(child: WeekVolumeChart()),
            ],
          ),
        ),
        _HomeJournalSliverSection(),
      ],
    );
  }
}

/// Карточка итогов за сегодня.
///
/// Смотрит `homeProjectionProvider.select` только на [HomeBalanceProjection],
/// чтобы смена кнопки записи не пересобирала баланс.
class _HomeBalanceSection extends ConsumerWidget {
  /// Секция баланса со срезом проекции.
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

/// Нижняя панель записи тапа.
///
/// Слот [Scaffold.bottomNavigationBar]: SnackBar выезжает над кнопкой.
/// [SafeArea] отодвигает её от home indicator, жестовой навигации и
/// скруглений; верх не трогаем — его уже съел [AppBar].
class _HomeTapBar extends StatelessWidget {
  /// Панель с кнопкой над системным inset.
  const _HomeTapBar();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      key: Key('home-tap-bar'),
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: _HomeTapButton(),
      ),
    );
  }
}

/// Кнопка «записать тап» с подписью объёма текущей порции.
///
/// `select` берёт только [HomeProjection.tapEnabled] и [HomeProjection.buttonClicker].
class _HomeTapButton extends ConsumerWidget {
  /// Кнопка записи на всю ширину нижней панели.
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
    return SizedBox(
      width: double.infinity,
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
/// `select` берёт журнал и [HomeProjection.undoEnabled],
/// не трогая карточку и кнопку записи.
///
/// Нейминг указывает, что секция является sliver section.
class _HomeJournalSliverSection extends ConsumerWidget {
  /// Секция журнала со срезом проекции.
  const _HomeJournalSliverSection();

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
