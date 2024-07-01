import 'package:charterer/presentation/screens/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final notifications = snapshot.data!.docs;

                        return ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notification = notifications[index];

                            return ListTile(
                              
                              title: Text(notification['senderName']),
                              subtitle: Text(notification['message']),
                              onTap: () {
                                Get.toNamed('/chatPage', arguments: {
                                  'senderId': notification['senderId'],
                                  'senderName': notification['senderName'],
                                });
                              },
                            );
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
