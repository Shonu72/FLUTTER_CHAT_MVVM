import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/presentation/screens/main_page.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:charterer/presentation/widgets/call_history_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CallHistoryScreen extends StatelessWidget {
  const CallHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor:
          backgroundDarkColor.withBlue(backgroundDarkColor.blue - 20),
      appBar: AppBar(
        backgroundColor: backgroundDarkColor,
        title: const AppText(
          text: "Call History",
          color: textWhiteColor,
          size: 20,
        ),
        leading: IconButton(
          onPressed: () {
            Get.to(const MainPage(initialIndex: 0));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('call').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: AppText(
              text: "No calls found",
              color: whiteColor,
              size: 24,
            ));
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var callData = snapshot.data!.docs[index];
                String receiverName = callData['receiverName'];
                String callerName = callData['callerName'];
                String receiverPic = callData['receiverPic'];
                String callerPic = callData['callerPic'];
                String callerId = callData['callerId'];
                bool hasDialled = callData['hasDialled'];
                String currentUserId = currentUser?.uid ?? '';
                String receiverId = callData['receiverId'];
                int timeCalledMilis = callData['timeCalled'];

                DateTime timeCalled =
                    DateTime.fromMillisecondsSinceEpoch(timeCalledMilis);
                String formattedTime = DateFormat.jm().format(timeCalled);
                String formattedDate = DateFormat.yMMMd().format(timeCalled);

                bool isOutgoing = (callerId == currentUserId) && hasDialled;

                bool isThatme = (callerId == currentUserId) ||
                    (receiverId == currentUserId);

                if (isThatme) {
                  return CallHistoryTile(
                    image: isOutgoing ? receiverPic : callerPic,
                    name: isOutgoing ? receiverName : callerName,
                    calltype: isOutgoing ? "Outgoing" : "Incoming",
                    time: formattedTime,
                    date: formattedDate,
                    icon: Icons.call,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              });
        },
      ),
    );
  }
}
