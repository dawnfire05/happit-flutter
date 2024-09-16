part of 'routes.dart';

@TypedGoRoute<HomeRoute>(
  path: '/habit',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<HabitAddRoute>(path: 'add'),
    TypedGoRoute<HabitAddedRoute>(path: 'added'),
  ],
)
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HabitScreen();
  }
}

class HabitAddRoute extends GoRouteData {
  const HabitAddRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HabitAddScreen();
  }
}

class HabitAddedRoute extends GoRouteData {
  const HabitAddedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HabitAddedScreen();
  }
}
