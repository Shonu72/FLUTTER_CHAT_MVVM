import 'package:charterer/data/models/call_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CallRepository {
  Stream<DocumentSnapshot> getCallStream();
  Future<void> makeCall(CallModel senderCallData, CallModel receiverCallData);
  Future<void> makeGroupCall(
      CallModel senderCallData, CallModel receiverCallData);
  Future<void> endCall(String callerId, String receiverId);
  Future<void> endGroupCall(String callerId, String receiverId);
}
