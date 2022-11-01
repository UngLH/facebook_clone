import 'package:dio/dio.dart';
import 'package:facebook/configs/app_configs.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client_facebook.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/it4788/auth/login?phonenumber=0858693350&password=ung1234")
  Future<dynamic> authLogin();
}
