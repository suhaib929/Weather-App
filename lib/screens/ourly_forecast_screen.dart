import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../services/weather_service.dart';
import 'package:intl/intl.dart';

class HourlyForecastScreen extends StatefulWidget {
  final String city;
  HourlyForecastScreen({this.city = "London"});

  @override
  _HourlyForecastScreenState createState() => _HourlyForecastScreenState();
}

class _HourlyForecastScreenState extends State<HourlyForecastScreen> {
  bool loading = true;
  Map<String, dynamic>? forecastData;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => loading = true);
    final res = await WeatherService.fetchForecast(widget.city, days: 1);

    setState(() {
      forecastData = res;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hours =
        forecastData?['forecast']?['forecastday']?[0]?['hour']
            as List<dynamic>? ??
        [];

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Hourly Forecast: ${widget.city}"),
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
                  padding: EdgeInsets.all(12),
                  itemCount: hours.length,
                  itemBuilder: (ctx, i) {
                    final h = hours[i];
                    final time = DateFormat(
                      'HH:mm',
                    ).format(DateTime.parse(h['time']));
                    final temp = h['temp_c'] ?? '--';
                    final icon = h['condition']?['icon'];

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: ListTile(
                        leading: icon != null
                            ? Image.network("https:$icon", width: 44)
                            : Icon(Icons.cloud, size: 40),
                        title: Text(
                          time,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          "Temp: $temp °C",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
