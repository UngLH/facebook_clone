part of 'app_cubit.dart';

class AppState extends Equatable {
  WeatherResponse? weather;
  final LoadStatus? weatherStatus;

  @override
  List<Object?> get props => [
        weather,
        weatherStatus,
      ];

  AppState({
    this.weather,
    this.weatherStatus,
  });

  AppState copyWith({
    WeatherResponse? weather,
    LoadStatus? weatherStatus,
  }) {
    return AppState(
      weather: weather ?? this.weather,
      weatherStatus: weatherStatus ?? this.weatherStatus,
    );
  }
}
