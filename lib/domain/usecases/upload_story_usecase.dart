import 'dart:io';

import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/domain/repositories/story_repository.dart';
import 'package:flutter/material.dart';

class UploadStoryUseCase {
  final StoryRepository storyRepository;

  UploadStoryUseCase(this.storyRepository);

  Future<void> call({
    required String username,
    required String profilePic,
    required String phoneNumber,
    required File storyImage,
    required BuildContext context,
  }) async {
    try {
      return storyRepository.uploadStory(
        username: username,
        profilePic: profilePic,
        phoneNumber: phoneNumber,
        storyImage: storyImage,
        context: context,
      );
    } catch (e) {
      Helpers.showSnackBar(context: context, content: e.toString());
    }
  }
}
