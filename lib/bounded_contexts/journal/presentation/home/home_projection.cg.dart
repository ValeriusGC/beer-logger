import 'package:beer_logger/bounded_contexts/journal/application/clicks_for_today.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/application/record_click.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/application/today_balance.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/application/undo_last_click.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_projection.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/home/home_projection_factory.dart';
import 'package:beer_logger/bounded_contexts/portion/application/current_clicker.cg.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_projection.cg.g.dart';

/// Проекция главной из уже существующих application-провайдеров.
@riverpod
HomeProjection homeProjection(Ref ref) {
  return HomeProjectionFactory.from(
    balance: ref.watch(todayBalanceProvider),
    clicks: ref.watch(clicksForTodayProvider),
    record: ref.watch(recordClickProvider),
    clicker: ref.watch(currentClickerProvider),
    undo: ref.watch(undoLastClickProvider),
  );
}
