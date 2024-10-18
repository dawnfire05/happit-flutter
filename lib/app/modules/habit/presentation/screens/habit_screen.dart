import 'package:flutter/material.dart';
import 'package:happit_flutter/app/modules/common/presentation/widgets/bottom_navigation_bar.dart';
import 'dart:io' show Platform;
import 'package:happit_flutter/app/modules/habit/presentation/widgets/habit_widget.dart';

class HabitScreen extends StatelessWidget {
  const HabitScreen({super.key});

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        shadowColor: Colors.white,
        title: Row(
          children: [
            Text(
              'happit.',
              style: TextStyle(
                color: const Color(0xff56B45F),
                letterSpacing: Platform.isIOS ? -0.96 : 0,
                fontSize: 24,
                fontFamily: 'Montserrat Alternates',
                fontWeight: FontWeight.w800,
                height: 0,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          children: const [
            HabitWidget(),
            SizedBox(height: 32),
            HabitWidget(),
            SizedBox(height: 32),
            HabitWidget(),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }
}
