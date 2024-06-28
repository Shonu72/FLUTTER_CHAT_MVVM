import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/data/models/messages_model.dart';
import 'package:charterer/presentation/getx/controllers/chat_controller.dart';
import 'package:charterer/presentation/getx/controllers/message_reply_controller.dart';
import 'package:charterer/presentation/screens/chats/widgets/my_message_card.dart';
import 'package:charterer/presentation/screens/chats/widgets/sender_message_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatList extends StatefulWidget {
  final String receiverUserId;
  final bool isGroupChat;
  const ChatList(
      {Key? key, required this.receiverUserId, required this.isGroupChat})
      : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final chatController = Get.find<ChatController>();
  final ScrollController messageController = ScrollController();
  final messageReplyController = Get.find<MessageReplyController>();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  void onMessageSwipe(String message, bool isMe, MessageEnum messageEnum) {
    messageReplyController.messageReply.value = MessageReply(
      message,
      isMe,
      messageEnum,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream: widget.isGroupChat
            ? chatController.groupChatStream(widget.receiverUserId)
            : chatController.chatStream(widget.receiverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          SchedulerBinding.instance.addPostFrameCallback((_) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });

          void scrollToMessage(int index) {
            if (index >= 0 && index < snapshot.data!.length) {
              messageController.jumpTo(index * 100.0);
            }
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            controller: messageController,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              var timeSent = DateFormat.jm().format(messageData.timeSent);
              print(messageData.messageId);

              if (!messageData.isSeen &&
                  messageData.recieverid ==
                      FirebaseAuth.instance.currentUser!.uid) {
                chatController.markAsSeen(
                    context: context,
                    receiverUserId: widget.receiverUserId,
                    messageId: messageData.messageId);
              }

              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.text,
                  date: timeSent,
                  type: messageData.type,
                  repliedText: messageData.repliedMessage,
                  username: messageData.repliedTo,
                  repliedMessageType: messageData.repliedMessageType,
                  ontap: () {
                    scrollToMessage(index);
                  },
                  onLeftSwipe: () {
                    onMessageSwipe(messageData.text, true, messageData.type);
                    // FocusManager.instance.primaryFocus!.requestFocus();
                  },
                  isSeen: messageData.isSeen,
                );
              }
              return SenderMessageCard(
                  message: messageData.text,
                  date: timeSent,
                  type: messageData.type,
                  repliedText: messageData.repliedMessage,
                  username: messageData.repliedTo,
                  repliedMessageType: messageData.repliedMessageType,
                  ontap: () {
                    scrollToMessage(index);
                  },
                  onRightSwipe: () {
                    onMessageSwipe(messageData.text, false, messageData.type);
                    // FocusManager.instance.primaryFocus!.requestFocus();
                  });
            },
          );
        });
  }
}
