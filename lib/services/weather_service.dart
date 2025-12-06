import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  // Your Weather API Key
  static const String _apiKey = "45844ebdc10e4eeebc291037250612";

  // The base URL of the Weather API
  static const String _baseUrl = "http://api.weatherapi.com/v1";

  
  ///  A general method for sending API requests
  /// This method is flexible and used by all other methods below.
  /// It handles:
  /// - creating the URL
  /// - sending the HTTP request
  /// - decoding the JSON response
  /// - catching any errors
  
  static Future<Map<String, dynamic>?> _getData(String endpoint) async {
    try {
      final url = Uri.parse("$_baseUrl/$endpoint&key=$_apiKey");
      final response = await http.get(url);

      // If the request was successful
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("⚠ API Error: ${response.statusCode}");
        return null;
      }

    } catch (e) {
      // This happens when the internet is off or API is unreachable
      print("⚠ Connection Error: $e");
      return null;
    }
  }

   
  static Future<Map<String, dynamic>?> fetchCurrent(String city) async {
    final endpoint = "current.json?q=$city&aqi=no";
    return await _getData(endpoint);
  }

  static Future<Map<String, dynamic>?> fetchForecast(
      String city, {int days = 3}) async {
    final endpoint =
        "forecast.json?q=$city&days=$days&aqi=no&alerts=no";
    return await _getData(endpoint);
  }
}
