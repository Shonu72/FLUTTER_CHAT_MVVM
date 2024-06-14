import 'package:charterer/core/utils/helpers.dart';
import 'package:charterer/data/models/response_models/api_response.dart';
import 'package:charterer/services/api/auth_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final Dio dio;
  AuthController(this.dio);
  late AuthServices authService = AuthServices(dio);

  Future<ApiResponse> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    // isVerify.value = false;

    final response = await authService.login(
      email: email,
      password: password,
      context: context,
    );
    Map<String, dynamic> data = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    response.fold((failure) {
      print("failed");

      debugPrint(Helpers.convertFailureToMessage(failure));
      debugPrint("Helpers.convertFailureToMessage(failure)");
    }, (success) async {
      data = success;
      print("success");
      print(success);
      print("success");
    });
    return ApiResponse(status: response.isRight(), data: data);
    // return response.isRight();
  }
}
