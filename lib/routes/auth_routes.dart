part of 'routes.dart';

@TypedGoRoute<AuthRoute>(
  path: '/auth',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<SignInRoute>(path: 'sign-in'),
    TypedGoRoute<SignUpRoute>(path: 'sign-up'),
  ],
)
class AuthRoute extends GoRouteData {
  const AuthRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HabitListScreen();
  }
}

class SignInRoute extends GoRouteData {
  const SignInRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignInScreen();
  }
}

class SignUpRoute extends GoRouteData {
  const SignUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignUpScreen();
  }
}
