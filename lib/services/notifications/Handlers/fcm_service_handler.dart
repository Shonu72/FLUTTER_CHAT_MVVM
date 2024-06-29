// import 'dart:convert';

// import 'package:charterer/services/notifications/Handlers/handle_notification.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';

// class FCMService {
//   final RxList<RemoteMessage> notifications = RxList<RemoteMessage>([]);

//   Future<void> initFirebaseMessaging() async {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         print("background notification tapped $message");
//         notifications.add(message);
//         // navigatorKey.currentContext!.pushNamed('notification');
//       }
//     });

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       String payloadData = jsonEncode(message.data);
//       print("Foreground message received");

//       if (message.notification != null) {
//         print("Foreground message received : ${message.notification!.body}");
//         notifications.add(message);
//         PushNotifications.showSampleNotifcation(
//           title: message.notification!.title!,
//           body: message.notification!.body!,
//           payload: payloadData,
//         );
//       }
//     });

//     final RemoteMessage? message =
//         await FirebaseMessaging.instance.getInitialMessage();
//     if (message != null) {
//       print("terminated state notification tapped : $message");
//       notifications.add(message);
//       // navigatorKey.currentContext!.pushNamed('notification');
//     }
//   }

//   @pragma('vm:entry-point')
//   Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//     if (message.notification != null) {
//       print("Background message received : ${message.notification!.body}");
//       notifications.add(message);
//     }
//   }

//   List<RemoteMessage> getNotificationList() => notifications.toList();
// }
