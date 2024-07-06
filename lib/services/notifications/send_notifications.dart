import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:charterer/services/notifications/admin_firebase_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';

Future<void> sendPushNotification(
    UserModel sender, UserModel recipient, String msg) async {
  try {
    final body = {
      "message": {
        "token": recipient.pushToken,
        "notification": {
          "title": "${sender.name} sent you a message",
          "body": msg,
        },
        "data": {
          "senderId": sender.uid,
          "senderName": sender.name,
          "recipientId": recipient.uid,
          "route": Routes.chatPage,
          "profile": sender.profilePic,
          // "isGroupChat": false,
        }
      }
    };

    const projectID = 'whatasapp-shourya';

    final bearerToken = await NotificationAccessToken.getToken;
    log('bearerToken: $bearerToken');

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

    // Store notification in Firebase Firestore
    await FirebaseFirestore.instance.collection('notifications').add({
      'senderId': sender.uid,
      'senderName': sender.name,
      'recipientId': recipient.uid,
      'recipientName': recipient.name,
      'message': msg,
      'profile': sender.profilePic,
      'timestamp': FieldValue.serverTimestamp(),
    });
  } catch (e) {
    log('\nsendPushNotificationE: $e');
  }
}
