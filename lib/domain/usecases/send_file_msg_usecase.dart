import 'dart:io';

import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/domain/repositories/chat_repository.dart';
import 'package:charterer/presentation/getx/controllers/message_reply_controller.dart';
import 'package:flutter/material.dart';

class SendFileMsgUseCase {
  final ChatRepository chatRepository;

  SendFileMsgUseCase(this.chatRepository);

  Future<void> call({
    required BuildContext context,
    required File file,
    required String receiverUserId,
    required MessageEnum messageEnum,
        required MessageReply? messageReply,

  }) async {
    try {
      return chatRepository.sendFileMessage(
        context: context,
        file: file,
        receiverUserId: receiverUserId,
        messageEnum: messageEnum,
        messageReply: messageReply,
      );
    } catch (e) {
      Helpers.toast(e.toString());
    }
  }
}
