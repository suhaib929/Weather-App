import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../widgets/app_drawer.dart';

class DailyForecastScreen extends StatelessWidget {
  const DailyForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<WeatherProvider>();

    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/daily'),
      appBar: AppBar(
        title: const Text('3-Day Forecast'),
        centerTitle: true,
      ),
      body: p.dailyForecast.isEmpty
          ? const Center(child: Text('No forecast data'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: p.dailyForecast.length,
              itemBuilder: (context, index) {
                final d = p.dailyForecast[index];

                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),

                    // 🌤️ Icon
                    leading: Image.network(
                      d.iconUrl,
                      width: 45,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.cloud),
                    ),

                    // 📅 Date
                    title: Text(
                      '${d.date.day}/${d.date.month}/${d.date.year}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    // 🌡️ Temps
                    subtitle: Text(
                      'High ${d.maxTemp}°C  •  Low ${d.minTemp}°C',
                      style: const TextStyle(fontSize: 14),
                    ),

                    // ➡️ Arrow

                    // ✅ هذا هو الحل
                   
                  ),
                );
              },
            ),
    );
  }
}
