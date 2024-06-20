import 'package:charterer/core/utils/enums.dart';
import 'package:charterer/domain/entities/messages_entity.dart';

class Message extends MessageEntity {
  Message({
    required String senderId,
    required String recieverid,
    required String text,
    required MessageEnum type,
    required DateTime timeSent,
    required String messageId,
    required bool isSeen,
    required String repliedMessage,
    required String repliedTo,
    required MessageEnum repliedMessageType,
  }) : super(
          senderId: senderId,
          recieverid: recieverid,
          text: text,
          type: type,
          timeSent: timeSent,
          messageId: messageId,
          isSeen: isSeen,
          repliedMessage: repliedMessage,
          repliedTo: repliedTo,
          repliedMessageType: repliedMessageType,
        );

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverid': recieverid,
      'text': text,
      'type': type.type,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
      'repliedMessage': repliedMessage,
      'repliedTo': repliedTo,
      'repliedMessageType': repliedMessageType.type,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
        senderId: map['senderId'] ?? '',
        recieverid: map['recieverid'] ?? '',
        text: map['text'] ?? '',
        type: (map['type'] as String).toEnum(),
        timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
        messageId: map['messageId'] ?? '',
        isSeen: map['isSeen'] ?? false,
        repliedMessage: map['repliedMessage'] ?? '',
        repliedTo: map['repliedTo'] ?? '',
        repliedMessageType: (map['repliedMessageType'] as String).toEnum()
        );
  }
}
