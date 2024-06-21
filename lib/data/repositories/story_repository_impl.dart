import 'dart:io';

import 'package:charterer/data/datasources/story_datasource.dart';
import 'package:charterer/data/models/story_model.dart';
import 'package:charterer/domain/repositories/story_repository.dart';
import 'package:flutter/material.dart';

class StoryRepositoryImpl implements StoryRepository {
  final StoryDataSource storyDataSource;

  StoryRepositoryImpl({required this.storyDataSource});
  @override
  void uploadStory(
      {required String username,
      required String profilePic,
      required String phoneNumber,
      required File storyImage,
      required BuildContext context}) {
    storyDataSource.uploadStory(
      username: username,
      profilePic: profilePic,
      phoneNumber: phoneNumber,
      storyImage: storyImage,
      context: context,
    );
  }

  @override
  Future<List<StoryModel>> getStories(BuildContext context) {
    // TODO: implement getStories
    throw UnimplementedError();
  }
}
