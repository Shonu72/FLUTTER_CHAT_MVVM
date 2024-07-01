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
  String? token;

  Future<void> getToken() async {
    final currentUser = await authController.getCurrentUser();
    final uid = currentUser!.uid;
    final response = await http.get(Uri.parse(
      '$baseUrl/access_token?channelName=video$uid&role=subscriber&uid=0',
    ));
    if (response.statusCode == 200) {
      setState(() {
        token = jsonDecode(response.body)['token'];
        print("token: $token");
      });
      // Initialize Agora
      initAgora();
    }
  }

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    final String channelId = args["channelId"];
    CallModel callModel = args["call"];
    getToken();
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: channelId,
        tokenUrl: baseUrl,
        tempToken: token,
        username: callModel.callerName,
      ),
      enabledPermission: [
        Permission.camera,
        Permission.microphone,
      ],
    );
    initAgora();
  }

  void initAgora() async {
    await client!.initialize();
    await client!.engine.enableVideo();
    await client!.engine.startPreview();
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    CallModel callModel = args["call"];
    final bool isGroupChat = args["isGroupChat"];

    return Scaffold(
      backgroundColor: backgroundDarkColor,
      body: client == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Stack(
                children: [
                  AgoraVideoViewer(
                    client: client!,
                    layoutType: Layout.floating,
                    showNumberOfUsers: true,
                    enableHostControls: true,
                  ),
                  AgoraVideoButtons(
                    client: client!,
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
