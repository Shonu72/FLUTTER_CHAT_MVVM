import 'dart:convert';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:charterer/core/config/agora_config.dart';
import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/data/models/call_model.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/controllers/call_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final CallController callController = Get.find<CallController>();
  final AuthControlller authController = Get.find<AuthControlller>();
  AgoraClient? client;
  String baseUrl = 'https://agoraserver.up.railway.app';
  late String token;
  late String channelId;
  late CallModel callModel;
  late bool isGroupChat;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    channelId = args["channelId"];
    callModel = args["call"];
    isGroupChat = args["isGroupChat"];
    getToken();
  }

  Future<void> getToken() async {
    final currentUser = await authController.getCurrentUser();
    final uid = currentUser!.uid;
    debugPrint("UID: $uid");
    final response = await http.get(Uri.parse(
      '$baseUrl/access_token?channelName=$channelId',
    ));

    debugPrint("Response status: ${response.statusCode}");
    debugPrint("Response body: ${response.body}");

    if (response.statusCode == 200) {
      try {
        final responseData = jsonDecode(response.body);
        setState(() {
          token = responseData['token'];
          debugPrint("Generated Token: $token");
          debugPrint("Channel Name: $channelId");
        });
        initAgora();
      } catch (e) {
        debugPrint('Error parsing JSON: $e');
      }
    } else {
      debugPrint('Failed to generate token: ${response.body}');
    }
  }

  void initAgora() async {
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        // channelName: channelId,
        channelName: 'test',
        // tempToken: token,
        tempToken:
            '007eJxTYLDqWvWwK2PqGYZefz5OBt2NF5SfbeswFJzhXuUic5Jn7nQFBktDC7MkM4vkZDMjIxODJAuLNIsUozSgoLG5SYplqmnLt+a0hkBGBoUHvCyMDBAI4rMwlKQWlzAwAACVwBz7',
      ),
    );
    await client!.initialize();
    debugPrint(
        "Agora client initialized with channel: $channelId and token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDarkColor,
      body: client == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Stack(
                children: [
                  AgoraVideoViewer(
                    client: client!,
                    showNumberOfUsers: true,
                    showAVState: true,
                  ),
                  AgoraVideoButtons(
                    client: client!,
                    // onDisconnect: () async {
                    //   await client!.engine.leaveChannel();
                    //   isGroupChat
                    //       ? callController.endGroupCall(
                    //           callModel.callerId, callModel.receiverId)
                    //       : callController.endCall(
                    //           callModel.callerId, callModel.receiverId);
                    //   // ignore: use_build_context_synchronously
                    //   Navigator.pop(context);
                    // },
                    disconnectButtonChild: IconButton(
                      onPressed: () async {
                        await client!.engine.leaveChannel();
                        isGroupChat
                            ? callController.endGroupCall(
                                callModel.callerId, callModel.receiverId)
                            : callController.endCall(
                                callModel.callerId, callModel.receiverId);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.call_end,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
