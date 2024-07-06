import 'dart:io';

import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/data/datasources/chat_remote_datasource.dart';
import 'package:charterer/data/models/chat_contact_model.dart';
import 'package:charterer/data/models/group_model.dart';
import 'package:charterer/data/models/messages_model.dart';
import 'package:charterer/domain/repositories/chat_repository.dart';
import 'package:charterer/presentation/getx/controllers/message_reply_controller.dart';
import 'package:flutter/material.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Stream<List<ChatContact>> getChatContacts() {
    return remoteDataSource
        .getChatContacts()
        .map((contacts) => contacts.map((contact) => contact).toList());
  }

  @override
  Stream<List<Message>> getChatStream(String receiverUserId) {
    return remoteDataSource
        .getChatStream(receiverUserId)
        .map((messages) => messages.map((message) => message).toList());
  }

  @override
  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String receiverUserId,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) {
    remoteDataSource.sendTextMessage(
      context: context,
      text: text,
      receiverUserId: receiverUserId,
      messageReply: messageReply,
      isGroupChat: isGroupChat,
    );
  }

  @override
  void sendFileMessage({
    required BuildContext context,
    required File file,
    required String receiverUserId,
    required MessageEnum messageEnum,
    required MessageReply? messageReply,
    required bool isGroupChat,
  }) {
    remoteDataSource.sendFileMessage(
      context: context,
      file: file,
      receiverUserId: receiverUserId,
      messageEnum: messageEnum,
      messageReply: messageReply,
      isGroupChat: isGroupChat,
    );
  }

  @override
  void setChatMessageSeen(
      BuildContext context, String receiverUserId, String messageId) {
    remoteDataSource.setChatMessageSeen(context, receiverUserId, messageId);
  }

  @override
  Stream<List<Group>> getChatGroups() {
    return remoteDataSource
        .getChatGroups()
        .map((groups) => groups.map((group) => group).toList());
  }

  @override
  Stream<List<Message>> getGroupChatStream(String groupId) {
    return remoteDataSource
        .groupChatStream(groupId)
        .map((messages) => messages.map((message) => message).toList());
  }
}
