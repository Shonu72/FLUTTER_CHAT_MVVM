import 'dart:io';

import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/data/models/chat_contact_model.dart';
import 'package:charterer/data/models/messages_model.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:flutter/material.dart';

abstract class ChatRemoteDataSource {
  Stream<List<ChatContact>> getChatContacts();
  Stream<List<Message>> getChatStream(String receiverUserId);
  Future<void> sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
  });

  Future<void> sendFileMessage({
    required BuildContext context,
    required File file,
    required String receiverUserId,
    required MessageEnum messageEnum,
  });
}
