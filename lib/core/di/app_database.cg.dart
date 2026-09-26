import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.cg.g.dart';

/// Файловая SQLite-база приложения.
///
/// Одна на процесс: `keepAlive` не даёт закрыть её, когда никто не слушает.
/// При уничтожении контейнера закрывается в [Ref.onDispose].
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
}
