import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happit_flutter/app/modules/habit/presentation/screens/habit_added_screen.dart';
import 'package:happit_flutter/app/modules/habit/presentation/screens/habit_add_screen.dart';
import 'package:happit_flutter/app/modules/habit/presentation/screens/home_screen.dart';
import 'package:happit_flutter/app/modules/splash/presentation/pages/splash_page.dart';

part 'routes.g.dart';
part 'main_routes.dart';
part 'spash_routes.dart';

final GoRouter router = GoRouter(
  routes: $appRoutes,
  initialLocation: const HabitAddedRoute().location,
  debugLogDiagnostics: kDebugMode,
);
