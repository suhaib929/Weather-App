import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<WeatherProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud, size: 100, color: Colors.blue),
            const SizedBox(height: 30),
            const Text(
              'Weather App',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Choose how to get weather'),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.my_location),
                label: const Text('Use GPS'),
                onPressed: () async {
                  await provider.loadWeatherByLocation();
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.search),
                label: const Text('Search City'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/cities');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
