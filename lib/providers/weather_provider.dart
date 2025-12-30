import 'package:flutter/material.dart';

import '../models/current_weather.dart';
import '../models/hourly_forecast.dart';
import '../models/daily_forecast.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';

class WeatherProvider extends ChangeNotifier {
  // ---------------- DATA ----------------

  CurrentWeather? currentWeather;
  List<HourlyForecast> hourlyForecast = [];
  List<DailyForecast> dailyForecast = [];

  /// المدينة الحالية المختارة (GPS أو يدوي)
  String? selectedCity;

  /// المدن المحفوظة (Places)
  final List<String> savedCities = [];

  // ---------------- STATE ----------------

  bool isLoading = false;
  String? error;

  // ---------------- CITY WEATHER ----------------

  /// تحميل الطقس عن طريق اسم المدينة
  Future<void> loadWeatherByCity(String city) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      selectedCity = city;

      currentWeather =
          await WeatherService.getCurrentWeather(city);
      hourlyForecast =
          await WeatherService.getHourlyForecast(city);
      dailyForecast =
          await WeatherService.get3DayForecast(city);

      if (!savedCities.contains(city)) {
        savedCities.add(city);
      }
    } catch (e) {
      error = 'City not found';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ---------------- GPS WEATHER ----------------

  /// تحميل الطقس عن طريق GPS
  Future<void> loadWeatherByLocation() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final position =
          await LocationService.getCurrentPosition();

      currentWeather =
          await WeatherService.getCurrentByCoords(
        position.latitude,
        position.longitude,
      );

      selectedCity = currentWeather!.city;

      hourlyForecast =
          await WeatherService.getHourlyForecast(selectedCity!);
      dailyForecast =
          await WeatherService.get3DayForecast(selectedCity!);

      if (!savedCities.contains(selectedCity)) {
        savedCities.add(selectedCity!);
      }
    } catch (e) {
      error = 'Failed to get location';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ---------------- PLACES MANAGEMENT ----------------

  /// إضافة مدينة يدويًا لقائمة Places
  void addCity(String city) {
    if (!savedCities.contains(city)) {
      savedCities.add(city);
      notifyListeners();
    }
  }

  /// حذف مدينة من القائمة
  void removeCity(String city) {
    savedCities.remove(city);
    notifyListeners();
  }

  // ---------------- REFRESH ----------------

  /// تحديث بيانات الطقس للمدينة الحالية
  Future<void> refreshWeather() async {
    if (selectedCity == null) return;
    await loadWeatherByCity(selectedCity!);
  }

  // ---------------- RESET ----------------

  /// إعادة تعيين البيانات (اختياري)
  void clear() {
    currentWeather = null;
    hourlyForecast.clear();
    dailyForecast.clear();
    selectedCity = null;
    error = null;
    notifyListeners();
  }
}
