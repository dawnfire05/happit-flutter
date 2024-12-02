import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit/habit_bloc.dart';
import 'package:happit_flutter/app/modules/user/presentation/bloc/user_bloc.dart';
import 'package:happit_flutter/routes/routes.dart';
import 'package:happit_flutter/values/palette.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      child: MultiBlocListener(
        listeners: [
          BlocListener<UserBloc, UserState>(
            listener: (context, state) => state.whenOrNull(
              unauthenticated: () => const SignInRoute(),
            ),
          ),
        ],
        child: MaterialApp.router(
          theme: ThemeData(
              fontFamily: 'NotoSansKR',
              appBarTheme: const AppBarTheme(
                backgroundColor: Palette.white,
              ),
              scaffoldBackgroundColor: Palette.white),
          routerConfig: router,
        ),
      ),
    );
  }
}
