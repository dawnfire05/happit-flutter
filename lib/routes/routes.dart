import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happit_flutter/app/modules/habit/presentation/screen/habit_added_screen.dart';
import 'package:happit_flutter/app/modules/habit/presentation/screen/habit_add_screen.dart';
import 'package:happit_flutter/app/modules/habit/presentation/screen/habit_screen.dart';
import 'package:happit_flutter/app/modules/splash/presentation/screen/splash_screen.dart';

part 'routes.g.dart';
part 'main_routes.dart';
part 'spash_routes.dart';

final GoRouter router = GoRouter(
  routes: $appRoutes,
  initialLocation: const HomeRoute().location,
  debugLogDiagnostics: kDebugMode,
);
