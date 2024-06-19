import 'dart:io';

import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/presentation/getx/controllers/chat_controller.dart';
import 'package:flutter/material.dart';
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
  bool isRecording = false;
  FocusNode focusNode = FocusNode();
  File? _selectedImage;

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

  void sendFileMessage(File file, MessageEnum messageEnum) {
    chatController.sendFileMessage(
      context: context,
      file: file,
      receiverUserId: widget.receiverUserId,
      messageEnum: messageEnum,
    );
    setState(() {
      _selectedImage = null;
    });
  }

  void sendImage() async {
    File? image = await Helpers.pickImageFromGallery(context);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_selectedImage != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Image.file(
                  _selectedImage!,
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: messageController,
                style: const TextStyle(color: whiteColor),
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
                          onPressed: sendImage,
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
                  onTap: () {
                    if (_selectedImage != null) {
                      sendFileMessage(_selectedImage!, MessageEnum.image);
                    } else {
                      sendMessage();
                    }
                  },
                  child: Icon(
                    isShowSendButton || _selectedImage != null
                        ? Icons.send
                        : isRecording
                            ? Icons.close
                            : Icons.mic,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
