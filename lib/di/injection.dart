import 'package:charterer/data/datasources/charterer_remote_datasource.dart';
import 'package:charterer/data/repositories/charterer_repository_impl.dart';
import 'package:charterer/domain/repositories/charterer_repository.dart';
import 'package:charterer/presentation/getx/bindings/charterer_binding.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/utils/constants.dart';
import '../data/datasource_impl/charterer_remote_datasource_impl.dart';
import '../domain/usecases/add_charterer.dart';
import '../domain/usecases/get_charterer.dart';

class DependencyInjector{

  static void inject(){

    _injectExternalDependencies();
    _injectDataSources();
    _injectRepositories();
    _injectChartererUsecases();

    ChartererBinding().dependencies();

  }


  static void _injectExternalDependencies() {
    final dio = Dio(
      BaseOptions(baseUrl: ApiEndpoints.baseURL),
    );
    Get.lazyPut<Dio>(() => dio);
  }


  static void _injectDataSources() {
    final dio = Get.find<Dio>();
    Get.lazyPut<ChartererRemoteDatasource>(() => ChartererRemoteDatasourceImpl(dio));

  }

  static void _injectRepositories() {

    final chartererDatasource = Get.find<ChartererRemoteDatasource>();

    Get.lazyPut<ChartererRepository>(() => ChartererRepositoryImpl(chartererDatasource));

  }

  static void _injectChartererUsecases() {
    final authRepository = Get.find<ChartererRepository>();

    Get.lazyPut(() => AddCharterer(authRepository));
    Get.lazyPut(() => GetCharterers(authRepository));

  }

}