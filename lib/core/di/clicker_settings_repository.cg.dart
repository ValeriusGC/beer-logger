import 'package:beer_logger/core/di/app_database.cg.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker_settings_repository.dart';
import 'package:beer_logger/bounded_contexts/portion/infrastructure/drift_clicker_settings_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clicker_settings_repository.cg.g.dart';

/// Настройки порции над [appDatabase].
///
/// Экран и запись тапа не ходят в drift сами.
///
/// [Ref.watch], не [Ref.read]: репозиторий привязан к той БД, которую
/// сейчас отдаёт [appDatabase].
@Riverpod(keepAlive: true)
ClickerSettingsRepository clickerSettingsRepository(Ref ref) {
  return DriftClickerSettingsRepository(ref.watch(appDatabaseProvider));
}
