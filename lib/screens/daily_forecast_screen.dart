import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../services/weather_service.dart';
import 'package:intl/intl.dart';

class DailyForecastScreen extends StatefulWidget {
  final String city;
  DailyForecastScreen({this.city = "London"});

  @override
  _DailyForecastScreenState createState() => _DailyForecastScreenState();
}

class _DailyForecastScreenState extends State<DailyForecastScreen> {
  bool loading = true;
  Map<String, dynamic>? forecastData;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => loading = true);
    final res = await WeatherService.fetchForecast(widget.city, days: 3);

    setState(() {
      forecastData = res;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final list =
        forecastData?['forecast']?['forecastday'] as List<dynamic>? ?? [];

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Daily Forecast: ${widget.city}"),
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
        child: RefreshIndicator(
          onRefresh: _load,
          child: loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (ctx, i) {
                    final day = list[i];
                    final date = DateFormat(
                      'EEE, MMM d',
                    ).format(DateTime.parse(day['date']));

                    final max = day['day']?['maxtemp_c'] ?? '--';
                    final min = day['day']?['mintemp_c'] ?? '--';
                    final icon = day['day']?['condition']?['icon'];

                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: icon != null
                            ? Image.network("https:$icon", width: 48)
                            : Icon(Icons.cloud, size: 42, color: Colors.blue),
                        title: Text(
                          date,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text("High: $max°C • Low: $min°C"),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
