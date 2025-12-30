class HourlyForecast {
  final DateTime time;
  final double temperature;
  final String condition;
  final String iconUrl;

  const HourlyForecast({
    required this.time,
    required this.temperature,
    required this.condition,
    required this.iconUrl,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: DateTime.parse(json['time']),
      temperature: (json['temp_c'] ?? 0).toDouble(),
      condition: json['condition']['text'] ?? '',
      iconUrl: "https:${json['condition']['icon'] ?? ''}",
    );
  }
}
