import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/button.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/happit_app_bar.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/loading_screen.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/grass_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_list_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/habit_widget.dart';
import 'package:happit_flutter/routes/routes.dart';
import 'package:happit_flutter/values/palette.dart';

class HabitListScreen extends StatelessWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HappitAppBar(),
      body: BlocBuilder<HabitListBloc, HabitListState>(
        builder: (context, habitState) {
          return BlocBuilder<GrassBloc, GrassState>(
            builder: (context, grassState) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<HabitListBloc>().add(const HabitListEvent.get());
                  context.read<GrassBloc>().add(const GrassEvent.get(3));
                },
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildHabitList(context, habitState, grassState),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHabitList(
    BuildContext context,
    HabitListState habitState,
    GrassState grassState,
  ) {
    return switch (habitState) {
      Initial() => _buildEmptyHabitScreen(context),
      Loading(:final previousHabits) =>
        previousHabits == null
            ? const LoadingScreen()
            : _buildHabitListScreen(previousHabits, grassState),
      Error() => _buildErrorScreen(context),
      Success(:final habits) =>
        habits.isEmpty
            ? _buildEmptyHabitScreen(context)
            : _buildHabitListScreen(habits, grassState),
    };
  }

  Expanded _buildHabitListScreen(List<Habit> habits, GrassState grassState) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (_, _) => const SizedBox(height: 32),
        itemCount: habits.length,
        itemBuilder: (context, index) {
          final habit = habits[index];
          final grassRecords = _grassRecordsForHabit(habit.id, grassState);
          return HabitWidget(
            id: habit.id,
            name: habit.name,
            themeColor: habit.themeColor,
            currentStreak: habit.currentStreak,
            grassRecords: grassRecords,
            onRecordToggled: grassRecords != null
                ? () {
                    context.read<GrassBloc>().add(const GrassEvent.get(3));
                    context.read<HabitListBloc>().add(
                      const HabitListEvent.get(),
                    );
                  }
                : null,
          );
        },
      ),
    );
  }

  Expanded _buildEmptyHabitScreen(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '아직 습관이 없어요.\n습관을 추가해보세요.',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Palette.black80,
                letterSpacing: -1.44,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Button(
              content: '습관 추가하러 가기',
              onPressed: () => const HabitCreatingRoute().push(context),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildErrorScreen(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '문제가 발생했어요.\n금방 해결할게요!',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Palette.black80,
                letterSpacing: -1.44,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Button(
              content: '새로고침 하기',
              onPressed: () =>
                  context.read<HabitListBloc>().add(const HabitListEvent.get()),
            ),
          ],
        ),
      ),
    );
  }

  /// 잔디 그리드용: [GrassBloc] 데이터에서 해당 습관만 추출.
  /// (표시 = GrassBloc, 오늘 칸 반영·토글 = HabitWidget 내 RecordBloc)
  List<Record>? _grassRecordsForHabit(int habitId, GrassState grassState) {
    if (grassState is! GrassSuccess) return null;
    try {
      final g = grassState.grass.firstWhere((e) => e.habitId == habitId);
      return g.records
          .map((r) => Record(id: habitId, date: r.date, state: r.state))
          .toList();
    } catch (_) {
      return null;
    }
  }
}
