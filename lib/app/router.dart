import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:go_router/go_router.dart';

/// Маршруты приложения: `/` — главный экран, `/settings` — порция.
///
/// Других маршрутов нет: ни shell, ни redirect, ни отдельных deep link.
final List<RouteBase> beerLoggerRoutes = [
  GoRoute(path: '/', builder: (context, state) => const HomePage()),
  GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
];

/// Один роутер на процесс.
///
/// Новый [GoRouter] на каждый rebuild сбрасывал бы стек, и со settings некуда было бы вернуться.
final GoRouter beerLoggerRouter = GoRouter(routes: beerLoggerRoutes);
