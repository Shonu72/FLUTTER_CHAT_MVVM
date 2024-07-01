import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:charterer/presentation/screens/main_page.dart';
import 'package:charterer/presentation/screens/notification/notification_tile.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 37, 34, 51),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 37, 34, 51),
            title: const Text(
              "Notifications",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.to(const MainPage(initialIndex: 0));
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 30,
                color: Colors.white,
              ),
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.short_text_rounded,
                        size: 30,
                        color: Colors.white,
                      )))
            ]),
        body: Column(
          children: [
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
            Expanded(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('notifications')
                          .where(
                            'timestamp',
                            isGreaterThan: DateTime.now()
                                .subtract(const Duration(hours: 24)),
                          )
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: AppText(
                            text: "No Notifications",
                            color: whiteColor,
                            size: 24,
                          ));
                        }
                        final notifications = snapshot.data!.docs;

                        return ListView.builder(
                          itemCount: notifications.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final notification = notifications[index];
                            String currentUserId = currentUser?.uid ?? '';
                            Timestamp timestamp = notification['timestamp'];

                            DateTime timeNotif = timestamp.toDate();

                            String formattedTime =
                                DateFormat.jm().format(timeNotif);
                            String formattedDate =
                                DateFormat.yMMMd().format(timeNotif);
                            bool isThisForMe =
                                notification['recipientId'] == currentUserId;

                            return isThisForMe
                                ? NotificationTile(
                                    image: notification['profile'] ?? '',
                                    date: '$formattedDate $formattedTime',
                                    notificationTitle:
                                        notification['senderName'],
                                    message: notification['message'] ?? '',
                                    // date: date,
                                    onTap: () {
                                      Get.toNamed(Routes.chatPage, arguments: {
                                        'uid': notification['senderId'],
                                        'name': notification['senderName'],
                                        'profilePic': notification['profile'],
                                        'isGroupChat': false
                                      });
                                    },
                                  )
                                : const SizedBox.shrink();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )),
          ],
        ));
  }
}
