// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/models/story_model.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/domain/usecases/get_story_usecase.dart';
import 'package:charterer/domain/usecases/upload_story_usecase.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryController extends GetxController {
  final UploadStoryUseCase uploadStoryUseCase;
  final GetStoryUseCase getStoryUseCase;

  StoryController({
    required this.uploadStoryUseCase,
    required this.getStoryUseCase,
  });

  final AuthControlller authController = Get.find<AuthControlller>();

  Future<void> uploadStory(File file, BuildContext context) async {
    UserModel? currentUser = await authController.getCurrentUser();
    print("current user : ${currentUser!.name}");
    print("current user : ${currentUser.profilePic}");
    print("current user : ${currentUser.phoneNumber}");

    await uploadStoryUseCase(
      username: currentUser.name,
      profilePic: currentUser.profilePic,
      phoneNumber: currentUser.phoneNumber,
      storyImage: file,
      context: context,
    );
    Helpers.toast("Story uploaded successfully");
  }

  Future<List<StoryModel>> getStories() async {
    List<StoryModel> stories = await getStoryUseCase();
    print("stories.length from controller: ${stories.length}");
    return stories;
  }
}
