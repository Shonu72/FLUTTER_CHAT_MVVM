import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/presentation/getx/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';

class BottomChatFieldSheet extends StatefulWidget {
  final String receiverUserId;
  const BottomChatFieldSheet({super.key, required this.receiverUserId});

  @override
  State<BottomChatFieldSheet> createState() => _BottomChatFieldSheetState();
}

class _BottomChatFieldSheetState extends State<BottomChatFieldSheet> {
  final TextEditingController messageController = TextEditingController();
  final ChatController chatController = Get.find<ChatController>();
  bool isShowSendButton = false;
  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isRecording = false;
  FocusNode focusNode = FocusNode();

  void sendMessage() {
    if (isShowSendButton) {
      chatController.sendTextMessage(
        context: context,
        text: messageController.text,
        receiverUserId: widget.receiverUserId,
      );
      setState(() {
        messageController.clear();
        isShowSendButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: messageController,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      isShowSendButton = true;
                    });
                  } else {
                    setState(() {
                      isShowSendButton = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: textCharcoalBlueColor,
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.camera_alt,
                            color: whiteColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.attach_file,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hintText: 'Type a message!',
                  hintStyle: const TextStyle(
                    color: Colors.white60,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                right: 2,
                left: 2,
              ),
              child: CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 24,
                child: GestureDetector(
                  child: Icon(
                    isShowSendButton
                        ? Icons.send
                        : isRecording
                            ? Icons.close
                            : Icons.mic,
                    color: Colors.white,
                  ),
                  onTap: sendMessage,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
