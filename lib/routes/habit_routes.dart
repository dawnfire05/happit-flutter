part of 'routes.dart';

@TypedShellRoute<HabitCreatingShellRoute>(routes: [
  TypedGoRoute<HabitCreatingRoute>(path: '/habit/creating'),
  TypedGoRoute<HabitCreatedRoute>(path: '/habit/created')
])
class HabitCreatingShellRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return HabitCreatingShell(child: navigator);
  }
}

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
  final CreateHabitModel habit;
  const HabitCreatedRoute(this.habit);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return HabitCreatedScreen(habit: habit);
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
