import 'package:json_annotation/json_annotation.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class WeatherResponse {
  MainObject? main;
  WindObject? wind;
  List<WeatherObject>? weather;
  int? dt;
  int? id;
  int? timezone;
  int? cod;
  String? name;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);

  WeatherResponse({
    this.main,
    this.wind,
    this.weather,
    this.dt,
    this.id,
    this.timezone,
    this.cod,
    this.name,
  });

  WeatherResponse copyWith({
    MainObject? main,
    WindObject? wind,
    List<WeatherObject>? weather,
    int? dt,
    int? id,
    int? timezone,
    int? cod,
    String? name,
  }) {
    return WeatherResponse(
      main: main ?? this.main,
      wind: wind ?? this.wind,
      weather: weather ?? this.weather,
      dt: dt ?? this.dt,
      id: id ?? this.id,
      timezone: timezone ?? this.timezone,
      cod: cod ?? this.cod,
      name: name ?? this.name,
    );
  }
}

@JsonSerializable()
class MainObject {
  double? temp;
  double? feels_like;
  double? temp_min;
  double? temp_max;
  double? pressure;
  double? humidity;

  factory MainObject.fromJson(Map<String, dynamic> json) =>
      _$MainObjectFromJson(json);
  Map<String, dynamic> toJson() => _$MainObjectToJson(this);

  MainObject({
    this.temp,
    this.feels_like,
    this.temp_min,
    this.temp_max,
    this.pressure,
    this.humidity,
  });

  MainObject copyWith({
    double? temp,
    double? feels_like,
    double? temp_min,
    double? temp_max,
    double? pressure,
    double? humidity,
  }) {
    return MainObject(
      temp: temp ?? this.temp,
      feels_like: feels_like ?? this.feels_like,
      temp_min: temp_min ?? this.temp_min,
      temp_max: temp_max ?? this.temp_max,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
    );
  }
}

@JsonSerializable()
class WindObject {
  double? speed;
  double? deg;
  double? gust;

  factory WindObject.fromJson(Map<String, dynamic> json) =>
      _$WindObjectFromJson(json);
  Map<String, dynamic> toJson() => _$WindObjectToJson(this);

  WindObject({
    this.speed,
    this.deg,
    this.gust,
  });

  WindObject copyWith({
    double? speed,
    double? deg,
    double? gust,
  }) {
    return WindObject(
      speed: speed ?? this.speed,
      deg: deg ?? this.deg,
      gust: gust ?? this.gust,
    );
  }
}

@JsonSerializable()
class WeatherObject {
  int? id;
  String? main;
  String? description;

  factory WeatherObject.fromJson(Map<String, dynamic> json) =>
      _$WeatherObjectFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherObjectToJson(this);

  WeatherObject({
    this.id,
    this.main,
    this.description
  });

  WeatherObject copyWith({
    int? id,
    String? main,
    String? description,
  }) {
    return  WeatherObject(
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description
    );
  }
}
