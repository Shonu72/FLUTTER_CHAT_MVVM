import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/domain/repositories/chat_repository.dart';
import 'package:flutter/material.dart';

class MarkAsSeenUseCase {
  final ChatRepository chatRepository;

  MarkAsSeenUseCase(this.chatRepository);

  Future<void> call(
    BuildContext context,
    String receiverUserId,
    String messageId,
  ) async {
    try {
      return chatRepository.setChatMessageSeen(
        context,
        receiverUserId,
        messageId,
      );
    } catch (e) {
      Helpers.toast(e.toString());
    }
  }
}
