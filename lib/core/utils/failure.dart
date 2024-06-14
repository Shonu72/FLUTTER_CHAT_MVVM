import 'package:equatable/equatable.dart';

// Abstraction for catching custom exceptions and returning failure objects to UI.
abstract class Failure {
  Failure([List properties = const <dynamic>[]]) : super();
}

// Handles [ServerException] and return Failure object to UI elements.
class ServerFailure extends Failure with EquatableMixin {
  final String message;

  ServerFailure({this.message = 'Some unexpected server failure occured!'}) : super([message]);

  @override
  List<Object> get props => [message];
}
