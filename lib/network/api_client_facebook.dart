import 'package:dio/dio.dart';
import 'package:facebook/configs/app_configs.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client_facebook.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/it4788/auth/login?phonenumber={phoneNumber}&password={password}")
  Future<dynamic> authLogin(@Path("phoneNumber") String? phoneNumber,
      @Path("password") String? password);

  @POST("/it4788/auth/signup?phonenumber={phoneNumber}&password={password}")
  Future<dynamic> signUp(@Path("phoneNumber") String? phoneNumber,
      @Path("password") String? password);
}
