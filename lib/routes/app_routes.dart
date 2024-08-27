import 'package:flutter/material.dart';
import 'package:happit_flutter/app/modules/habit/presentation/screens/add_habit_screen.dart';
import 'package:happit_flutter/app/modules/habit/presentation/screens/home_screen.dart';
import 'package:happit_flutter/app/modules/auth/presentation/screens/login_screen.dart';

class AppRoutes {
  static const String home = "/";
  static const String login = "/login";
  static const String habitNew = "/habit/add";

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    habitNew: (context) => const AddHabitScreen(),
  };
}
