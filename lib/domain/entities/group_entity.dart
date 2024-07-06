import 'package:equatable/equatable.dart';

class GroupEntity extends Equatable {
  final String senderId;
  final String name;
  final String groupId;
  final String lastMessage;
  final String groupPic;
  final List<String> membersUid;
  final DateTime timeSent;

  const GroupEntity({
    required this.senderId,
    required this.name,
    required this.groupId,
    required this.lastMessage,
    required this.groupPic,
    required this.membersUid,
    required this.timeSent,
  });
  
  @override
  List<Object?> get props => [
        senderId,
        name,
        groupId,
        lastMessage,
        groupPic,
        membersUid,
        timeSent,
  ];
}
