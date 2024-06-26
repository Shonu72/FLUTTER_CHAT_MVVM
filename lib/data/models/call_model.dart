import 'package:charterer/core/utils/calls_enum.dart';
import 'package:charterer/domain/entities/call_entity.dart';

class CallModel extends CallEntity {
  const CallModel({
    required String callerId,
    required String callerName,
    required String callerPic,
    required String receiverId,
    required String receiverName,
    required String receiverPic,
    required String callId,
    required bool hasDialled,
    // required CallsEnum type,
  }) : super(
          callerId: callerId,
          callerName: callerName,
          callerPic: callerPic,
          receiverId: receiverId,
          receiverName: receiverName,
          receiverPic: receiverPic,
          callId: callId,
          hasDialled: hasDialled,
          // type: type,
        );

  Map<String, dynamic> toMap() {
    return {
      'callerId': callerId,
      'callerName': callerName,
      'callerPic': callerPic,
      'receiverId': receiverId,
      'receiverName': receiverName,
      'receiverPic': receiverPic,
      'callId': callId,
      'hasDialled': hasDialled,
      // 'type': type.type,
    };
  }

  factory CallModel.fromMap(Map<String, dynamic> map) {
    return CallModel(
      callerId: map['callerId'] ?? '',
      callerName: map['callerName'] ?? '',
      callerPic: map['callerPic'] ?? '',
      receiverId: map['receiverId'] ?? '',
      receiverName: map['receiverName'] ?? '',
      receiverPic: map['receiverPic'] ?? '',
      callId: map['callId'] ?? '',
      hasDialled: map['hasDialled'] ?? false,
      // type: (map['type'] as String).toEnum(),
    );
  }
}
