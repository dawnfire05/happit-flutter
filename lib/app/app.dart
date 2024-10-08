import 'package:flutter/material.dart';
import 'package:happit_flutter/routes/routes.dart';
import 'package:happit_flutter/values/palette.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
          fontFamily: 'NotoSansKR',
          appBarTheme: const AppBarTheme(
            backgroundColor: Palette.white,
          ),
          scaffoldBackgroundColor: Palette.white),
      routerConfig: router,
    );
  }
}
