import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/load_on_enter.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_list_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/screen/habit_list_screen.dart';

/// 습관 목록 라우트에서 표시하는 페이지.
/// 진입 시 [HabitListEvent.get]을 디스패치한 뒤 [HabitListScreen]을 표시한다.
class HabitListRoutePage extends StatelessWidget {
  const HabitListRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadOnEnter(
      onEnter: (ctx) =>
          ctx.read<HabitListBloc>().add(const HabitListEvent.get()),
      child: const HabitListScreen(),
    );
  }
}
