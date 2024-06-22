import 'package:charterer/domain/entities/group_entity.dart';

class Group extends GroupEntity {
  const Group({
    required String senderId,
    required String name,
    required String groupId,
    required String lastMessage,
    required String groupPic,
    required List<String> membersUid,
    required DateTime timeSent,
  }) : super(
          senderId: senderId,
          name: name,
          groupId: groupId,
          lastMessage: lastMessage,
          groupPic: groupPic,
          membersUid: membersUid,
          timeSent: timeSent,
        );

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'name': name,
      'groupId': groupId,
      'lastMessage': lastMessage,
      'groupPic': groupPic,
      'membersUid': membersUid,
      'timeSent': timeSent.millisecondsSinceEpoch,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      senderId: map['senderId'] ?? '',
      name: map['name'] ?? '',
      groupId: map['groupId'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      groupPic: map['groupPic'] ?? '',
      membersUid: List<String>.from(map['membersUid'] ?? []),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
    );
  }
}
