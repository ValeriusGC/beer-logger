import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'now.cg.g.dart';

/// Границы «сегодня» и недели.
///
/// Значение кэшируется, пока его кто-то смотрит. Момент тапа отсюда не
/// берётся: [RecordClick] пишет свежий [DateTime.now] и не инвалидирует
/// этот кэш на каждый тап. Иначе запросы дня и график уходят в reload,
/// а экран на кадр подменяет карточки индикатором.
@riverpod
DateTime now(Ref ref) => DateTime.now();
