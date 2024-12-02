part of 'routes.dart';

@TypedGoRoute<HabitListRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<HabitAddRoute>(path: 'habit/creating'),
    TypedGoRoute<HabitAddedRoute>(path: 'habit/created'),
    TypedGoRoute<HabitEditRoute>(path: 'habit/edit/:id')
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

class HabitEditRoute extends GoRouteData {
  final int id;
  const HabitEditRoute(this.id);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HabitEditScreen(id: id);
  }
}
