import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit/habit_bloc.dart';
import 'package:happit_flutter/app/modules/user/presentation/bloc/user_bloc.dart';
import 'package:happit_flutter/routes/routes.dart';
import 'package:happit_flutter/values/palette.dart';

class App extends StatelessWidget {
  const App({super.key});

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
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                lazy: false,
                create: (context) =>
                    getIt<UserBloc>()..add(const UserEvent.load())),
            BlocProvider(
              create: (context) => getIt<HabitBloc>()
                ..add(
                  const HabitEvent.get(),
                ),
            ),
          ],
          child: child!,
        );
      },
    );
  }
}
