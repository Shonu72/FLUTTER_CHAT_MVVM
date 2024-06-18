import 'package:charterer/presentation/getx/controllers/chat_controller.dart';
import 'package:charterer/presentation/screens/chats/info.dart';
import 'package:charterer/presentation/screens/chats/widgets/my_message_card.dart';
import 'package:charterer/presentation/screens/chats/widgets/sender_message_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatList extends StatelessWidget {
  final String receiverUserId;
  ChatList({Key? key, required this.receiverUserId}) : super(key: key);

  final chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: chatController.chatStream(receiverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // final messages = snapshot.data as List;
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              var timeSent = DateFormat.Hm().format(messageData.timeSent);

              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.text,
                  date: timeSent,
                );
              }
              return SenderMessageCard(
                message: messageData.text,
                date: timeSent,
              );
            },
          );
        });
    //  ListView.builder(
    //   itemCount: messages.length,
    //   itemBuilder: (context, index) {
    //     if (messages[index]['isMe'] == true) {
    //       return MyMessageCard(
    //         message: messages[index]['text'].toString(),
    //         date: messages[index]['time'].toString(),
    //       );
    //     }
    //     return SenderMessageCard(
    //       message: messages[index]['text'].toString(),
    //       date: messages[index]['time'].toString(),
    //     );
    //   },
    // );
  }
}
