import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/happit_app_bar.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/main_button.dart';
import 'package:happit_flutter/app/modules/habit/domain/entity/record.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/grass_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit_list_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/habit_widget.dart';
import 'package:happit_flutter/routes/routes.dart';
import 'package:happit_flutter/values/palette.dart';

class HabitListScreen extends StatelessWidget {
  const HabitListScreen({super.key});

  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  // @override
  // void initState() {
  //   super.initState();

  //   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');

  //   const InitializationSettings initializationSettings =
  //       InitializationSettings(android: initializationSettingsAndroid);

  //   flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }

  // Future<void> _showNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'your_channel_id',
  //     'your_channel_name',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     showWhen: false,
  //   );
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     '제목',
  //     '내용',
  //     platformChannelSpecifics,
  //     payload: 'item id 2',
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HabitListBloc>().add(const HabitListEvent.get());
        context.read<GrassBloc>().add(const GrassGet(3));
      },
      child: Scaffold(
        appBar: const HappitAppBar(),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: BlocBuilder<HabitListBloc, HabitListState>(
            builder: (context, habitState) {
              return BlocBuilder<GrassBloc, GrassState>(
                builder: (context, grassState) {
                  return Column(
                    children: [
                      const SizedBox(height: 16),
                      _buildHabitList(context, habitState, grassState),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHabitList(
    BuildContext context,
    HabitListState habitState,
    GrassState grassState,
  ) {
    return habitState.when(
      initial: () => const Center(child: Text('초기 상태')),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e) => ElevatedButton(
        onPressed: () =>
            context.read<HabitListBloc>().add(const HabitListEvent.get()),
        child: Text(e),
      ),
      success: (habits) {
        if (habits.isEmpty) {
          return Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '등록된 습관이 없어요',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Palette.black100,
                    ),
                  ),
                  const SizedBox(height: 16),
                  MainButton.cta(
                    text: '습관 추가하기',
                    onPressed: () => const HabitCreatingRoute().push(context),
                  ),
                ],
              ),
            ),
          );
        }
        return Expanded(
          child: ListView.separated(
            separatorBuilder: (_, _) => const SizedBox(height: 32),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              final grassRecords = _grassRecordsForHabit(habit.id, grassState);
              return HabitWidget(
                id: habit.id,
                name: habit.name,
                themeColor: habit.themeColor,
                grassRecords: grassRecords,
                onRecordToggled: grassRecords != null
                    ? () => context.read<GrassBloc>().add(const GrassGet(3))
                    : null,
              );
            },
          ),
        );
      },
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
