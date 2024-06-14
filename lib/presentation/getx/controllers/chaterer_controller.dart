import 'package:charterer/core/usecases/charterer_params.dart';
import 'package:charterer/domain/entities/charterer.dart';
import 'package:charterer/domain/usecases/add_charterer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/usecases/usecase.dart';
import '../../../core/utils/helpers.dart';
import '../../../domain/usecases/get_charterer.dart';

class ChartererController extends GetxController {
  final AddCharterer _addCharterer;
  final GetCharterers _getCharterers;

  ChartererController({
    required AddCharterer addCharterer,
    required GetCharterers getCharterers,
  })  : _addCharterer = addCharterer,
        _getCharterers = getCharterers;

  final errorMessage = ''.obs;

  final addChartererResponse = {}.obs;

  final charterers = <Charterer>[].obs;
  final isCharterersFetching = false.obs;

  Future<bool> addCharterer({
    String? fullName,
    String? email,
    String? country,
    String? mobileNumber,
    String? address,
    String? state,
    String? city,
    String? website,
  }) async {
    final failureOrSuccess = await _addCharterer(
      Params(
        chartererParams: ChartererParams(
            fullName: fullName,
            email: email,
            country: country,
            mobileNumber: mobileNumber,
            address: address,
            state: state,
            city: city,
            website: website),
      ),
    );

    failureOrSuccess.fold(
      (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
      },
      (success) {
        addChartererResponse.value = success;
        Helpers.toast("Charterer Added Successfully");
        Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }

  Future<bool> getCharterers({String? search}) async {
    isCharterersFetching(true);
    final failureOrSuccess = await _getCharterers(
      Params(
        chartererParams: ChartererParams(
          search: search,
        ),
      ),
    );

    failureOrSuccess.fold(
      (failure) {
        errorMessage.value = Helpers.convertFailureToMessage(failure);
        debugPrint(errorMessage.value);
        Helpers.toast(errorMessage.value);
        isCharterersFetching(false);
      },
      (success) {
        charterers.value = success.chartererList;
        isCharterersFetching(false);
        Helpers.toast('Profile Changed');
      },
    );
    return failureOrSuccess.isRight() ? true : false;
  }
}
