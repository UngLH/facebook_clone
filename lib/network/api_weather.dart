import 'package:dio/dio.dart';
import 'package:facebook/configs/app_configs.dart';
import 'package:facebook/models/entities/weather/weather_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_weather.g.dart';

@RestApi(baseUrl: AppConfig.weatherUrl)
abstract class ApiWeather {
  factory ApiWeather(Dio dio, {String baseUrl}) = _ApiWeather;

  @GET("/weather?lat={lat}&lon={lon}&appid={key}&units=metric")
  Future<WeatherResponse> getCurrentWeather(@Path("lat") String latitude,
      @Path("lon") String longitude, @Path("key") String key);
}
