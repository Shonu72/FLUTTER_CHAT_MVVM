import 'package:charterer/data/datasources/charterer_remote_datasource.dart';
import 'package:charterer/data/models/response_models/charterer_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../core/utils/constants.dart';
import '../../core/utils/exceptions.dart';
import '../../core/utils/helpers.dart';

class ChartererRemoteDatasourceImpl extends ChartererRemoteDatasource {
  final Dio _dio;

  ChartererRemoteDatasourceImpl(this._dio);

  @override
  Future<Map<String, dynamic>> addCharterer(
      String? fullName,
      String? email,
      String? country,
      String? mobileNumber,
      String? address,
      String? state,
      String? city,
      String? website) async {
    final headers = await Helpers.getApiHeaders();
    try {
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.post,
        ApiEndpoints.addCharterer,
        headers: headers,
        queryParams: {
          'chartererDetails': {
            'name': fullName,
            'email': email,
            'address1': address,
            'state': state,
            'city': city,
            'country': country,
            'website': website,
            'phoneNumber': mobileNumber,
          }
        },
      );

      debugPrint("login $response");

      return response!;
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<ChartererResponseModel> getCharterers(String? search) async {
    final headers = await Helpers.getApiHeaders();
    try {
      final response = await Helpers.sendRequest(
        _dio,
        RequestType.get,
        ApiEndpoints.getCharterers,
        headers: headers,
        queryParams: {'charterer_name': search},
      );

      debugPrint("login $response");

      return ChartererResponseModel.fromJSON(response!);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
