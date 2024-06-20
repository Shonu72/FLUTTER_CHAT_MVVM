import 'dart:io';

import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/presentation/getx/controllers/chat_controller.dart';
import 'package:charterer/presentation/getx/controllers/message_reply_controller.dart';
import 'package:charterer/presentation/screens/chats/widgets/message_reply_preview.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import 'package:video_player/video_player.dart';

class BottomChatFieldSheet extends StatefulWidget {
  final String receiverUserId;
  const BottomChatFieldSheet({super.key, required this.receiverUserId});

  @override
  State<BottomChatFieldSheet> createState() => _BottomChatFieldSheetState();
}

class _BottomChatFieldSheetState extends State<BottomChatFieldSheet> {
  final TextEditingController messageController = TextEditingController();
  final chatController = Get.find<ChatController>();
  final messageReplyController = Get.find<MessageReplyController>();
  bool isShowSendButton = false;
  bool isRecorderInit = false;
  bool isRecording = false;
  FlutterSoundRecorder? _recorder;
  FocusNode focusNode = FocusNode();
  File? _selectedImage;
  File? _selectedVideo;
  File? _selectedFile;
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    openAudio();
  }

  @override
  void dispose() {
    messageController.dispose();
    _videoController?.dispose();
    _recorder?.closeRecorder();
    isRecorderInit = false;
    super.dispose();
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _recorder!.openRecorder();
    isRecorderInit = true;
  }

  void sendTextMessage() async {
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
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await _recorder!.stopRecorder();
        sendFileMessage(File(path), MessageEnum.audio);
      } else {
        await _recorder!.startRecorder(
          toFile: path,
        );
      }

      setState(() {
        isRecording = !isRecording;
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
      _selectedVideo = null;
      _selectedFile = null;
    });
  }

  void sendImage() async {
    File? image = await Helpers.pickImageFromGallery(context);
    if (image != null) {
      setState(() {
        _selectedImage = image;
        _selectedVideo = null;
        _videoController = null;
      });
    }
  }

  void sendVideo() async {
    File? video = await Helpers.pickVideoFromGallery(context);
    if (video != null) {
      _videoController?.dispose();
      _videoController = VideoPlayerController.file(video)
        ..initialize().then((_) {
          setState(() {
            _selectedVideo = video;
            _videoController!.play();
          });
        });
    }
  }

  void sendFiles() async {
    File? file = await Helpers.pickFiles(context);
    if (file != null) {
      sendFileMessage(file, MessageEnum.file);
    }
  }

  void handleAttachmentPressed() {
    FocusScope.of(context).unfocus();
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => SafeArea(
        child: Container(
          height: 200,
          decoration: const BoxDecoration(
            color: textTunaBlueColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    sendVideo();
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.videocam,
                        color: whiteColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: AppText(
                          text: "video",
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    sendFiles();
                    Navigator.pop(context);
                  },
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Row(
                      children: [
                        Icon(
                          Icons.file_copy_outlined,
                          color: whiteColor,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        AppText(
                          text: "file",
                          color: whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Row(
                      children: [
                        Icon(Icons.cancel, color: Colors.red),
                        SizedBox(
                          width: 5,
                        ),
                        AppText(
                          text: "cancel",
                          color: whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = messageReplyController.messageReply.value;
    final isShowMessageReply = messageReply != null;
    return Column(
      children: [
        isShowMessageReply ? MessageReplyPreview() : const SizedBox(),
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
        if (_selectedVideo != null &&
            _videoController != null &&
            _videoController!.value.isInitialized)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 9 / 16,
                  child: VideoPlayer(_videoController!),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _selectedVideo = null;
                        _videoController?.dispose();
                        _videoController = null;
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
                          onPressed: handleAttachmentPressed,
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
                    } else if (_selectedVideo != null) {
                      sendFileMessage(_selectedVideo!, MessageEnum.video);
                    } else {
                      sendTextMessage();
                    }
                  },
                  child: Icon(
                    isShowSendButton ||
                            _selectedImage != null ||
                            _selectedVideo != null
                        ? Icons.send
                        : isRecording
                            ? Icons.stop
                            : Icons.mic,
                    color: isRecording ? Colors.red : whiteColor,
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
