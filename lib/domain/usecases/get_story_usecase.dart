import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/models/story_model.dart';
import 'package:charterer/domain/repositories/story_repository.dart';

class GetStoryUseCase {
  final StoryRepository storyRepository;

  GetStoryUseCase(this.storyRepository);
  Future<List<StoryModel>> call() {
    try {
      return storyRepository.getStories();
    } catch (e) {
      Helpers.toast("error :  ${e.toString()}");
      print("Story nhi mila bhai");
      return Future.error(e.toString());
    }
  }
}
