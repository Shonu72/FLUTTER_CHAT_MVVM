// import 'package:charterer/presentation/screens/main_page.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';

// class PushNotifications {
//   static final _firebaseMessaging = FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin
//       _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   // request permission for notification
//   static Future init() async {
//     await _firebaseMessaging.requestPermission(
//         alert: true,
//         badge: true,
//         sound: true,
//         announcement: true,
//         criticalAlert: true,
//         provisional: false,
//         carPlay: false);
//     // get token from devcie
//     // final token = await _firebaseMessaging.getToken();
//     // print("device token : $token");
//   }
//   // initialize local notification

//   static Future initLocalNotification() async {
//     // for android
//     const AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     // for ios
//     final DarwinInitializationSettings iosInitializationSettings =
//         DarwinInitializationSettings(
//       onDidReceiveLocalNotification: (id, title, body, payload) {
//         print("onDidReceiveLocalNotification");
//       },
//     );
//     // for linux
//     const LinuxInitializationSettings initializationSettingsLinux =
//         LinuxInitializationSettings(defaultActionName: 'Open notification');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: androidInitializationSettings,
//             iOS: iosInitializationSettings,
//             linux: initializationSettingsLinux);

//     // request permission for android 13 and above
//     _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()!
//         .requestNotificationsPermission();

//     _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (notificationResponse) {
//         onNotificationTap(notificationResponse);
//       },
//       onDidReceiveBackgroundNotificationResponse: (notificationResponse) {
//         onNotificationTap(notificationResponse);
//       },
//     );
//   }

//   // on tap local notification in foreground
//   static void onNotificationTap(NotificationResponse notificationResponse) {
//     print("onNotificationTap ");
//     Get.to(const MainPage(
//       initialIndex: 1,
//     ));
//   }

//   // show a simple notification
//   static Future showSampleNotifcation({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     const AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       'channel id',
//       'channel name',
//       channelDescription: 'channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );

//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidNotificationDetails);

//     await _flutterLocalNotificationsPlugin
//         .show(0, title, body, notificationDetails, payload: payload);
//   }
// }
