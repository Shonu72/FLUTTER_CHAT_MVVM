import 'package:charterer/core/utils/enums.dart';
import 'package:get/get.dart';

class MessageReply {
  final String message;
  final bool isMe;
  final MessageEnum messageEnum;

  MessageReply(this.message, this.isMe, this.messageEnum);
}

class MessageReplyController extends GetxController {
  var messageReply = Rxn<MessageReply>();

  void updateMessageReply(MessageReply? reply) {
    messageReply.value = reply;
    update();
  }

  void clearMessageReply() {
    messageReply.value = null;
    update();
  }
}

final messageReplyController = Get.find<MessageReplyController>();
