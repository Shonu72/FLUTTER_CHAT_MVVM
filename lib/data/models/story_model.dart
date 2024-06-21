import 'package:charterer/domain/entities/story_entity.dart';

class StoryModel extends StoryEntity {
  const StoryModel(
      {required uid,
      required username,
      required phoneNumber,
      required photoUrl,
      required createdAt,
      required profilePic,
      required storyId,
      required whoCanSee})
      : super(
          uid: uid,
          username: username,
          phoneNumber: phoneNumber,
          photoUrl: photoUrl,
          createdAt: createdAt,
          profilePic: profilePic,
          storyId: storyId,
          whoCanSee: whoCanSee,
        );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'profilePic': profilePic,
      'storyId': storyId,
      'whoCanSee': whoCanSee,
    };
  }

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      photoUrl: List<String>.from(map['photoUrl']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      profilePic: map['profilePic'] ?? '',
      storyId: map['storyId'] ?? '',
      whoCanSee: List<String>.from(map['whoCanSee']),
    );
  }
}
