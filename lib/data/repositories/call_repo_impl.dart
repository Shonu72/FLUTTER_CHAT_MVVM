import 'package:charterer/data/datasources/make_call_datasource.dart';
import 'package:charterer/data/models/call_model.dart';
import 'package:charterer/domain/repositories/call_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MakeCallRepoImpl implements CallRepository {
  final MakeCallDataSource makeCallDataSource;

  MakeCallRepoImpl(this.makeCallDataSource);

  @override
  Future<void> makeCall(CallModel senderCallData, CallModel receiverCallData) {
    return makeCallDataSource.makeCall(senderCallData, receiverCallData);
  }

  @override
  Stream<DocumentSnapshot> getCallStream() {
    return makeCallDataSource.getCallStream();
  }

  @override
  Future<void> makeGroupCall(
      CallModel senderCallData, CallModel receiverCallData) async {
    return makeCallDataSource.makeGroupCall(senderCallData, receiverCallData);
  }

  @override
  Future<void> endCall(String callerId, String receiverId) async {
    return makeCallDataSource.endCall(callerId, receiverId);
  }

  @override
  Future<void> endGroupCall(String callerId, String receiverId) async {
    return makeCallDataSource.endGroupCall(callerId, receiverId);
  }
}
