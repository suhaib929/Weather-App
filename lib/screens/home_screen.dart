import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../classes/weather_models.dart';
import 'forecast_screen.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityCtrl = TextEditingController();

  CurrentWeather? data;
  bool loading = false;

  // Predefined cities
  final List<String> predefinedCities = [
    "Hebron",
    "New York",
    "Paris",
    "Tokyo",
    "Cairo",
    "Amman",
  ];

  // Store weather for each city
  Map<String, CurrentWeather?> cityWeather = {};

  @override
  void initState() {
    super.initState();
    // Load weather for predefined cities at start
    _loadPredefinedCitiesWeather();
  }

  void _loadPredefinedCitiesWeather() async {
    for (var city in predefinedCities) {
      final json = await WeatherService.fetchCurrent(city);
      if (json != null) {
        setState(() {
          cityWeather[city] = CurrentWeather.fromJson(json);
        });
      }
    }
  }

  void fetchWeather([String? cityName]) async {
    final city = cityName ?? _cityCtrl.text;
    if (city.isEmpty) return;

    setState(() => loading = true);

    final json = await WeatherService.fetchCurrent(city);

    if (json != null) {
      data = CurrentWeather.fromJson(json);
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Weather App"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade50, Colors.blue.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Search Box
            TextField(
              controller: _cityCtrl,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_city),
                hintText: "Enter city name...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => fetchWeather(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
              child: Text("Search", style: TextStyle(fontSize: 16)),
            ),
            SizedBox(height: 20),

            // Predefined Cities Weather List
            Expanded(
              child: ListView.builder(
                itemCount: predefinedCities.length,
                itemBuilder: (ctx, i) {
                  final city = predefinedCities[i];
                  final weather = cityWeather[city];

                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: weather != null
                          ? Image.network(weather.icon, width: 50)
                          : Icon(Icons.cloud, size: 40, color: Colors.blue),
                      title: Text(city,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: weather != null
                          ? Text("${weather.temp}°C - ${weather.condition}")
                          : Text("Loading..."),
                      trailing: weather != null
                          ? ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ForecastScreen(city: city),
                                  ),
                                );
                              },
                              child: Text("More"),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6)),
                            )
                          : null,
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
}
