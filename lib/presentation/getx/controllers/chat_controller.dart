import 'package:charterer/data/models/chat_contact_model.dart';
import 'package:charterer/data/models/messages_model.dart';
import 'package:charterer/domain/entities/chat_contact_entity.dart';
import 'package:charterer/domain/entities/messages_entity.dart';
import 'package:charterer/domain/usecases/chat_usecase.dart';
import 'package:charterer/domain/usecases/send_text_msg_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final GetChatContacts getChatContactsUseCase;
  final GetChatStream getChatStreamUseCase;
  final SendTextMessage sendTextMessageUseCase;

  ChatController(
      {required this.getChatStreamUseCase,
      required this.sendTextMessageUseCase,
      required this.getChatContactsUseCase});

  Stream<List<ChatContact>> chatContacts() {
    return getChatContactsUseCase();
  }

  Stream<List<Message>> chatStream(String receiverUserId) {
    return getChatStreamUseCase(receiverUserId);
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
  }) {
    sendTextMessageUseCase(
      context: context,
      text: text,
      receiverUserId: receiverUserId,
    );
  }

  // void sendFileMessage({
  //   required BuildContext context,
  //   required File file,
  //   required String receiverUserId,
  //   required MessageEnum messageEnum,
  // }) {
  //   sendFileMessage(
  //     context: context,
  //     file: file,
  //     receiverUserId: receiverUserId,
  //     messageEnum: messageEnum,
  //   );
  // }

  // void sendGIFMessage({
  //   required BuildContext context,
  //   required String gifUrl,
  //   required String receiverUserId,
  // }) {
  //   sendGIFMessage(
  //     context: context,
  //     gifUrl: gifUrl,
  //     receiverUserId: receiverUserId,
  //   );
  // }

  // void setChatMessageSeen({
  //   required BuildContext context,
  //   required String receiverUserId,
  //   required String messageId,
  // }) {
  //   setChatMessageSeen(
  //     context: context,
  //     receiverUserId: receiverUserId,
  //     messageId: messageId,
  //   );
  // }
}
