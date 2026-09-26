import 'package:beer_ledger_core/arch/value_object.dart';
import 'package:beer_ledger_core/failure/failure.dart';
import 'package:beer_ledger_core/result/result.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'click_id.freezed.dart';

/// Идентификатор одного тапа в домене журнала и в SQLite.
///
/// Отдельный тип от [ClickerId]: компилятор не примет id кликера там, где ждут
/// id тапа. В колонку TEXT уходит [value], не [toString].
/// Недоверенная строка — [parse]; литерал в коде — [ClickId.known].
@freezed
abstract class ClickId with _$ClickId implements ValueObject {
  const ClickId._();

  /// Доверенный идентификатор: пресет, тест, Uuid, строка из нашей SQLite.
  const factory ClickId.known(String value) = _ClickId;

  /// Разбирает недоверенную строку. Пустая → [Failure.emptyId], иначе [known].
  static Result<ClickId> parse(String raw) {
    if (raw.isEmpty) {
      return const Left(Failure.emptyId());
    }
    return Right(ClickId.known(raw));
  }
}
