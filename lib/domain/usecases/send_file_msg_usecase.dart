import 'dart:io';

import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/domain/repositories/chat_repository.dart';
import 'package:flutter/material.dart';

class SendFileMsgUseCase {
  final ChatRepository chatRepository;

  SendFileMsgUseCase(this.chatRepository);

  Future<void> call({
    required BuildContext context,
    required File file,
    required String receiverUserId,
    required MessageEnum messageEnum,
  }) async {
    try {
      return chatRepository.sendFileMessage(
        context: context,
        file: file,
        receiverUserId: receiverUserId,
        messageEnum: messageEnum,
      );
    } catch (e) {
      Helpers.toast(e.toString());
    }
  }
}
