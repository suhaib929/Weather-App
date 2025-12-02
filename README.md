<<<<<<< HEAD
Weather Mobile App
lightweight mobile application built with Flutter that provides users with real-time weather data, hourly predictions, and multi-day forecasts for selected cities. The project emphasizes clean architecture, maintainable code, and modern UI/UX design.

Table of Contents:
//Features//Technical Requirements//Installation & Setup//Project Structure//API Details//License..


 *Features*
A. Basic Features
--Home Screen	Shows current weather for the selected city, including temperature, condition (rain, clear, etc.), and a related weather icon.

--Places List Screen	Displays multiple cities with filtering functionality. Each city card includes its current weather and a “Show More Info” button.

--Flutter Framework	Application must be fully developed using Flutter.
Weather API Integration	Uses WeatherAPI.com for all weather data retrieval.

B. Intermediate Features
--Navigation Drawer	Allows seamless navigation between the app’s main screens.

--3-Day Forecast	Shows a detailed 3-day forecast for a selected city with visual icons and a link to a weather map.

--Hourly Forecast	Presents predicted weather conditions for upcoming hours.

C. Advanced Features
--State Management	Uses a modern Flutter state management solution (Provider, Bloc, Riverpod) to store and refresh weather data.

--GPS Integration	Detects user location and displays local weather automatically.

--Weather Map	Shows a visual weather map for the selected region.
Notifications	Alerts users about severe weather (storms, snow, heavy rain).

*Installation*

--Clone the Project:
git clone https://github.com/YOUR_USERNAME/weather_mobile_app.git
cd weather_mobile_app
--Install Dependencies
--Configure API Key:

*Project Structure*
lib/
 ├── main.dart
 ├── screens/
 │    ├── home_screen.dart
 │    ├── places_screen.dart
 │    ├── forecast_screen.dart
 │    └── hourly_screen.dart
 │
 ├── widgets/
 │    ├── weather_card.dart
 │    ├── temperature_widget.dart
 │    └── city_tile.dart
 │
 ├── api/
 │    ├── weather_api.dart
 │    ├── api_endpoints.dart
 │    ├── api_config.dart
 │    └── api_exceptions.dart
 │
 ├── classes/
 │    ├── weather_provider.dart   
 │    ├── date_formatter.dart
 │    ├── temperature_converter.dart
 │    └── location_helper.dart
 │
 └── models/
      ├── current_weather_model.dart
      ├── forecast_model.dart
      └── hourly_model.dart

*API Details*

Provider: WeatherAPI.com
Base URL: https://api.weatherapi.com/v1/

=======
# Weather-App
Weather App project using Flutter according to instructions provided by Dr. Mohammed Jabari.
>>>>>>> 404742a0d5903ab7ca1634f36f48d4afa39d4b7c
