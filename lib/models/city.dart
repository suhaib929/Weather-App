import 'package:weather_app/models/current_weather.dart';

class City {
  final String name;
  final CurrentWeather? weather;

  const City({
    required this.name,
    this.weather,
  });

  City copyWith({
    String? name,
    CurrentWeather? weather,
  }) {
    return City(
      name: name ?? this.name,
      weather: weather ?? this.weather,
    );
  }
}
