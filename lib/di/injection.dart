import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:get/get.dart';

class DependencyInjector {
  static void inject() {
    _injectChartererUsecases();
  }

 
  static void _injectChartererUsecases() {
    Get.lazyPut(() => AuthControlller());
  }
}
