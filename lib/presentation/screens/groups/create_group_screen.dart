import 'dart:io';

import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/presentation/getx/controllers/contact_controller.dart';
import 'package:charterer/presentation/getx/controllers/group_controller.dart';
import 'package:charterer/presentation/screens/groups/widgets/select_contact.dart';
import 'package:charterer/presentation/screens/main_page.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final groupController = Get.find<GroupController>();
  final contactController = Get.find<SelectContactController>();

  TextEditingController groupNameController = TextEditingController();
  File? image;

  void pickImage() async {
    image = await Helpers.pickImageFromGallery(context);
    setState(() {});
  }

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  void createGroup() {
    try {
      if (groupNameController.text.isNotEmpty && image != null) {
        groupController.createGroup(
          groupNameController.text,
          image!,
          contactController.selectedGroupContacts,
        );
        Get.back();
      }
    } catch (e) {
      Helpers.toast("Please provide group name and image.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDarkColor,
      appBar: AppBar(
        backgroundColor:
            backgroundDarkColor.withBlue(backgroundDarkColor.blue + 20),
        title: const AppText(
          text: "Create Group",
          color: whiteColor,
          size: 24,
        ),
        leading: IconButton(
          onPressed: () {
            Get.to(const MainPage(
              initialIndex: 0,
            ));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Stack(
                children: [
                  image == null
                      ? const CircleAvatar(
                          backgroundImage: AssetImage('assets/images/boy.png'),
                          radius: 100,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            image!,
                          ),
                          radius: 100,
                        ),
                  Positioned(
                      right: 10,
                      bottom: 20,
                      child: IconButton(
                        onPressed: pickImage,
                        icon: const Icon(
                          Icons.add_a_photo_sharp,
                          color: whiteColor,
                          size: 30,
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  style: const TextStyle(color: whiteColor),
                  controller: groupNameController,
                  cursorColor: whiteColor,
                  decoration: const InputDecoration(
                      hintText: 'Enter Group Name',
                      hintStyle: TextStyle(color: whiteColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: whiteColor,
                        ),
                      )),
                ),
              ),
              const SelectGroupContact(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createGroup,
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    );
  }
}
