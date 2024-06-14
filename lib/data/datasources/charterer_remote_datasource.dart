import '../models/response_models/charterer_response_model.dart';

abstract class ChartererRemoteDatasource{

  Future<Map<String, dynamic>> addCharterer(String? fullName, String? email, String? country, String? mobileNumber, String? address, String? state, String? city, String? website);

  Future<ChartererResponseModel> getCharterers(String? search);

}