import 'package:charterer/domain/repositories/chat_repository.dart';
import 'package:charterer/presentation/getx/controllers/message_reply_controller.dart';
import 'package:flutter/material.dart';

class SendTextMessage {
  final ChatRepository repository;

  SendTextMessage(this.repository);

  void call({
    required BuildContext context,
    required String text,
    required String receiverUserId,
    required MessageReply? messageReply,
        required bool isGroupChat,

  }) {
    repository.sendTextMessage(
      context: context,
      text: text,
      receiverUserId: receiverUserId,
      messageReply: messageReply,
      isGroupChat: isGroupChat,
    );
  }
}
