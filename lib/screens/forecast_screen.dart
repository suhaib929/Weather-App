import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../classes/weather_models.dart';
import '../widgets/app_drawer.dart';

class ForecastScreen extends StatefulWidget {
  final String city;
  const ForecastScreen({super.key, required this.city});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  List<DailyForecast> days = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadForecast();
  }

  void loadForecast() async {
    final json = await WeatherService.fetchForecast(widget.city);

    if (json != null) {
      final list = json["forecast"]["forecastday"] as List<dynamic>;
      days = list.map((e) => DailyForecast.fromJson(e)).toList();
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Forecast: ${widget.city}"),
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
        child: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: days.length,
                itemBuilder: (ctx, i) {
                  final d = days[i];

                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Image.network(d.icon, width: 50),
                      title: Text(
                        d.date,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(d.condition),
                      trailing: Text(
                        "${d.maxTemp} / ${d.minTemp}°C",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
