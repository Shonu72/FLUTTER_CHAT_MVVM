import 'dart:io';

import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/data/models/chat_contact_model.dart';
import 'package:charterer/data/models/group_model.dart';
import 'package:charterer/data/models/messages_model.dart';
import 'package:charterer/domain/usecases/chat_usecase.dart';
import 'package:charterer/domain/usecases/mark_as_seen_usecase.dart';
import 'package:charterer/domain/usecases/send_file_msg_usecase.dart';
import 'package:charterer/domain/usecases/send_text_msg_usecase.dart';
import 'package:charterer/presentation/getx/controllers/message_reply_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final GetChatContacts getChatContactsUseCase;
  final GetChatStream getChatStreamUseCase;
  final GetGroupChatStream getGroupChatStreamUseCase;
  final SendTextMessage sendTextMessageUseCase;
  final SendFileMsgUseCase sendFileMessageUseCase;
  final MarkAsSeenUseCase setChatMessageSeen;
  final GetChatGroupsUseCase getChatGroupsUseCase;

  ChatController({
    required this.getChatStreamUseCase,
    required this.sendTextMessageUseCase,
    required this.getChatContactsUseCase,
    required this.sendFileMessageUseCase,
    required this.setChatMessageSeen,
    required this.getChatGroupsUseCase,
    required this.getGroupChatStreamUseCase,
  });

  final messageReply = Get.find<MessageReplyController>();
  Stream<List<ChatContact>> chatContacts() {
    return getChatContactsUseCase();
  }

  Stream<List<Group>> chatGroups() {
    return getChatGroupsUseCase();
  }

  Stream<List<Message>> chatStream(String receiverUserId) {
    return getChatStreamUseCase(receiverUserId);
  }

  Stream<List<Message>> groupChatStream(String groupId) {
    return getGroupChatStreamUseCase(groupId);
  }

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
    required bool isGroupChat,
  }) {
    final messageReply = messageReplyController.messageReply.value;
    sendTextMessageUseCase(
      context: context,
      text: text,
      receiverUserId: receiverUserId,
      messageReply: messageReply,
      isGroupChat: isGroupChat,
    );
    messageReplyController.clearMessageReply();
  }

  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String receiverUserId,
    required MessageEnum messageEnum,
    // required UserModel senderUserData,
    required bool isGroupChat,
  }) {
    final messageReply = messageReplyController.messageReply.value;

    sendFileMessageUseCase(
      context: context,
      file: file,
      receiverUserId: receiverUserId,
      // senderUserData: senderUserData,
      messageEnum: messageEnum,
      messageReply: messageReply,
      isGroupChat: isGroupChat,
    );
    messageReplyController.clearMessageReply();
  }

  void markAsSeen({
    required BuildContext context,
    required String receiverUserId,
    required String messageId,
  }) {
    setChatMessageSeen(
      context,
      receiverUserId,
      messageId,
    );
  }
}
