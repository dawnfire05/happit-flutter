import 'package:flutter/material.dart';
import 'package:happit_flutter/routes/app_routes.dart';
import 'package:happit_flutter/values/palette.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'NotoSansKR',
          appBarTheme: const AppBarTheme(
            backgroundColor: Palette.white,
          ),
          scaffoldBackgroundColor: Palette.white),
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
