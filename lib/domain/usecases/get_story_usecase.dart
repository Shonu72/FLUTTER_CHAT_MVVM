import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/models/story_model.dart';
import 'package:charterer/domain/repositories/story_repository.dart';
import 'package:flutter/material.dart';

class GetStoryUseCase {
  final StoryRepository storyRepository;

  GetStoryUseCase(this.storyRepository);
  Future<List<StoryModel>> call(BuildContext context) async {
    try {
      return storyRepository.getStories(context);
    } catch (e) {
      return Helpers.showSnackBar(context: context, content: e.toString());
    }
  }
}
