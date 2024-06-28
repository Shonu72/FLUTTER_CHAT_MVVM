import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/datasources/make_call_datasource.dart';
import 'package:charterer/data/models/call_model.dart';
import 'package:charterer/data/models/group_model.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MakeCallDataSourceImpl implements MakeCallDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  MakeCallDataSourceImpl({
    required this.firestore,
    required this.auth,
  });

  @override
  Future<void> makeCall(
      CallModel senderCallData, CallModel receiverCallData) async {
    try {
      await firestore
          .collection('call')
          .doc(senderCallData.callId)
          .set(senderCallData.toMap());

      await firestore
          .collection('call')
          .doc(senderCallData.receiverId)
          .set(receiverCallData.toMap());

      Get.toNamed(Routes.callScreen, arguments: {
        'channelId': senderCallData.callId,
        'call': senderCallData,
        'isGroupChat': false
      });
    } catch (e) {
      print(e);
      Helpers.toast("Error making call : ${e.toString()}");
    }
  }

  @override
  Stream<DocumentSnapshot> getCallStream() {
    String uid = auth.currentUser!.uid;
    return firestore.collection('call').doc(uid).snapshots();
  }

  @override
  Future<void> makeGroupCall(
      CallModel senderCallData, CallModel receiverCallData) async {
    try {
      await firestore
          .collection('call')
          .doc(senderCallData.callId)
          .set(senderCallData.toMap());

      var groupSnapshot = await firestore
          .collection('groups')
          .doc(senderCallData.receiverId)
          .get();
      Group group = Group.fromMap(groupSnapshot.data()!);

      for (var id in group.membersUid) {
        await firestore
            .collection('call')
            .doc(id)
            .set(receiverCallData.toMap());
      }

      Get.toNamed(Routes.callScreen, arguments: {
        'channelId': senderCallData.callId,
        'call': senderCallData,
        'isGroupChat': true
      });
    } catch (e) {
      print(e);
      Helpers.toast("Error making call : ${e.toString()}");
    }
  }

  @override
  Future<void> endCall(String callerId, String receiverId) async {
    try {
      await firestore.collection('call').doc(callerId).delete();
      await firestore.collection('call').doc(receiverId).delete();
    } catch (e) {
      Helpers.toast(e.toString());
    }
  }

  @override
  Future<void> endGroupCall(String callerId, String receiverId) async {
    try {
      await firestore.collection('call').doc(callerId).delete();
      var groupSnapshot =
          await firestore.collection('groups').doc(receiverId).get();
      Group group = Group.fromMap(groupSnapshot.data()!);
      for (var id in group.membersUid) {
        await firestore.collection('call').doc(id).delete();
      }
    } catch (e) {
      Helpers.toast(e.toString());
    }
  }
}
