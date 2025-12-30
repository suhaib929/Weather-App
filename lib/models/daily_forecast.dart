class DailyForecast {
  final DateTime date;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final String iconUrl;

  const DailyForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.iconUrl,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: DateTime.parse(json['date']),
      maxTemp: (json['day']['maxtemp_c'] ?? 0).toDouble(),
      minTemp: (json['day']['mintemp_c'] ?? 0).toDouble(),
      condition: json['day']['condition']['text'] ?? '',
      iconUrl: "https:${json['day']['condition']['icon'] ?? ''}",
    );
  }
}
