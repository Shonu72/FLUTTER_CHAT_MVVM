import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/models/call_model.dart';
import 'package:charterer/data/models/user_model.dart';
import 'package:charterer/domain/usecases/end_call_usecase.dart';
import 'package:charterer/domain/usecases/end_group_call_usecase.dart';
import 'package:charterer/domain/usecases/get_call_usecase.dart';
import 'package:charterer/domain/usecases/make_call_usecase.dart';
import 'package:charterer/domain/usecases/make_group_call_usecase.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CallController extends GetxController {
  final MakeCallUseCase makeCallUseCase;
  final GetCallStreamUseCase getCallStreamUseCase;
  final MakeGroupCallUseCase makeGroupCallUseCase;
  final EndCallUseCase endCallUseCase;
  final EndGroupCallUseCase endGroupCallUseCase;

  CallController({
    required this.getCallStreamUseCase,
    required this.makeCallUseCase,
    required this.makeGroupCallUseCase,
    required this.endCallUseCase,
    required this.endGroupCallUseCase,
  });

  final authController = Get.find<AuthControlller>();

  void makeCall(String receiverName, String receiverUid,
      String receiverProfilePic) async {
    String callId = const Uuid().v1();
    UserModel? currentUser = await authController.getCurrentUser();

    CallModel senderCallData = CallModel(
      callerId: currentUser!.uid,
      callerName: currentUser.name,
      callerPic: currentUser.profilePic,
      receiverId: receiverUid,
      receiverName: receiverName,
      receiverPic: receiverProfilePic,
      callId: callId,
      hasDialled: true,
      timeCalled: DateTime.now(),
    );

    CallModel receiverCallData = CallModel(
      callerId: currentUser.uid,
      callerName: currentUser.name,
      callerPic: currentUser.profilePic,
      receiverId: receiverUid,
      receiverName: receiverName,
      receiverPic: receiverProfilePic,
      callId: callId,
      hasDialled: false,
      timeCalled: DateTime.now(),
    );

    await makeCallUseCase(senderCallData, receiverCallData);
    Get.toNamed(Routes.callScreen, arguments: {
      'channelId': senderCallData.callId,
      'call': senderCallData,
      'isGroupChat': false
    });
    Helpers.toast("Calling ...");
  }

  void makeGroupCall(String receiverName, String receiverUid,
      String receiverProfilePic) async {
    String callId = const Uuid().v1();
    UserModel? currentUser = await authController.getCurrentUser();

    CallModel senderCallData = CallModel(
      callerId: currentUser!.uid,
      callerName: currentUser.name,
      callerPic: currentUser.profilePic,
      receiverId: receiverUid,
      receiverName: receiverName,
      receiverPic: receiverProfilePic,
      callId: callId,
      hasDialled: true,
      timeCalled: DateTime.now(),
    );

    CallModel receiverCallData = CallModel(
      callerId: currentUser.uid,
      callerName: currentUser.name,
      callerPic: currentUser.profilePic,
      receiverId: receiverUid,
      receiverName: receiverName,
      receiverPic: receiverProfilePic,
      callId: callId,
      hasDialled: false,
      timeCalled: DateTime.now(),
    );

    await makeGroupCallUseCase(senderCallData, receiverCallData);
    Get.toNamed(Routes.callScreen, arguments: {
      'channelId': senderCallData.callId,
      'call': senderCallData,
      'isGroupChat': true
    });
    Helpers.toast("Calling ...");
  }

  Stream<DocumentSnapshot> getCallStream() {
    return getCallStreamUseCase();
  }

  void endCall(String callerId, String receiverId) async {
    await endCallUseCase(callerId, receiverId);
    update();
  }

  void endGroupCall(String callerId, String receiverId) async {
    await endGroupCallUseCase(callerId, receiverId);
    update();
  }
}
