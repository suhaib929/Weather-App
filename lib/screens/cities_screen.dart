import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';
import '../widgets/app_drawer.dart';

class CitiesScreen extends StatefulWidget {
  const CitiesScreen({super.key});

  @override
  State<CitiesScreen> createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/cities'),
      appBar: AppBar(title: const Text('Add City')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'City name',
                prefixIcon: Icon(Icons.location_city),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Add & Show Weather'),
                onPressed: () async {
                  final city = _controller.text.trim();
                  if (city.isEmpty) return;

                  await provider.loadWeatherByCity(city);

                  if (provider.error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(provider.error!)),
                    );
                  } else {
                    _controller.clear();
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: provider.savedCities.isEmpty
                  ? const Center(child: Text('No cities added'))
                  : ListView.builder(
                      itemCount: provider.savedCities.length,
                      itemBuilder: (context, index) {
                        final city = provider.savedCities[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.location_on),
                            title: Text(city),
                            onTap: () async {
                              await provider.loadWeatherByCity(city);
                              Navigator.pushReplacementNamed(
                                  context, '/home');
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
