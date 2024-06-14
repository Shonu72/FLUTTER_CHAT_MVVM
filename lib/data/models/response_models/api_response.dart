import 'package:equatable/equatable.dart';

class ApiResponse extends Equatable {
  final bool status;
  final Map<String, dynamic> data;

  const ApiResponse({required this.status, required this.data});

  @override
  List<Object?> get props => [status, data];
}
