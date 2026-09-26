import 'package:beer_ledger_core/arch/value_object.dart';
import 'package:beer_ledger_core/ledger_axis_kind.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signed_base_delta.freezed.dart';

/// Подписанный вклад одной оси в базовой единице семейства.
///
/// Вариант задаёт ось: объём в мл, энергия в cal, деньги в kop, joy в count.
/// Сложение (`+`) есть только у одинаковых вариантов; смешивать варианты типом
/// нельзя — иначе миллилитры снова сложатся с копейками.
@freezed
sealed class SignedBaseDelta with _$SignedBaseDelta implements ValueObject {
  const SignedBaseDelta._();

  const factory SignedBaseDelta.volume(double signedBase) = VolumeDelta;
  const factory SignedBaseDelta.energy(double signedBase) = EnergyDelta;
  const factory SignedBaseDelta.money(double signedBase) = MoneyDelta;
  const factory SignedBaseDelta.joy(double signedBase) = JoyDelta;

  /// Ось, к которой относится этот вклад.
  LedgerAxisKind get kind => switch (this) {
    VolumeDelta() => LedgerAxisKind.volume,
    EnergyDelta() => LedgerAxisKind.energy,
    MoneyDelta() => LedgerAxisKind.money,
    JoyDelta() => LedgerAxisKind.joy,
  };

  /// Собирает вариант по [kind] — для маппера Drift и нулей в агрегации.
  factory SignedBaseDelta.fromKind(LedgerAxisKind kind, double signedBase) {
    return switch (kind) {
      LedgerAxisKind.volume => SignedBaseDelta.volume(signedBase),
      LedgerAxisKind.energy => SignedBaseDelta.energy(signedBase),
      LedgerAxisKind.money => SignedBaseDelta.money(signedBase),
      LedgerAxisKind.joy => SignedBaseDelta.joy(signedBase),
    };
  }
}

/// Складывает два вклада объёма в базовых миллилитрах.
extension VolumeDeltaAdd on VolumeDelta {
  /// Сумма двух снимков volume; вариант не меняется.
  VolumeDelta operator +(VolumeDelta other) =>
      VolumeDelta(signedBase + other.signedBase);
}

/// Складывает два вклада энергии в базовых калориях.
extension EnergyDeltaAdd on EnergyDelta {
  /// Сумма двух снимков energy; вариант не меняется.
  EnergyDelta operator +(EnergyDelta other) =>
      EnergyDelta(signedBase + other.signedBase);
}

/// Складывает два денежных вклада в базовых копейках.
extension MoneyDeltaAdd on MoneyDelta {
  /// Сумма двух снимков money; вариант не меняется.
  MoneyDelta operator +(MoneyDelta other) =>
      MoneyDelta(signedBase + other.signedBase);
}

/// Складывает два вклада joy в базовых баллах.
extension JoyDeltaAdd on JoyDelta {
  /// Сумма двух снимков joy; вариант не меняется.
  JoyDelta operator +(JoyDelta other) =>
      JoyDelta(signedBase + other.signedBase);
}
