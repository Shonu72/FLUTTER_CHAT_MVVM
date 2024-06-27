import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/data/models/call_model.dart';
import 'package:charterer/presentation/getx/controllers/call_controller.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallPickUpScreen extends StatelessWidget {
  final Widget scaffold;
  CallPickUpScreen({super.key, required this.scaffold});
  final args = Get.arguments as Map<String, dynamic>;
  final callController = Get.find<CallController>();
  @override
  Widget build(BuildContext context) {
    final bool isGroupChat = args["isGroupChat"];
    return StreamBuilder<DocumentSnapshot>(
        stream: callController.getCallStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.data() != null) {
            CallModel callModel = CallModel.fromMap(
                snapshot.data!.data() as Map<String, dynamic>);

            if (!callModel.hasDialled) {
              return Scaffold(
                backgroundColor: backgroundDarkColor,
                body: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Incoming Call',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 50),
                      CircleAvatar(
                        backgroundImage: NetworkImage(callModel.callerPic),
                        radius: 60,
                      ),
                      const SizedBox(height: 50),
                      Text(
                        isGroupChat
                            ? callModel.callerName
                            : '${callModel.callerName} is calling you',
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 75),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.call_end,
                                color: Colors.redAccent),
                          ),
                          const SizedBox(width: 25),
                          IconButton(
                            onPressed: () {
                              isGroupChat
                                  ? Get.toNamed(Routes.callScreen, arguments: {
                                      'channelId': callModel.callId,
                                      'call': callModel,
                                      'isGroupChat': true,
                                    })
                                  : Get.toNamed(Routes.callScreen, arguments: {
                                      'channelId': callModel.callId,
                                      'call': callModel,
                                      'isGroupChat': false,
                                    });
                            },
                            icon: const Icon(
                              Icons.call,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return scaffold;
        });
  }
}
