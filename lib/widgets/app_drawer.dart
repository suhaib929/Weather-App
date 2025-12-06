import 'package:flutter/material.dart';
import 'package:weather_app/screens/ourly_forecast_screen.dart';
import '../screens/home_screen.dart';
import '../screens/daily_forecast_screen.dart';
import '../screens/cities_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.cloud, color: Colors.white, size: 32),
                    SizedBox(width: 12),
                    Text(
                      'Weather App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              _drawerItem(context, icon: Icons.home, text: 'Home', onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              }),
              _drawerItem(context, icon: Icons.schedule, text: 'Hourly Forecast', onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => HourlyForecastScreen()));
              }),
              _drawerItem(context, icon: Icons.calendar_today, text: 'Daily Forecast', onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => DailyForecastScreen()));
              }),
              _drawerItem(context, icon: Icons.place, text: 'Places', onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => CitiesScreen()));
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(BuildContext context,
      {required IconData icon, required String text, required VoidCallback onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white.withOpacity(0.1),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        hoverColor: Colors.white24,
        onTap: onTap,
      ),
    );
  }
}
