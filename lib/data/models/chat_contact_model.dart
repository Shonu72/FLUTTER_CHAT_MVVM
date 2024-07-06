import 'package:charterer/domain/entities/chat_contact_entity.dart';

class ChatContact extends ChatContactEntity {
  const ChatContact({
    required String name,
    required String profilePic,
    required String contactId,
    required DateTime timeSent,
    required String lastMessage,
  }) : super(
          name: name,
          profilePic: profilePic,
          contactId: contactId,
          timeSent: timeSent,
          lastMessage: lastMessage,
        );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      contactId: map['contactId'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      lastMessage: map['lastMessage'] ?? '',
    );
  }
}
