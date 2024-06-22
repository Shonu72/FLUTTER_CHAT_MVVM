import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:story_view/story_view.dart';

class StoryViewScreen extends StatefulWidget {
  const StoryViewScreen({super.key});

  @override
  State<StoryViewScreen> createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> {
  final StoryController controller = StoryController();
  final List<StoryItem> storyItems = [];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    final storyData = args["storyData"];
    initStoryPageItems(storyData);
  }

  void initStoryPageItems(dynamic storyData) {
    for (int i = 0; i < storyData.photoUrl.length; i++) {
      storyItems.add(StoryItem.pageImage(
        url: storyData.photoUrl[i],
        controller: controller,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: storyItems.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : StoryView(
              storyItems: storyItems,
              controller: controller,
              onComplete: () {
                Navigator.pop(context);
              },
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.pop(context);
                }
              },
            ),
    );
  }
}
