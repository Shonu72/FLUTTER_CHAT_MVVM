import 'package:charterer/domain/repositories/call_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetCallStreamUseCase {
  final CallRepository repository;

  GetCallStreamUseCase(this.repository);

  Stream<DocumentSnapshot> call() {
    return repository.getCallStream();
  }
}
