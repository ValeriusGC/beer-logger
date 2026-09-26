import 'package:beer_ledger_core/arch/value_object.dart';
import 'package:beer_ledger_core/failure/failure.dart';
import 'package:beer_ledger_core/result/result.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'clicker_id.freezed.dart';

/// Идентификатор кликера (кнопки-пакета) в домене порции и в SQLite.
///
/// Отдельный тип от [ClickId]: компилятор не примет id тапа там, где ждут id
/// кликера. В колонку TEXT уходит [value], не [toString].
/// Недоверенная строка — [parse]; литерал в коде — [ClickerId.known].
@freezed
abstract class ClickerId with _$ClickerId implements ValueObject {
  const ClickerId._();

  /// Доверенный идентификатор: пресет, тест, строка из нашей SQLite.
  const factory ClickerId.known(String value) = _ClickerId;

  /// Разбирает недоверенную строку. Пустая → [Failure.emptyId], иначе [known].
  static Result<ClickerId> parse(String raw) {
    if (raw.isEmpty) {
      return const Left(Failure.emptyId());
    }
    return Right(ClickerId.known(raw));
  }
}
