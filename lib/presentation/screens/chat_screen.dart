import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/data/models/chat_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      // if (fileType == FileType.video) {
      //   // if (result != null && result.files.single.path != null) {
      //   //   final message = types.VideoMessage(
      //   //     author: _user,
      //   //     createdAt: DateTime.now().millisecondsSinceEpoch,
      //   //     id: const Uuid().v4(),
      //   //     name: result.files.single.name,
      //   //     size: result.files.single.size,
      //   //     uri: result.files.single.path!,
      //   //   );
      //   //   final isSuccess = await chatController.sendMessage(
      //   //       chatId: int.tryParse(widget.chatId)!,
      //   //       file: File(result.files.single.path!),
      //   //       fileType: fType.FileType.video,
      //   //       receiverId: widget.doctorId);
      //   //   if (isSuccess) {
      //   //     //_sendMessage(message);
      //   //   } else {
      //   //     Helpers.toast("Message Not Sent".tr);
      //   //   }
      //   // }
      // // } else {
      // //   if (result != null && result.files.single.path != null) {
      // //     final message = types.FileMessage(
      // //       author: _user,
      // //       createdAt: DateTime.now().millisecondsSinceEpoch,
      // //       id: const Uuid().v4(),
      // //       mimeType: lookupMimeType(result.files.single.path!),
      // //       name: result.files.single.name,
      // //       size: result.files.single.size,
      // //       uri: result.files.single.path!,
      // //     );
      // //     final isSuccess = await chatController.sendMessage(
      // //         chatId: int.tryParse(widget.chatId)!,
      // //         file: File(result.files.single.path!),
      // //         fileType: fType.FileType.file,
      // //         receiverId: widget.doctorId);
      // //     if (isSuccess) {
      // //       //_sendMessage(message);
      // //     } else {
      // //       Helpers.toast("Message Not Sent".tr);
      // //     }
      // //   }
      // // }
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

        // final message = types.ImageMessage(
        //   author: _user,
        //   createdAt: DateTime.now().millisecondsSinceEpoch,
        //   height: image.height.toDouble(),
        //   id: const Uuid().v4(),
        //   name: result.name,
        //   size: bytes.length,
        //   uri: result.path,
        //   width: image.width.toDouble(),
        // );

        // final isSuccess = await chatController.sendMessage(
        //   chatId: int.tryParse(widget.chatId)!,
        //   file: File(result.path),
        //   fileType: fType.FileType.image,
        //   receiverId: widget.doctorId,
        // );
        // if (isSuccess) {
        //   //_sendMessage(message);
        // } else {
        //   Helpers.toast("Message Not Sent".tr);
        // }
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
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 37, 34, 51),
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/bg.jpg"),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "HK",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.green.shade400, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.video_call,
                  size: 30,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 14,
                ),
                const Icon(
                  Icons.call,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            ),
          ),
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
              color: Color.fromARGB(255, 58, 54, 77),
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
