import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:beer_ledger_core/ledger_axis_kind.dart';

import 'signed_base_delta.dart';

part 'period_balances.freezed.dart';

/// Суммы по осям за период — в **базовых** единицах семейства.
///
/// Значения уже подписаны ([AxisContribution.delta] суммировался при
/// агрегации): объём в мл, энергия в cal, деньги в kop, joy в count.
/// Конвертация для UI («1.5 L», «−450 ₽») — в слое приложения через
/// [fromBase] и поле [SignedBaseDelta.signedBase].
@Freezed(makeCollectionsUnmodifiable: false)
abstract class PeriodBalances with _$PeriodBalances {
  const factory PeriodBalances({
    required Map<LedgerAxisKind, SignedBaseDelta> totalsInBase,
  }) = _PeriodBalances;

  const PeriodBalances._();

  /// Сумма по [kind]; отсутствующий ключ → ноль в варианте этой оси.
  SignedBaseDelta totalFor(LedgerAxisKind kind) =>
      totalsInBase[kind] ?? SignedBaseDelta.fromKind(kind, 0);
}
