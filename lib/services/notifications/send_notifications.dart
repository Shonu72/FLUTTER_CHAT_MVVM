import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/services/notifications/admin_firebase_notification.dart';
import 'package:http/http.dart';

class Notifications {
  static Future<void> sendPushNotification(UserModel user, String msg) async {
    try {
      final body = {
        "message": {
          "token": user.pushToken,
          "notification": {
            "title": user.name, //our name should be send
            "body": msg,
          },
        }
      };

      // Firebase Project > Project Settings > General Tab > Project ID
      const projectID = 'whatasapp-shourya';

      // get firebase admin token
      final bearerToken = await NotificationAccessToken.getToken;

      log('bearerToken: $bearerToken');

      // handle null token
      if (bearerToken == null) return;

      var res = await post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/$projectID/messages:send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $bearerToken'
        },
        body: jsonEncode(body),
      );

      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }
}
