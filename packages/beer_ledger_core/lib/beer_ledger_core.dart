/// Техническое ядро Пивомера: словарь единиц, ошибки, маркеры DDD.
///
/// Не bounded context. Агрегаты порции и журнала — в приложении,
/// `lib/bounded_contexts/`. См. `docs/architecture.md`.
library;

export 'arch/arch.dart';
export 'convert/convert.dart';
export 'failure/failure.dart';
export 'ledger_axis_kind.dart';
export 'measure/measure.dart';
export 'result/result.dart';
