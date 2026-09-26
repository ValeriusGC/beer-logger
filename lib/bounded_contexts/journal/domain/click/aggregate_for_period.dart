import 'package:fpdart/fpdart.dart';

import 'package:beer_ledger_core/failure/failure.dart';
import 'package:beer_ledger_core/ledger_axis_kind.dart';
import 'package:beer_ledger_core/result/result.dart';

import 'click.dart';
import 'period_balances.dart';
import 'signed_base_delta.dart';

/// Суммирует [AxisContribution.delta] всех [clicks] в полуинтервале `[from, to)`.
///
/// [kinds] — оси dashboard'а: для каждого kind в списке в результате будет
/// ключ (даже если вкладов не было). Обычно:
/// `clicker.axes.map((a) => a.kind).toList()`.
///
/// Для суммирования достаточно kind'ов — конфигурация оси в расчёт не входит,
/// снимок уже в [Click].
///
/// Интервал полуоткрытый: `click.at >= from && click.at < to`.
/// Пустой список тапов или ни один tap вне периода → нули по [kinds], не ошибка.
/// `from >= to` → [Failure.invalidPeriod].
///
/// Вклад с kind, которого нет в [kinds], всё равно попадает в map (ключ
/// создаётся при первом вкладе).
Result<PeriodBalances> aggregateForPeriod({
  required List<Click> clicks,
  required List<LedgerAxisKind> kinds,
  required DateTime from,
  required DateTime to,
}) {
  if (!from.isBefore(to)) {
    return Left(Failure.invalidPeriod(from: from, to: to));
  }

  final totals = {
    for (final kind in kinds) kind: SignedBaseDelta.fromKind(kind, 0),
  };

  for (final click in clicks) {
    if (_isBefore(click.at, from) || !_isBefore(click.at, to)) {
      continue;
    }

    for (final contribution in click.contributions) {
      final kind = contribution.kind;
      final current = totals[kind] ?? SignedBaseDelta.fromKind(kind, 0);
      totals[kind] = _addSignedBaseDelta(current, contribution.delta);
    }
  }

  return Right(PeriodBalances(totalsInBase: totals));
}

/// Складывает два вклада одного варианта; смешанная пара — баг вызывающего.
SignedBaseDelta _addSignedBaseDelta(SignedBaseDelta a, SignedBaseDelta b) {
  return switch ((a, b)) {
    (VolumeDelta(:final signedBase), VolumeDelta(signedBase: final other)) =>
      VolumeDelta(signedBase + other),
    (EnergyDelta(:final signedBase), EnergyDelta(signedBase: final other)) =>
      EnergyDelta(signedBase + other),
    (MoneyDelta(:final signedBase), MoneyDelta(signedBase: final other)) =>
      MoneyDelta(signedBase + other),
    (JoyDelta(:final signedBase), JoyDelta(signedBase: final other)) =>
      JoyDelta(signedBase + other),
    _ => throw StateError('mixed SignedBaseDelta variants: $a + $b'),
  };
}

/// `a < b` по календарному сравнению local [DateTime].
bool _isBefore(DateTime a, DateTime b) => a.compareTo(b) < 0;
