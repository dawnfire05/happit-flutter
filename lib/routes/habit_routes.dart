part of 'routes.dart';

@TypedGoRoute<HabitListRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<HabitAddRoute>(path: 'habit/creating'),
    TypedGoRoute<HabitAddedRoute>(path: 'habit/created'),
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
