import 'dart:io';

import 'package:charterer/core/theme/colors.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/presentation/getx/controllers/story_controller.dart';
import 'package:charterer/presentation/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmStoryScreen extends StatelessWidget {
  ConfirmStoryScreen({super.key});
  final storyController = Get.find<StoryController>();

  void addStory(File file, BuildContext context) {
    storyController.uploadStory(file, context);
    Helpers.toast("uploading story");
    Future.delayed(const Duration(seconds: 3), () {
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;

    final File storyImage = args["storyImage"];
    return Scaffold(
      backgroundColor: backgroundDarkColor,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor:
            backgroundDarkColor.withBlue(backgroundDarkColor.blue + 20),
        title: const AppText(
          text: "Confirm Story",
          size: 20,
          color: whiteColor,
        ),
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: whiteColor,
            )),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Image.file(storyImage),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            addStory(storyImage, context);
          },
          child: const Icon(Icons.check)),
    );
  }
}
