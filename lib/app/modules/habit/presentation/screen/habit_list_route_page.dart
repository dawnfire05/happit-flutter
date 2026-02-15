import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/load_on_enter.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/grass_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_list_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/screen/habit_list_screen.dart';

/// 습관 목록 라우트에서 표시하는 페이지.
/// 진입 시 이미 로드된 상태가 아니면 [HabitListEvent.get], [GrassGet]을 디스패치한다.
/// (Bloc은 앱/라우트 상위에서 유지되므로 다른 화면 갔다 와도 데이터 유지)
class HabitListRoutePage extends StatelessWidget {
  const HabitListRoutePage({super.key});

  static const int _grassMonths = 3;

  @override
  Widget build(BuildContext context) {
    return LoadOnEnter(
      onEnter: (ctx) {
        final habitListBloc = ctx.read<HabitListBloc>();
        final grassBloc = ctx.read<GrassBloc>();
        final habitAlreadyLoaded = habitListBloc.state.maybeWhen(
          success: (_) => true,
          orElse: () => false,
        );
        if (!habitAlreadyLoaded) {
          habitListBloc.add(const HabitListEvent.get());
        }
        if (grassBloc.state is! GrassSuccess) {
          grassBloc.add(const GrassEvent.get(_grassMonths));
        }
      },
      child: const HabitListScreen(),
    );
  }
}
