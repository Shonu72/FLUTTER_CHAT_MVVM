import 'package:charterer/data/models/story_model.dart';
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
  late List<StoryModel> allStories;
  late PageController pageController;
  int currentUserIndex = 0;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    allStories = args["allStories"];
    currentUserIndex = args["initialIndex"];
    pageController = PageController(initialPage: currentUserIndex);
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  List<StoryItem> getStoryItems(StoryModel storyData) {
    List<StoryItem> items = [];
    for (var url in storyData.photoUrl) {
      items.add(StoryItem.pageImage(url: url, controller: controller));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: allStories.length,
        onPageChanged: (index) {
          setState(() {
            currentUserIndex = index;
          });
          // controller.next();
        },
        itemBuilder: (context, index) {
          final storyData = allStories[index];
          return StoryView(
            storyItems: getStoryItems(storyData),
            controller: controller,
            indicatorColor: Colors.white,
            indicatorForegroundColor: Colors.blue,
            onComplete: () {
              if (index < allStories.length - 1) {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                Navigator.pop(context);
              }
            },
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                Navigator.pop(context);
              }
            },
          );
        },
      ),
    );
  }
}
