import 'dart:io';

import 'package:charterer/data/models/story_model.dart';
import 'package:flutter/material.dart';

abstract class StoryDataSource {
  Future<void> uploadStory({
    required String username,
    required String profilePic,
    required String phoneNumber,
    required File storyImage,
    required BuildContext context,
  });

  Future<List<StoryModel>> getStories(BuildContext context);
}
