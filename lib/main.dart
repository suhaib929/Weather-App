import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/weather_provider.dart';
import 'screens/startup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/hourly_forecast_screen.dart';
import 'screens/daily_forecast_screen.dart';
import 'screens/cities_screen.dart';
import 'screens/places_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (context) => const StartupScreen(),
        '/home': (context) => const HomeScreen(),
        '/cities': (context) => const CitiesScreen(),
        '/places': (context) => const PlacesScreen(),
        '/hourly': (context) => const HourlyForecastScreen(),
        '/daily': (context) => const DailyForecastScreen(),
      },
    );
  }
}
