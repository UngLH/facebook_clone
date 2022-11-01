// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      main: json['main'] == null
          ? null
          : MainObject.fromJson(json['main'] as Map<String, dynamic>),
      wind: json['wind'] == null
          ? null
          : WindObject.fromJson(json['wind'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>?)
          ?.map((e) => WeatherObject.fromJson(e as Map<String, dynamic>))
          .toList(),
      dt: json['dt'] as int?,
      id: json['id'] as int?,
      timezone: json['timezone'] as int?,
      cod: json['cod'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'main': instance.main,
      'wind': instance.wind,
      'weather': instance.weather,
      'dt': instance.dt,
      'id': instance.id,
      'timezone': instance.timezone,
      'cod': instance.cod,
      'name': instance.name,
    };

MainObject _$MainObjectFromJson(Map<String, dynamic> json) => MainObject(
      temp: (json['temp'] as num?)?.toDouble(),
      feels_like: (json['feels_like'] as num?)?.toDouble(),
      temp_min: (json['temp_min'] as num?)?.toDouble(),
      temp_max: (json['temp_max'] as num?)?.toDouble(),
      pressure: (json['pressure'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MainObjectToJson(MainObject instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feels_like,
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
    };

WindObject _$WindObjectFromJson(Map<String, dynamic> json) => WindObject(
      speed: (json['speed'] as num?)?.toDouble(),
      deg: (json['deg'] as num?)?.toDouble(),
      gust: (json['gust'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WindObjectToJson(WindObject instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };

WeatherObject _$WeatherObjectFromJson(Map<String, dynamic> json) =>
    WeatherObject(
      id: json['id'] as int?,
      main: json['main'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$WeatherObjectToJson(WeatherObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
    };
