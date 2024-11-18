import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happit_flutter/app/di/get_it.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/happit_app_bar.dart';
import 'package:happit_flutter/app/modules/common/presentation/widget/happit_bottom_navigation_bar.dart';
import 'package:happit_flutter/app/modules/habit/presentation/bloc/habit/habit_bloc.dart';
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
    return BlocProvider(
      create: (context) => getIt<HabitBloc>()..add(const HabitEvent.get()),
      child: Scaffold(
        appBar: const HappitAppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<HabitBloc>().add(const HabitEvent.get());
          },
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: BlocBuilder<HabitBloc, HabitState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: Text("초기 상태")),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  success: (habits) => ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 32),
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      final habit = habits[index];
                      return HabitWidget(
                        name: habit.name,
                      );
                    },
                  ),
                  error: (error) => ElevatedButton(
                      onPressed: () =>
                          context.read<HabitBloc>().add(const HabitEvent.get()),
                      child: const Text('새로고침')),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: const HappitBottomNavigationBar(),
      ),
    );
  }
}
