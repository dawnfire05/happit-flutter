import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/button.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/happit_app_bar.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/loading_screen.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/habit_with_grass.dart';
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
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<HabitListBloc>().add(const HabitListEvent.get());
              await context.read<HabitListBloc>().stream.first;
            },
            child: switch (state) {
              Initial() => _buildEmptyView(context),
              Loading(:final previousHabits) =>
                previousHabits == null
                    ? const LoadingScreen()
                    : _buildHabitList(context, previousHabits),
              Error() => _buildErrorView(context),
              Success(:final habitsWithGrass) =>
                habitsWithGrass.isEmpty
                    ? _buildEmptyView(context)
                    : _buildHabitList(context, habitsWithGrass),
            },
          );
        },
      ),
    );
  }

  Widget _buildHabitList(
    BuildContext context,
    List<HabitWithGrass> habitsWithGrass,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      separatorBuilder: (_, _) => const SizedBox(height: 32),
      itemCount: habitsWithGrass.length,
      itemBuilder: (context, index) {
        return HabitWidget(
          habitWithGrass: habitsWithGrass[index],
        );
      },
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '아직 습관이 없어요.\n습관을 추가해보세요.',
                  style: TextStyle(
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
        ),
      ],
    );
  }

  Widget _buildErrorView(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '문제가 발생했어요.\n금방 해결할게요!',
                  style: TextStyle(
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
                  onPressed: () => context.read<HabitListBloc>().add(
                    const HabitListEvent.get(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
