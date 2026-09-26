import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'now.cg.g.dart';

/// Текущий момент.
///
/// Значение кэшируется, пока его кто-то смотрит. Для границ дня этого хватает.
/// Момент тапа так брать нельзя: все нажатия получат один instant, и внутри
/// минуты порядок станет порядком UUID. Запись делает [Ref.refresh].
@riverpod
DateTime now(Ref ref) => DateTime.now();
