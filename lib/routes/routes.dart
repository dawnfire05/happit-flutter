import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:happit_flutter/app/modules/auth/presentation/screens/sign_in_screen.dart';
import 'package:happit_flutter/app/modules/auth/presentation/screens/sign_up_screen.dart';
import 'package:happit_flutter/app/modules/habit/presentation/screen/habit_created_screen.dart';
import 'package:happit_flutter/app/modules/habit/presentation/screen/habit_creating_screen.dart';
import 'package:happit_flutter/app/modules/habit/presentation/screen/habit_list_screen.dart';
import 'package:happit_flutter/app/modules/splash/presentation/screen/splash_screen.dart';

part 'routes.g.dart';
part 'habit_routes.dart';
part 'spash_routes.dart';
part 'auth_routes.dart';

final GoRouter router = GoRouter(
  routes: $appRoutes,
  initialLocation: const HabitListRoute().location,
  debugLogDiagnostics: kDebugMode,
);
