import 'package:beer_logger/bounded_contexts/journal/application/volume_for_last_7_days.cg.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Столбцы объёма за семь дней.
///
/// Читает [volumeForLast7DaysProvider]. В репозиторий не ходит и литры не
/// считает: значения уже в литрах. Пустая неделя — семь нулевых столбцов.
/// Тап по столбцу никуда не ведёт. Повторная загрузка оставляет прошлый
/// график. [RepaintBoundary] отделяет его отрисовку от остальной главной.
class WeekVolumeChart extends ConsumerWidget {
  /// Создаёт график, который подписывается на объём за неделю.
  const WeekVolumeChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return RepaintBoundary(
      child: ref
          .watch(volumeForLast7DaysProvider)
          .when(
            skipLoadingOnReload: true,
            loading: () => const CircularProgressIndicator(),
            error: (Object _, StackTrace _) => Text(l10n.weekChartLoadError),
            data: (days) => _WeekChart(days: days, title: l10n.weekChartTitle),
          ),
    );
  }
}

/// Dumb-виджет столбчатого графика: [BarChart] по готовым [DayVolume].
///
/// Провайдеры не смотрит — только рисует [days] и подписи дней недели.
class _WeekChart extends StatelessWidget {
  const _WeekChart({required this.days, required this.title});

  final List<DayVolume> days;
  final String title;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final locale = Localizations.localeOf(context);
    final weekday = DateFormat.E(locale.toString());

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: BarChart(
                BarChartData(
                  minY: 0,
                  alignment: BarChartAlignment.spaceEvenly,
                  barTouchData: const BarTouchData(enabled: false),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
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
                          BarChartRodData(
                            toY: days[index].liters,
                            color: color,
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
}
