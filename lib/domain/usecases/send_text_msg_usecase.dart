import 'package:charterer/domain/repositories/chat_repository.dart';
import 'package:flutter/material.dart';

class SendTextMessage {
  final ChatRepository repository;

  SendTextMessage(this.repository);

  void call({
    required BuildContext context,
    required String text,
    required String receiverUserId,
  }) {
    repository.sendTextMessage(
      context: context,
      text: text,
      receiverUserId: receiverUserId,
    );
  }
}
