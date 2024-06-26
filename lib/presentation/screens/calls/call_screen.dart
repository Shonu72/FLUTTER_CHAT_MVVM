import 'package:agora_uikit/agora_uikit.dart';
import 'package:charterer/core/config/agora_config.dart';
import 'package:charterer/data/models/call_model.dart';
import 'package:charterer/presentation/getx/controllers/call_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final callController = Get.find<CallController>();
  AgoraClient? client;
  String baseUrl = 'https://agoraserver-production-72e6.up.railway.app/';

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    final String channelId = args["channelId"];
    CallModel callModel = args["call"];
    // final bool isGroupChat = args["isGroupChat"];

    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: channelId,
        tokenUrl: baseUrl,
      ),
    );
    initAgora();
  }

  void initAgora() async {
    await client!.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    CallModel callModel = args["call"];
    return Scaffold(
      body: client == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Stack(
              children: [
                AgoraVideoViewer(client: client!),
                AgoraVideoButtons(
                  client: client!,
                  disconnectButtonChild: IconButton(
                    onPressed: () async {
                      await client!.engine.leaveChannel();
                      callController.endCall(
                          callModel.callerId, callModel.receiverId);
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.call_end,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            )),
    );
  }
}
