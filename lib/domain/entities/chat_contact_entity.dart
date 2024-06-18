import 'package:equatable/equatable.dart';

class ChatContactEntity extends Equatable {
  final String name;
  final String profilePic;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;

  const ChatContactEntity({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.timeSent,
    required this.lastMessage,
  });
  
  @override
  List<Object?> get props => [
    name,
    profilePic,
    contactId,
    timeSent,
    lastMessage,
  ];
}
