// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $habitListRoute,
      $splashRoute,
      $authRoute,
    ];

RouteBase get $habitListRoute => GoRouteData.$route(
      path: '/habit',
      factory: $HabitListRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'creating',
          factory: $HabitAddRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: 'created',
          factory: $HabitAddedRouteExtension._fromState,
        ),
      ],
    );

extension $HabitListRouteExtension on HabitListRoute {
  static HabitListRoute _fromState(GoRouterState state) =>
      const HabitListRoute();

  String get location => GoRouteData.$location(
        '/habit',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HabitAddRouteExtension on HabitAddRoute {
  static HabitAddRoute _fromState(GoRouterState state) => const HabitAddRoute();

  String get location => GoRouteData.$location(
        '/habit/creating',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HabitAddedRouteExtension on HabitAddedRoute {
  static HabitAddedRoute _fromState(GoRouterState state) =>
      const HabitAddedRoute();

  String get location => GoRouteData.$location(
        '/habit/created',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/splash',
      factory: $SplashRouteExtension._fromState,
    );

extension $SplashRouteExtension on SplashRoute {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  String get location => GoRouteData.$location(
        '/splash',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $authRoute => GoRouteData.$route(
      path: '/auth',
      factory: $AuthRouteExtension._fromState,
    );

extension $AuthRouteExtension on AuthRoute {
  static AuthRoute _fromState(GoRouterState state) => const AuthRoute();

  String get location => GoRouteData.$location(
        '/auth',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
