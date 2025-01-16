import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit/habit_list_bloc.dart';
import 'package:happit_flutter/app/modules/habit/presentation/widget/habit_widget.dart';

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
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: BlocBuilder<HabitListBloc, HabitListState>(
            builder: (context, state) {
              return state.when(
                initial: () => const Center(child: Text("초기 상태")),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error) => ElevatedButton(
                  onPressed: () => context
                      .read<HabitListBloc>()
                      .add(const HabitListEvent.get()),
                  child: const Text('새로고침'),
                ),
                success: (habits) => ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 32),
                  itemCount: habits.length,
                  itemBuilder: (context, index) {
                    final habit = habits[index];
                    return HabitWidget(
                      id: habit.id,
                      name: habit.name,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
