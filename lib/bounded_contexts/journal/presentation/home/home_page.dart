import 'dart:async';

import 'package:beer_logger/bounded_contexts/journal/application/record_click.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/application/undo_last_click.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_controller.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_projection.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_ui_model.dart';
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

/// Горизонтальный отступ карточки баланса в compact-колонке.
const _balanceHorizontalPadding = 16.0;

/// Нижний отступ карточки под pinned [SliverAppBar].
const _balanceBottomPadding = 8.0;

/// Высота pinned-бара compact: [title] + зарезервированный слот слеш-строки.
const _balanceToolbarHeight = 72.0;

/// Слот под слеш-строку в [SliverAppBar.title] — всегда занят, чтобы «Пивомер»
/// не прыгал при появлении подстроки.
const _compactLineHeight = 14.0;

/// С какого прогресса «уезда» карточки начинаем проявлять слеш-строку (0…1).
const _compactLineRevealStart = 0.35;

/// Главный экран приложения: баланс, запись тапа, журнал и объём за неделю.
///
/// Сам проекцию не смотрит. [LayoutBuilder] выбирает целиком compact или wide
/// body. Compact: pinned [SliverAppBar] и карточка отдельным sliver; слеш-строка
/// в title по scroll offset. Кнопка записи — [Scaffold.bottomNavigationBar].
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

/// Компактный layout: pinned-бар → карточка (sliver) → журнал → график.
///
/// Карточка не в [SliverAppBar.flexibleSpace] — высота intrinsic. Слеш-строка
/// в title, когда карточка уехала вверх ([_HomeCompactBodyState]).
class _HomeCompactBody extends StatefulWidget {
  /// Собирает узкую главную.
  const _HomeCompactBody();

  @override
  State<_HomeCompactBody> createState() => _HomeCompactBodyState();
}

class _HomeCompactBodyState extends State<_HomeCompactBody> {
  final _balanceCardKey = GlobalKey();
  double _compactLineOpacity = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _syncCompactLineOpacity(),
    );
  }

  bool _onScroll(ScrollNotification notification) {
    if (notification.depth != 0) {
      return false;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _syncCompactLineOpacity();
      }
    });
    return false;
  }

  void _syncCompactLineOpacity() {
    final cardContext = _balanceCardKey.currentContext;
    if (cardContext == null) {
      return;
    }
    final renderObject = cardContext.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) {
      return;
    }

    final cardTop = renderObject.localToGlobal(Offset.zero).dy;
    final nextOpacity = _compactLineOpacityForCardTop(cardTop);
    if ((nextOpacity - _compactLineOpacity).abs() > 0.02) {
      setState(() => _compactLineOpacity = nextOpacity);
    }
  }

  double _compactLineOpacityForCardTop(double cardTop) {
    final scrollProgress = (1 - cardTop / _balanceToolbarHeight).clamp(
      0.0,
      1.0,
    );
    return Curves.easeIn.transform(
      ((scrollProgress - _compactLineRevealStart) /
              (1 - _compactLineRevealStart))
          .clamp(0.0, 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: CustomScrollView(
        key: const Key('home-compact-body'),
        slivers: [
          _HomeSliverAppBar(compactLineOpacity: _compactLineOpacity),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              _balanceHorizontalPadding,
              0,
              _balanceHorizontalPadding,
              _balanceBottomPadding,
            ),
            sliver: SliverToBoxAdapter(
              child: KeyedSubtree(
                key: _balanceCardKey,
                child: const _HomeBalanceSection(),
              ),
            ),
          ),
          const _HomeJournalSliverSection(),
          const SliverToBoxAdapter(child: WeekVolumeChart()),
        ],
      ),
    );
  }
}

/// Широкий layout главной: pinned-бар, баланс и график в ряду, ниже журнал.
class _HomeWideBody extends StatelessWidget {
  /// Собирает широкую главную.
  const _HomeWideBody();

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      key: Key('home-wide-body'),
      slivers: [
        _HomeSliverAppBar(),
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

/// Pinned [SliverAppBar]: название, настройки; на compact — слеш-строка в title.
class _HomeSliverAppBar extends StatelessWidget {
  /// [compactLineOpacity] задан — compact chrome с двухстрочным title.
  const _HomeSliverAppBar({this.compactLineOpacity});

  /// Прозрачность слеш-строки; `null` — wide, одна строка title.
  final double? compactLineOpacity;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final compactChrome = compactLineOpacity != null;
    return SliverAppBar(
      pinned: true,
      centerTitle: false,
      clipBehavior: Clip.hardEdge,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: compactChrome ? _balanceToolbarHeight : kToolbarHeight,
      collapsedHeight: compactChrome ? _balanceToolbarHeight : null,
      title: compactChrome
          ? _HomeAppBarTitle(compactLineOpacity: compactLineOpacity!)
          : const _HomeAppBarTitle(),
      actions: const [_HomeSettingsButton()],
    );
  }
}

/// Название приложения; на compact — зарезервированный слот слеш-строки.
class _HomeAppBarTitle extends ConsumerWidget {
  /// [compactLineOpacity] `null` — wide, только название.
  const _HomeAppBarTitle({this.compactLineOpacity});

  /// Прозрачность слеш-строки под названием.
  final double? compactLineOpacity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final title = Text(l10n.appTitle);
    if (compactLineOpacity == null) {
      return title;
    }

    final compactLine = _compactBalanceLine(context, ref);
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        SizedBox(
          height: _compactLineHeight,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Opacity(
              opacity: compactLine == null ? 0 : compactLineOpacity!,
              child: Text(
                compactLine ?? '',
                key: compactLine == null
                    ? null
                    : const Key('today-balance-compact'),
                style: Theme.of(context).textTheme.labelSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Кнопка настроек в sliver-шапке: переход `go /settings`.
class _HomeSettingsButton extends StatelessWidget {
  /// Иконка шестерёнки с l10n tooltip.
  const _HomeSettingsButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return IconButton(
      tooltip: l10n.homeSettingsTooltip,
      onPressed: () => context.go('/settings'),
      icon: const Icon(Icons.settings),
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

String? _compactBalanceLine(BuildContext context, WidgetRef ref) {
  final projection = ref.watch(
    homeProjectionProvider.select((home) => home.balance),
  );
  final locale = Localizations.localeOf(context);
  final ui = HomeUiModelBuilder.balance(
    projection: projection,
    l10n: AppLocalizations.of(context),
    languageCode: locale.languageCode,
  );
  return switch (ui) {
    HomeBalanceUiLines(:final compactLine) => compactLine,
    _ => null,
  };
}
