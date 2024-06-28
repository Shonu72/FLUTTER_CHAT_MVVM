import 'package:cached_network_image/cached_network_image.dart';
import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/controllers/call_controller.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:charterer/presentation/screens/calls/pick_up_screen.dart';
import 'package:charterer/presentation/screens/chats/widgets/bottom_chat_field.dart';
import 'package:charterer/presentation/screens/chats/widgets/chat_list.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
  });

  final AuthControlller authcontroller = Get.find<AuthControlller>();
  final CallController callController = Get.find<CallController>();
  final args = Get.arguments as Map<String, dynamic>;
  @override
  Widget build(BuildContext context) {
    final String name = args["name"];
    final String uid = args["uid"];
    final String profile = args["profilePic"];
    final bool isGroupChat = args["isGroupChat"];

    void makeCall() async {
      if (await Helpers.checkPermissions()) {
        callController.makeCall(name, uid, profile);
      } else {
        await Helpers.requestPermissions();
      }
    }

    void makeGroupCall() async {
      if (await Helpers.checkPermissions()) {
        callController.makeGroupCall(name, uid, profile);
      } else {
        await Helpers.requestPermissions();
      }
    }

    return CallPickUpScreen(
      scaffold: Scaffold(
        backgroundColor: const Color.fromARGB(255, 42, 39, 62),
        appBar: AppBar(
          backgroundColor:
              backgroundDarkColor.withBlue(backgroundDarkColor.blue + 20),
          leading: IconButton(
            onPressed: () {
              // Get.to(const MainPage());
              Get.toNamed(Routes.mainPage);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
          titleSpacing: 0,
          title: isGroupChat
              ? Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(profile),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        AppText(
                          text: name,
                          color: whiteColor,
                          size: 18,
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () => makeGroupCall(),
                        icon: const Icon(
                          Icons.video_call,
                          color: whiteColor,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.call,
                          color: whiteColor,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          color: whiteColor,
                        )),
                  ],
                )
              : StreamBuilder<UserModel>(
                  stream: authcontroller.userData(uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print("online : ${snapshot.data!.isOnline}");
                      return Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage:
                                CachedNetworkImageProvider(profile),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              AppText(
                                text: name,
                                color: whiteColor,
                                size: 18,
                              ),
                              Text(
                                  snapshot.data!.isOnline
                                      ? "Online"
                                      : "Offline",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: snapshot.data!.isOnline
                                          ? Colors.green
                                          : Colors.grey)),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () => makeCall(),
                              icon: const Icon(
                                Icons.video_call,
                                color: whiteColor,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.call,
                                color: whiteColor,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.more_vert,
                                color: whiteColor,
                              )),
                        ],
                      );
                    } else {
                      return const Text("User");
                    }
                  },
                ),
        ),
        body: Column(
          children: [
            Expanded(
                child: ChatList(
              receiverUserId: uid,
              isGroupChat: isGroupChat,
            )),
            BottomChatFieldSheet(
              receiverUserId: uid,
              isGroupChat: isGroupChat,
            )
          ],
        ),
      ),
    );
  }
}
