import 'package:equatable/equatable.dart';

class CallEntity extends Equatable {
  final String callerId;
  final String callerName;
  final String callerPic;
  final String receiverId;
  final String receiverName;
  final String receiverPic;
  final String callId;
  final bool hasDialled;
  final DateTime timeCalled;

  // final CallsEnum type;

  const CallEntity( {
    required this.callerId,
    required this.callerName,
    required this.callerPic,
    required this.receiverId,
    required this.receiverName,
    required this.receiverPic,
    required this.callId,
    required this.hasDialled,
    required this.timeCalled,
    // required this.type,
  });

  @override
  List<Object?> get props => [
        callerId,
        callerName,
        callerPic,
        receiverId,
        receiverName,
        receiverPic,
        callId,
        hasDialled,
        timeCalled,
        // type,
      ];
}
