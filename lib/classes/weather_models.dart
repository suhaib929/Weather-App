class CurrentWeather {
  final String city;
  final double temp;
  final String condition;
  final String icon;

  CurrentWeather({
    required this.city,
    required this.temp,
    required this.condition,
    required this.icon,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      city: json["location"]["name"],
      temp: json["current"]["temp_c"].toDouble(),
      condition: json["current"]["condition"]["text"],
      icon: "https:${json["current"]["condition"]["icon"]}",
    );
  }
}

class DailyForecast {
  final String date;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final String icon;

  DailyForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.icon,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: json["date"],
      maxTemp: json["day"]["maxtemp_c"].toDouble(),
      minTemp: json["day"]["mintemp_c"].toDouble(),
      condition: json["day"]["condition"]["text"],
      icon: "https:${json["day"]["condition"]["icon"]}",
    );
  }
}
