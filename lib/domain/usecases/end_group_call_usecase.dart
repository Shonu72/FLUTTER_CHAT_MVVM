import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/domain/repositories/call_repository.dart';

class EndGroupCallUseCase {
  final CallRepository callRepository;

  EndGroupCallUseCase(this.callRepository);

  Future<void> call(String callerId, String receiverId) async {
    try {
      return callRepository.endGroupCall(callerId, receiverId);
    } catch (e) {
      Helpers.toast(e.toString());
    }
  }
}
