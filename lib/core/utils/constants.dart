import 'environment.dart';

class ApiEndpoints {

  static String baseURL = Environment.apiBaseUrl;
// Auth APIs
  static String login = "$baseURL/login";
  static String register = "$baseURL/register";
  /// Home APIs ///
  static String addCharterer = "$baseURL/charterers";
  static String getCharterers = "$baseURL/charterers/search";

}
