import 'package:charterer/domain/usecases/add_charterer.dart';
import 'package:charterer/domain/usecases/get_charterer.dart';
import 'package:charterer/presentation/getx/controllers/chaterer_controller.dart';
import 'package:get/get.dart';


class ChartererBinding extends Bindings{
  @override
  void dependencies() {

    final addCharterer = Get.find<AddCharterer>();
    final getCharterers = Get.find<GetCharterers>();


    Get.lazyPut(() => ChartererController(
        addCharterer: addCharterer,
      getCharterers: getCharterers,

    ));
  }
}