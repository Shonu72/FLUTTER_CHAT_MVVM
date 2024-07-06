import 'package:equatable/equatable.dart';

class StoryEntity extends Equatable {
  final String uid;
  final String username;
  final String phoneNumber;
  final List<String> photoUrl;
  final DateTime createdAt;
  final String profilePic;
  final String storyId;
  final List<String> whoCanSee;

  const StoryEntity(
      {required this.uid,
      required this.username,
      required this.phoneNumber,
      required this.photoUrl,
      required this.createdAt,
      required this.profilePic,
      required this.storyId,
      required this.whoCanSee});

  @override
  List<Object?> get props => [
        uid,
        username,
        phoneNumber,
        photoUrl,
        createdAt,
        profilePic,
        storyId,
        whoCanSee
      ];
}
