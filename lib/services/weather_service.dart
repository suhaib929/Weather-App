import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/current_weather.dart';
import '../models/daily_forecast.dart';
import '../models/hourly_forecast.dart';
import '../utils/constants.dart';

class WeatherService {
  static const Duration _timeout = Duration(seconds: 10);

  static Uri _buildUri(
    String endpoint,
    Map<String, String> params,
  ) {
    return Uri.parse('${ApiConstants.baseUrl}/$endpoint').replace(
      queryParameters: {
        ...params,
        'key': ApiConstants.weatherApiKey,
      },
    );
  }

  static Future<Map<String, dynamic>> _get(
    String endpoint,
    Map<String, String> params,
  ) async {
    final response =
        await http.get(_buildUri(endpoint, params)).timeout(_timeout);

    if (response.statusCode != 200) {
      throw Exception('Failed to load weather data');
    }

    return json.decode(response.body);
  }

  // ---------------- CURRENT WEATHER ----------------

  static Future<CurrentWeather> getCurrentWeather(String city) async {
    final data = await _get('current.json', {'q': city});
    return CurrentWeather.fromJson(data);
  }

  static Future<CurrentWeather> getCurrentByCoords(
    double lat,
    double lon,
  ) async {
    final data = await _get('current.json', {'q': '$lat,$lon'});
    return CurrentWeather.fromJson(data);
  }

  // ---------------- FORECAST ----------------

  static Future<List<DailyForecast>> get3DayForecast(String city) async {
    final data =
        await _get('forecast.json', {'q': city, 'days': '3'});

    return (data['forecast']['forecastday'] as List)
        .map((e) => DailyForecast.fromJson(e))
        .toList();
  }

  static Future<List<HourlyForecast>> getHourlyForecast(String city) async {
    final data =
        await _get('forecast.json', {'q': city, 'days': '1'});

    return (data['forecast']['forecastday'][0]['hour'] as List)
        .map((e) => HourlyForecast.fromJson(e))
        .toList();
  }
}
