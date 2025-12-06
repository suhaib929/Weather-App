import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../services/weather_service.dart';

class CitiesScreen extends StatefulWidget {
  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  final List<String> _cities = [
    "Hebron",
    "New York",
    "Paris",
    "Tokyo",
    "Cairo",
    "Amman",
  ];

  List<String> filtered = [];
  String query = "";

  @override
  void initState() {
    super.initState();
    filtered = List.from(_cities);
  }

  // تصفية المدن
  void _onSearch(String q) {
    setState(() {
      query = q;
      filtered = _cities
          .where((c) => c.toLowerCase().contains(q.toLowerCase()))
          .toList();
    });
  }

  // عرض تفاصيل المدينة
  Future<void> _showCityDetails(String city) async {
    final data = await WeatherService.fetchForecast(city, days: 3);
    if (data == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load details')));
      return;
    }

    final loc = data['location']?['name'] ?? city;
    final curr = data['current'];
    final temp = curr != null ? "${curr['temp_c']} °C" : "--";
    final cond = curr?['condition']?['text'] ?? '';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(loc),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              temp,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(cond),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('City Weather'),
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
        child: Column(
          children: [
            // مربع البحث
            Padding(
              padding: EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search city',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white70,
                ),
                onChanged: _onSearch,
              ),
            ),

            // قائمة المدن
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (ctx, i) {
                  final city = filtered[i];

                  return FutureBuilder(
                    future: WeatherService.fetchCurrent(city),
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: ListTile(
                            title: Text(city),
                            subtitle: Text('Loading...'),
                          ),
                        );
                      }

                      if (!snapshot.hasData) {
                        return Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: ListTile(
                            title: Text(city),
                            subtitle: Text('No data'),
                            trailing: Icon(
                              Icons.error_outline,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }

                      final data = snapshot.data as Map<String, dynamic>;
                      final temp =
                          data['current']?['temp_c']?.toString() ?? '--';
                      final cond = data['current']?['condition']?['text'] ?? '';
                      final icon = data['current']?['condition']?['icon'];

                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: icon != null
                              ? Image.network("https:$icon", width: 48)
                              : Icon(Icons.cloud, size: 40, color: Colors.blue),
                          title: Text(
                            city,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(cond),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$temp °C",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 6),
                              TextButton(
                                onPressed: () => _showCityDetails(city),
                                child: Text("Show More"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
