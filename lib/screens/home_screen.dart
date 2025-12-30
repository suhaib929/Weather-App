import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<WeatherProvider>();

    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/home'),
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF90CAF9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: p.currentWeather == null
            ? const Center(
                child: Text(
                  'No Weather Data',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              )
            : Center(
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 🏙️ City Name
                        Text(
                          p.currentWeather!.city,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 🌤️ Weather Icon
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.blue.shade50,
                          child: Image.network(
                            p.currentWeather!.iconUrl,
                            width: 70,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.cloud, size: 50),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 🌡️ Temperature
                        Text(
                          '${p.currentWeather!.temperature}°C',
                          style: const TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // ☁️ Condition
                        Text(
                          p.currentWeather!.condition,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
