import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class HourlyForecastScreen extends StatelessWidget {
  const HourlyForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/hourly'),
      appBar: AppBar(title: const Text('Hourly Forecast')),
      body: ListView.builder(
        itemCount: 24,
        itemBuilder: (_, i) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: const Icon(Icons.sunny),
            title: Text('${i}:00'),
            subtitle: const Text('25°C'),
          ),
        ),
      ),
    );
  }
}
