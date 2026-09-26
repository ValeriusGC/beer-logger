import 'package:beer_logger/bounded_contexts/journal/domain/click/click.dart';
import 'package:beer_logger/core/di/click_repository.cg.dart';
import 'package:beer_logger/core/di/now.cg.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clicks_for_today.cg.g.dart';

/// Живой список тапов за сегодняшний локальный день.
///
/// «Сегодня» — календарный день [now]. Экран только рисует этот поток,
/// в базу сам не ходит.
@riverpod
Stream<List<Click>> clicksForToday(Ref ref) {
  return ref
      .watch(clickRepositoryProvider)
      .watchClicksForDay(ref.watch(nowProvider));
}
