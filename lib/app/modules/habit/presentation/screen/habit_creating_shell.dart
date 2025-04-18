import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_create_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_list_bloc.dart';
import 'package:happit_flutter/routes/routes.dart';

class HabitCreatingShell extends StatelessWidget {
  final Widget child;
  const HabitCreatingShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HabitCreateBloc>(),
      child: BlocListener<HabitCreateBloc, HabitCreateState>(
        listener: (context, state) {
          state.whenOrNull(
            success: (habit) {
              context.read<HabitListBloc>().add(const HabitListEvent.get());
              HabitCreatedRoute(habit).go(context);
            },
            error: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('습관 추가에 실패했습니다: $error')),
              );
            },
          );
        },
        child: Scaffold(
          body: child,
        ),
      ),
    );
  }
}
