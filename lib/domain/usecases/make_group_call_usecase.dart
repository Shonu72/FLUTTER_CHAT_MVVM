import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/models/call_model.dart';
import 'package:charterer/domain/repositories/call_repository.dart';

class MakeGroupCallUseCase {
  final CallRepository callRepository;

  MakeGroupCallUseCase(this.callRepository);

  Future<void> call(
      CallModel senderCallData, CallModel receiverCallData) async {
    try {
      return callRepository.makeGroupCall(senderCallData, receiverCallData);
    } catch (e) {
      Helpers.toast(e.toString());
    }
  }
}
