import 'package:flutter/material.dart';
import 'package:happit_flutter/screens/habit_new_screen.dart';
import 'package:happit_flutter/screens/home_screen.dart';
import 'package:happit_flutter/screens/login_screen.dart';

class AppRoutes {
  static const String home = "/";
  static const String login = "/login";
  static const String habitNew = "/habit/new";

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    login: (context) => const LoginScreen(),
    habitNew: (context) => const HabitNewScreen(),
  };
}
