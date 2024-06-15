import 'package:charterer/domain/entities/user_entities.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String name,
    required String uid,
    required String profilePic,
    required bool isOnline,
    required String phoneNumber,
    required List<String> groupId,
  }) : super(
          name: name,
          uid: uid,
          profilePic: profilePic,
          isOnline: isOnline,
          phoneNumber: phoneNumber,
          groupId: groupId,
        );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      profilePic: map['profilePic'] ?? '',
      isOnline: map['isOnline'] ?? false,
      phoneNumber: map['phoneNumber'] ?? '',
      groupId: List<String>.from(map['groupId']),
    );
  }
}
