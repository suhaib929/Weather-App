import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../widgets/app_drawer.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<WeatherProvider>();

    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/places'),
      appBar: AppBar(title: const Text('Places')),
      body: ListView.builder(
        itemCount: p.savedCities.length,
        itemBuilder: (context, index) {
          final city = p.savedCities[index];
          return ListTile(
            title: Text(city),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () async {
              await p.loadWeatherByCity(city);
              Navigator.pushReplacementNamed(context, '/home');
            },
          );
        },
      ),
    );
  }
}
