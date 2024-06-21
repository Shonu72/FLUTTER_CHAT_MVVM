// ignore_for_file: use_build_context_synchronously

import 'dart:io';

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
    print(currentUser.toString());

    await uploadStoryUseCase(
      username: currentUser!.name,
      profilePic: currentUser.profilePic,
      phoneNumber: currentUser.phoneNumber,
      storyImage: file,
      context: context,
    );
  }
}
