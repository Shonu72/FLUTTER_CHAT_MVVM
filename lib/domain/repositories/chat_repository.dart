import 'package:charterer/data/models/chat_contact_model.dart';
import 'package:charterer/data/models/messages_model.dart';
import 'package:charterer/domain/entities/chat_contact_entity.dart';
import 'package:charterer/domain/entities/messages_entity.dart';
import 'package:flutter/material.dart';

abstract class ChatRepository {
  Stream<List<ChatContact>> getChatContacts();
  Stream<List<Message>> getChatStream(String receiverUserId);
  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
  });
}
