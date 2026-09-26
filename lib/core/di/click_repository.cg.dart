import 'package:beer_logger/core/di/app_database.cg.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click_repository.dart';
import 'package:beer_logger/bounded_contexts/journal/infrastructure/drift_click_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'click_repository.cg.g.dart';

/// Журнал тапов для всего приложения.
///
/// Всегда [DriftClickRepository] над [appDatabase]. Экран и фичи не ходят
/// в drift сами — только сюда.
///
/// [Ref.watch], не [Ref.read]: репозиторий привязан к той БД, которую
/// сейчас отдаёт [appDatabase].
@Riverpod(keepAlive: true)
ClickRepository clickRepository(Ref ref) {
  return DriftClickRepository(ref.watch(appDatabaseProvider));
}
