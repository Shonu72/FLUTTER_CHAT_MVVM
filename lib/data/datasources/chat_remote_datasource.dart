import 'package:charterer/data/models/chat_contact_model.dart';
import 'package:charterer/data/models/messages_model.dart';
import 'package:flutter/material.dart';

abstract class ChatRemoteDataSource {
  Stream<List<ChatContact>> getChatContacts();
  Stream<List<Message>> getChatStream(String receiverUserId);
  Future<void> sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
  });
}
