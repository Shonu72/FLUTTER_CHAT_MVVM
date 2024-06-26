import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/models/call_model.dart';
import 'package:charterer/domain/repositories/call_repository.dart';

class MakeCallUseCase {
  final CallRepository callRepository;

  MakeCallUseCase(this.callRepository);

  Future<void> call(
      CallModel senderCallData, CallModel receiverCallData) async {
    try {
      return callRepository.makeCall(senderCallData, receiverCallData);
    } catch (e) {
      Helpers.toast(e.toString());
    }
  }
}
