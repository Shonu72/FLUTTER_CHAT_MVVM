import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/data/models/chat_model.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatelessWidget {
  // final String name;
  // final String uid;
  const ChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final authcontroller = Get.find<AuthControlller>();

    final String name = args["name"];
    final String uid = args["uid"];
    List<ChatMessage> messages = [
      ChatMessage(messageContent: "Hello", messageType: "receiver"),
      ChatMessage(messageContent: "How are you?", messageType: "receiver"),
      ChatMessage(
          messageContent: "Hi there, I am doing fine. wbu?",
          messageType: "sender"),
      ChatMessage(messageContent: "I'm good.", messageType: "receiver"),
      ChatMessage(
          messageContent: "Is there any thing wrong?", messageType: "sender"),
    ];

    void handleFileSelection({FileType fileType = FileType.any}) async {
      FilePickerResult? result;
      if (fileType == FileType.custom) {
        result = await FilePicker.platform.pickFiles(
            type: fileType, allowedExtensions: ['pdf', 'doc', 'docx']);
      } else {
        result = await FilePicker.platform.pickFiles(
          type: fileType,
        );
      }
    }

    void handleImageSelection(
        {ImageSource imageSource = ImageSource.gallery}) async {
      final result = await ImagePicker().pickImage(
        imageQuality: 70,
        maxWidth: 1440,
        source: imageSource,
      );

      if (result != null) {
        final bytes = await result.readAsBytes();
        final image = await decodeImageFromList(bytes);
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
              color: textWhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      handleImageSelection();
                      Navigator.pop(context);
                    },
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Row(
                        children: [
                          Icon(Icons.photo),
                          SizedBox(
                            width: 5,
                          ),
                          Text("picture"),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // handleFileSelection(fileType: FileType.video);
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.videocam),
                        SizedBox(
                          width: 5,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text("video"),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      handleFileSelection(fileType: FileType.custom);
                      Navigator.pop(context);
                    },
                    child: const Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Row(
                        children: [
                          Icon(Icons.file_copy_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Text("file"),
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
                          Icon(Icons.cancel),
                          SizedBox(
                            width: 5,
                          ),
                          Text("cancel"),
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

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 42, 39, 62),
      appBar: AppBar(
        backgroundColor:
            backgroundDarkColor.withBlue(backgroundDarkColor.blue + 20),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
        titleSpacing: 0,
        title: StreamBuilder<UserModel>(
          stream: authcontroller.userData(uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data!.isOnline);
              return Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data!.profilePic),
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
                      Text(snapshot.data!.isOnline ? "Online" : "Offline",
                          style: TextStyle(
                              fontSize: 12,
                              color: snapshot.data!.isOnline
                                  ? Colors.green
                                  : Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
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
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(
                    left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].messageType == "receiver"
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].messageType == "receiver"
                          ? Colors.grey.shade200
                          : Colors.blue[200]),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      messages[index].messageContent,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: const Color.fromARGB(255, 58, 54, 77),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      handleAttachmentPressed();
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: const TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white54),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
