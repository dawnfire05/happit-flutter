part of 'routes.dart';


@TypedGoRoute<HabitCreatingRoute>(path: '/habit/creating')
class HabitCreatingRoute extends GoRouteData {
  const HabitCreatingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HabitCreatingScreen();
  }
}

@TypedGoRoute<HabitCreatedRoute>(path: '/habit/created')
class HabitCreatedRoute extends GoRouteData {
  HabitCreatedRoute(this.$extra);
  final CreateHabitModel $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HabitCreatedScreen($extra);
  }
}

@TypedGoRoute<HabitEditRoute>(path: '/habit/edit/:id')
class HabitEditRoute extends GoRouteData {
  final int id;
  const HabitEditRoute(this.id);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HabitEditScreen(id: id);
  }
}
