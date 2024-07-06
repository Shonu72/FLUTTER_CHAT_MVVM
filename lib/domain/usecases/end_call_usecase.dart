import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/domain/repositories/call_repository.dart';

class EndCallUseCase {
  final CallRepository callRepository;

  EndCallUseCase(this.callRepository);

  Future<void> call(
      String callerId, String receiverId) async {
    try {
      return callRepository.endCall(callerId, receiverId);
    } catch (e) {
      Helpers.toast(e.toString());
    }
  }
}
