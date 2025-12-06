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
git clone https://(https://github.com/suhaib929/Weather-App.git)
cd weather_mobile_app
--Install Dependencies
--Configure API Key:

*API Details*

Provider: WeatherAPI.com
Base URL: https://api.weatherapi.com/v1/

=======
weather_app/                 <- Root folder of the Flutter project
│
├─ lib/                      <- Main Dart source files
│  ├─ main.dart              <- App entry point, runs WeatherApp
│  │
│  ├─ screens/               <- Screens (pages) of the app
│  │  ├─ home_screen.dart    <- Main screen, search city and show current weather
│  │  ├─ forecast_screen.dart <- 3-day forecast screen
│  │  ├─ daily_forecast_screen.dart <- Daily forecast for multiple days
│  │  ├─ ourly_forecast_screen.dart <- Hourly forecast screen (typo, should be hourly_forecast_screen.dart)
│  │  ├─ cities_screen.dart  <- List of predefined cities with weather info
│  │
│  ├─ widgets/               <- Reusable UI components
│  │  ├─ app_drawer.dart     <- Navigation drawer for the app
│  │  ├─ weather_card.dart   <- Custom card to show city weather
│  │
│  ├─ services/              <- API services
│  │  ├─ weather_service.dart <- Fetch current weather & forecast from API
│  │
│  ├─ classes/               <- Data models
│  │  ├─ weather_models.dart <- Defines CurrentWeather, DailyForecast models
│
├─ pubspec.yaml              <- Flutter project configuration (dependencies, assets)
├─ android/                  <- Android native project files
├─ ios/                      <- iOS native project files
└─ assets/                   <- Images, icons, or other static assets

# Weather-App
Weather App project using Flutter according to instructions provided by Dr. Mohammed Jabari.
>>>>>>> 404742a0d5903ab7ca1634f36f48d4afa39d4b7c
