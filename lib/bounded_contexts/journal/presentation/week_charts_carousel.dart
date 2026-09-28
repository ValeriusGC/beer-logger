import 'dart:math' as math;

import 'package:beer_logger/bounded_contexts/journal/application/week_axis_charts_for_last_7_days.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/axis_value_color.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/today_balance_format.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:beer_ledger_core/ledger_axis_kind.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Минимальная высота блока карусели: карточка + точки-индикатор.
const _carouselHeight = 252.0;

const _barRadius = 4.0;

/// Горизонтальная карусель недельных графиков по четырём осям.
///
/// Читает [weekAxisChartsForLast7DaysProvider]. [PageView] со snap: одна ось —
/// одна страница. Повторная загрузка оставляет прошлые графики.
class WeekChartsCarousel extends ConsumerStatefulWidget {
  /// Создаёт карусель, подписанную на недельные серии.
  ///
  /// [fillHeight] — растянуть блок по высоте родителя (wide).
  const WeekChartsCarousel({super.key, this.fillHeight = false});

  /// Растянуть карусель по высоте ячейки ряда на wide.
  final bool fillHeight;

  @override
  ConsumerState<WeekChartsCarousel> createState() => _WeekChartsCarouselState();
}

class _WeekChartsCarouselState extends ConsumerState<WeekChartsCarousel> {
  final _pageController = PageController();
  var _page = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final body = ref
        .watch(weekAxisChartsForLast7DaysProvider)
        .when(
          skipLoadingOnReload: true,
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object _, StackTrace _) =>
              Center(child: Text(l10n.weekChartLoadError)),
          data: _chartsColumn,
        );

    if (widget.fillHeight) {
      return RepaintBoundary(child: body);
    }

    return RepaintBoundary(
      child: SizedBox(height: _carouselHeight, child: body),
    );
  }

  Widget _chartsColumn(List<WeekAxisChartSeries> series) {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            key: const Key('week-charts-page-view'),
            controller: _pageController,
            physics: const PageScrollPhysics(),
            onPageChanged: (index) => setState(() => _page = index),
            itemCount: series.length,
            itemBuilder: (context, index) {
              final chart = series[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox.expand(
                  child: _WeekAxisBarChart(
                    key: Key('week-chart-${chart.kind.name}'),
                    kind: chart.kind,
                    title: _titleFor(l10n, chart.kind),
                    days: chart.days,
                    languageCode: languageCode,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        _WeekChartPageDots(current: _page, count: series.length),
        const SizedBox(height: 4),
      ],
    );
  }

  String _titleFor(AppLocalizations l10n, LedgerAxisKind kind) {
    return switch (kind) {
      LedgerAxisKind.volume => l10n.weekChartVolumeTitle,
      LedgerAxisKind.energy => l10n.weekChartEnergyTitle,
      LedgerAxisKind.money => l10n.weekChartMoneyTitle,
      LedgerAxisKind.joy => l10n.weekChartJoyTitle,
    };
  }
}

/// Dumb-виджет столбчатого графика по готовым [DayAxisPoint].
class _WeekAxisBarChart extends StatelessWidget {
  const _WeekAxisBarChart({
    super.key,
    required this.kind,
    required this.title,
    required this.days,
    required this.languageCode,
  });

  final LedgerAxisKind kind;
  final String title;
  final List<DayAxisPoint> days;
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context);
    final weekday = DateFormat.E(locale.toString());
    final bounds = _yBounds(days);
    final total = formatWeekChartAxisTotal(
      days.fold<double>(0, (sum, point) => sum + point.value),
      kind,
      languageCode: languageCode,
    );
    final hasSignedValues = days.any((point) => point.value < 0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  total.text,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: axisValueColor(colors, isNegative: total.isNegative),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BarChart(
                BarChartData(
                  minY: bounds.minY,
                  maxY: bounds.maxY,
                  alignment: BarChartAlignment.spaceEvenly,
                  barTouchData: const BarTouchData(enabled: false),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  extraLinesData: hasSignedValues
                      ? ExtraLinesData(
                          horizontalLines: [
                            HorizontalLine(
                              y: 0,
                              color: colors.onSurfaceVariant.withValues(
                                alpha: 0.35,
                              ),
                              strokeWidth: 1,
                            ),
                          ],
                        )
                      : const ExtraLinesData(),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(),
                    topTitles: const AxisTitles(),
                    rightTitles: const AxisTitles(),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          final index = value.round();
                          if (index < 0 || index >= days.length) {
                            return const SizedBox.shrink();
                          }
                          return Text(
                            weekday.format(days[index].day),
                            style: Theme.of(context).textTheme.labelSmall,
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    for (var index = 0; index < days.length; index++)
                      BarChartGroupData(
                        x: index,
                        barRods: [
                          _barRod(
                            value: days[index].value,
                            baseline: bounds.baseline,
                            colors: colors,
                          ),
                        ],
                      ),
                  ],
                ),
                duration: Duration.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartRodData _barRod({
    required double value,
    required double baseline,
    required ColorScheme colors,
  }) {
    final color = switch (value.compareTo(0)) {
      < 0 => colors.error,
      > 0 => colors.primary,
      _ => colors.outline,
    };
    final borderRadius = switch (value.compareTo(0)) {
      < 0 => const BorderRadius.vertical(bottom: Radius.circular(_barRadius)),
      > 0 => const BorderRadius.vertical(top: Radius.circular(_barRadius)),
      _ => BorderRadius.zero,
    };
    return BarChartRodData(
      toY: value,
      fromY: baseline,
      color: color,
      borderRadius: borderRadius,
    );
  }

  ({double minY, double maxY, double baseline}) _yBounds(
    List<DayAxisPoint> days,
  ) {
    if (days.every((point) => point.value == 0)) {
      return (minY: 0, maxY: 1, baseline: 0);
    }

    var minValue = days.map((point) => point.value).reduce(math.min);
    var maxValue = days.map((point) => point.value).reduce(math.max);
    if (minValue > 0) {
      minValue = 0;
    }
    if (maxValue < 0) {
      maxValue = 0;
    }
    final span = math.max(maxValue - minValue, 1e-6);
    final padding = span * 0.08;
    return (
      minY: minValue - padding,
      maxY: maxValue + padding,
      baseline: minValue < 0 ? 0 : minValue,
    );
  }
}

/// Индикатор текущей страницы карусели.
class _WeekChartPageDots extends StatelessWidget {
  const _WeekChartPageDots({required this.current, required this.count});

  final int current;
  final int count;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Row(
      key: const Key('week-chart-page-dots'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < count; index++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: index == current ? 8 : 6,
            height: index == current ? 8 : 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == current ? color : color.withValues(alpha: 0.35),
            ),
          ),
      ],
    );
  }
}
