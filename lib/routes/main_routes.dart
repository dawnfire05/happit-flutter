part of 'routes.dart';

@TypedShellRoute<MainShellRoute>(routes: [
  TypedGoRoute<HabitListRoute>(path: '/habit'),
  TypedGoRoute<ProfileRoute>(path: '/profile'),
])
class MainShellRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return MainLayout(child: navigator);
  }
}

class HabitListRoute extends GoRouteData {
  const HabitListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HabitListScreen();
  }
}

class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }
}