import 'package:dio/dio.dart';
import 'package:facebook/configs/app_configs.dart';
import 'package:facebook/network/api_client_facebook.dart';
import 'api_weather.dart';
import 'api_interceptors.dart';

class ApiUtil {
  static ApiClient? getApiClient() {
    final dio = Dio();
    dio.options.connectTimeout = 60000;
    dio.interceptors.add(ApiInterceptors());
    final apiClient = ApiClient(dio, baseUrl: AppConfig.baseUrl);
    return apiClient;
  }

  static ApiWeather? getApiWeather() {
    final dio = Dio();
    dio.options.connectTimeout = 60000;
    dio.interceptors.add(ApiInterceptors());
    final apiWeather = ApiWeather(dio, baseUrl: AppConfig.weatherUrl);
    return apiWeather;
  }
}
