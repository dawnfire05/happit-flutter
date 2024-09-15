import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happit_flutter/app/modules/global/widgets/bottom_navigation_bar.dart';
import 'dart:io' show Platform;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

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

  Future<void> _showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      '제목',
      '내용',
      platformChannelSpecifics,
      payload: 'item id 2',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        shadowColor: Colors.white,
        title: Container(
          child: Row(
            // mainAxisSize: MainAxisSize.max,
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
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: _showNotification,
                child: const Text('알림 보내기'),
              ),
            ),
            habitWidget(),
            const SizedBox(height: 32),
            habitWidget(),
            const SizedBox(height: 32),
            habitWidget(),
          ],
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(),
    );
  }

  Container habitWidget() {
    return Container(
      padding: const EdgeInsets.fromLTRB(23, 20, 23, 20),
      decoration: ShapeDecoration(
        color: const Color(0xFFF0F2F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: SizedBox(
                  child: Text(
                    '독서',
                    style: TextStyle(
                      color: Color(0xFF1F2329),
                      fontSize: 18,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w700,
                      height: 0,
                      letterSpacing: -1.44,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  '연속 777일',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF56B45F),
                    fontSize: 14,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w700,
                    height: 0,
                    letterSpacing: -1.12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 168,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.transparent,
                  child: const GitHubGrassWidget(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff8D939D),
                        ),
                        child: IconButton(
                          onPressed: () => {},
                          icon: SvgPicture.asset('assets/icons/Pen.svg'),
                        ),
                      ),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff8D939D),
                        ),
                        child: IconButton(
                          onPressed: () => {},
                          icon:
                              SvgPicture.asset('assets/icons/Arrow-Right.svg'),
                        ),
                      ),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff66D271),
                        ),
                        child: IconButton(
                          onPressed: () => {},
                          icon: SvgPicture.asset('assets/icons/Check.svg'),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GitHubGrassWidget extends StatelessWidget {
  final int rows = 7;
  final int columns = 12;

  const GitHubGrassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(rows, (rowIndex) {
        return Row(
          children: List.generate(columns, (colIndex) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: const Color(0xff66D271),
              ),
              margin: const EdgeInsets.all(2.0),
              width: 20.0,
              height: 20.0,
            );
          }),
        );
      }),
    );
  }
}
