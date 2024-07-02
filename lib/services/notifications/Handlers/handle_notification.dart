import 'dart:convert';

import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
        
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification click here
        final payload = response.payload;
        if (payload != null) {
          _handleMessageRedirect(payload);
        }
      },
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleMessageRedirect(jsonEncode(message.data));
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        _handleMessageRedirect(jsonEncode(message.data));
      }
    });
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            importance: Importance.max,
            priority: Priority.high,
            
            showWhen: false);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: jsonEncode(message.data),
    );
  }

  void _handleMessageRedirect(String payload) {
    final data = jsonDecode(payload);
    final uid = data['senderId'] as String?;
    final name = data['senderName'] as String?;
    final profile = data['profile'] as String?;
    // final isGroupChat = data['isGroupChat'] as bool?;

    if (uid != null && name != null && profile != null) {
      Get.toNamed(
        Routes.chatPage,
        arguments: {
          'uid': uid,
          'name': name,
          'profilePic': profile,
          'isGroupChat': false,
        },
      );
    } else {
      print("Error: Missing necessary data in notification payload.");
    }
  }
}
