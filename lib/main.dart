import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:happit_flutter/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:happit_flutter/app/app_bloc_observer.dart';
import 'package:happit_flutter/app/di/get_it.dart';

//백그라운드 알림 수신
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(); // 여기에 initializeApp을 다시 해줄 필요가 있나?

  log("Handling a background message: ${message.messageId}");
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
}

void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   final fcmToken = await FirebaseMessaging.instance.getToken();
//   print(fcmToken);

//   // await FirebaseMessaging messaging = FirebaseMessaging.instance.setAutoInitEnabled(true); fcm Token 관련 설정

//   // 포그라운드 알림 수신
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     log('Got a message whilst in the foreground!');
//     log('Message data: ${message.data}');

//     if (message.notification != null) {
//       log('Message also contained a notification: ${message.notification?.title}, ${message.notification?.body}');
//     }
//   });

//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   const InitializationSettings initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);

//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  configureDependencies();
  _initBloc();
  runApp(const MainApp());
}

void _initBloc() {
  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }
}
