import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String city;
  final String temp;
  final String condition;
  final String iconUrl;
  final VoidCallback? onMore;

  const WeatherCard({
    Key? key,
    required this.city,
    required this.temp,
    required this.condition,
    required this.iconUrl,
    this.onMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: iconUrl.isNotEmpty
            ? Image.network(iconUrl, width: 36)
            : Icon(Icons.wb_sunny, size: 36, color: Colors.amber[700]),
        title: Text(city, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        subtitle: Text(condition),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(temp, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            ElevatedButton(
              onPressed: onMore,
              child: Text('More', style: TextStyle(fontSize: 12)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
