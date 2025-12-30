class CurrentWeather {
  final String city;
  final double temperature;
  final String condition;
  final String iconUrl;
  final int humidity;
  final double windKph;
  final double feelsLike;
  final double lat;
  final double lon;

  const CurrentWeather({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.iconUrl,
    required this.humidity,
    required this.windKph,
    required this.feelsLike,
    required this.lat,
    required this.lon,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final location = json['location'] ?? {};
    final current = json['current'] ?? {};

    return CurrentWeather(
      city: location['name'] ?? '',
      temperature: (current['temp_c'] ?? 0).toDouble(),
      condition: current['condition']?['text'] ?? '',
      iconUrl: 'https:${current['condition']?['icon'] ?? ''}',
      humidity: current['humidity'] ?? 0,
      windKph: (current['wind_kph'] ?? 0).toDouble(),
      feelsLike: (current['feelslike_c'] ?? 0).toDouble(),
      lat: (location['lat'] ?? 0).toDouble(),
      lon: (location['lon'] ?? 0).toDouble(),
    );
  }
}
