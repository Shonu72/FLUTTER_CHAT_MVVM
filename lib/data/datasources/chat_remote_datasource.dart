import 'dart:io';

import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/data/models/chat_contact_model.dart';
import 'package:charterer/data/models/messages_model.dart';
import 'package:charterer/presentation/getx/controllers/message_reply_controller.dart';
import 'package:flutter/material.dart';

abstract class ChatRemoteDataSource {
  Stream<List<ChatContact>> getChatContacts();
  Stream<List<Message>> getChatStream(String receiverUserId);
  Future<void> sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
    required MessageReply? messageReply,
  });

  Future<void> sendFileMessage({
    required BuildContext context,
    required File file,
    required String receiverUserId,
    required MessageEnum messageEnum,
    required MessageReply? messageReply,
  });
}
