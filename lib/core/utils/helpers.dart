import 'dart:convert';
import 'dart:io';
import 'package:charterer/core/utils/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'failure.dart';

enum RequestType { get, post, delete }

class Helpers {
  static toast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static validateEmail(String value) {
    if (value.isEmpty) {
      return "field required";
    }
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@'
        r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]'
        r'+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'invalid email';
  }

  static validateField(String value) {
    if (value.isEmpty || value == 'null') {
      return "field required";
    }
    return null;
  }

  static validatePhone(String value) {
    if (value.length < 10 || value.length > 10) {
      return 'Please Enter Valid Mobile Number';
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> sendRequest(
    Dio dio,
    RequestType type,
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    dynamic data,
  }) async {
    final logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2, // number of method calls to be displayed
          errorMethodCount:
              8, // number of method calls if stacktrace is provided
          lineLength: 200, // width of the output
          colors: true, // Colorful log messages
          printEmojis: true, // Print an emoji for each log message
          printTime: false // Should each log print contain a timestamp
          ),
    );

    debugPrint("Payload ${queryParams ?? data}");

    try {
      Response response;

      switch (type) {
        case RequestType.get:
          response = await dio.get(
            path,
            queryParameters: queryParams,
            options: Options(headers: headers),
          );
          break;

        case RequestType.post:
          response = await dio.post(
            path,
            options: Options(headers: headers, validateStatus: (code) => true),
            data: queryParams ?? data,
          );
          break;

        case RequestType.delete:
          response = await dio.delete(
            path,
            queryParameters: queryParams,
            options: Options(headers: headers),
          );
          break;

        default:
          return null;
      }

      debugPrint(
          "$path response ${response.statusCode} with ${response.statusMessage}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i(jsonEncode(response.data as Map<String, dynamic>));
        return response.data as Map<String, dynamic>;
      } else if (response.statusCode == 400 ||
          response.statusCode == 401 ||
          response.statusCode == 202) {
        logger.i(
            'Failed Response ${const JsonEncoder().convert(response.data as Map<String, dynamic>)}');
        throw ServerException(
          message: response.data['error']['message'],
          code: response.statusCode,
        );
      } else {
        throw ServerException(
          message: response.data['message'],
          code: response.statusCode,
        );
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message, code: e.code);
    } on DioError catch (e) {
      throw ServerException(
          message: e.error is SocketException
              ? 'No Internet Connection'
              : e.error.toString());
    }
  }

  static Future getApiToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('apiToken');
  }

  static Future getApiHeaders() async {
    String token = await getApiToken();
    final Map<String, dynamic> headers = {
      'authtoken': token,
    };
    return headers;
  }

  static String convertFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    }
    return "Unknown error occurred";
  }

  static loader() {
    SmartDialog.showLoading();
  }

  static hideLoader() {
    SmartDialog.dismiss();
  }
}
