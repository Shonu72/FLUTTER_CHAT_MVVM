import 'package:charterer/core/utils/constants.dart';
import 'package:charterer/core/utils/exceptions.dart';
import 'package:charterer/core/utils/failure.dart';
import 'package:charterer/core/utils/helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class AuthServices {
  final Dio dio;

  AuthServices(this.dio);

  ServerException date = ServerException();

  Future<Either<Failure, Map<String, dynamic>>> login(
      {required String email,
      required String password,
      required context}) async {
    try {
      final response = await Helpers.sendRequest(
          dio, RequestType.post, ApiEndpoints.login,
          queryParams: {'email': email, 'password': password});
      var responseData = response?['data'];
      print("response data from login : $responseData");
      return Right(response?['data']);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> register(
      {required Map<String, dynamic> body}) async {
    try {
      final response = await Helpers.sendRequest(
        dio,
        RequestType.post,
        ApiEndpoints.register,
        data: body,
      );
      var responseData = response?['data'];
      print("data from register : $responseData");

      return Right(response!);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
