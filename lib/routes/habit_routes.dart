part of 'routes.dart';

@TypedGoRoute<HabitListRoute>(
  path: '/habit',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<HabitAddRoute>(path: 'creating'),
    TypedGoRoute<HabitAddedRoute>(path: 'created'),
  ],
)
class HabitListRoute extends GoRouteData {
  const HabitListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HabitListScreen();
  }
}

class HabitAddRoute extends GoRouteData {
  const HabitAddRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HabitCreatingScreen();
  }
}

class HabitAddedRoute extends GoRouteData {
  const HabitAddedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HabitCreatedScreen();
  }
}
