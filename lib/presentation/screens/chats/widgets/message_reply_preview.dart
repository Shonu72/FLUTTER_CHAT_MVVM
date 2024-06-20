import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/presentation/getx/controllers/message_reply_controller.dart';
import 'package:charterer/presentation/screens/chats/widgets/display_text_img.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageReplyPreview extends StatelessWidget {
  MessageReplyPreview({super.key});
  final messageReplyController = Get.find<MessageReplyController>();
  @override
  Widget build(BuildContext context) {
    final messageReply = messageReplyController.messageReply.value;
    return Container(
      width: 350,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  messageReply!.isMe ? 'Me' : 'Opposite',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: messageReply.isMe ? whiteColor : Colors.blue,
                  ),
                ),
              ),
              GestureDetector(
                child: const Icon(
                  Icons.close,
                  size: 20,
                  color: whiteColor,
                ),
                onTap: () {
                  messageReplyController.clearMessageReply();
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          DisplayTextImage(
            message: messageReply.message,
            type: messageReply.messageEnum,
          ),
        ],
      ),
    );
  }
}
