import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({super.key, required this.currentRoute});

  Widget _item(
    BuildContext context,
    String title,
    IconData icon,
    String route,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: currentRoute == route,
      onTap: () {
        Navigator.pop(context);
        if (currentRoute != route) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Center(
              child: Text(
                'Weather App',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // 🏠 Home
          _item(context, 'Home', Icons.home, '/home'),
          _item(context, 'Add City', Icons.add_location, '/cities'),

          // ⏰ Hourly Forecast
          _item(context, 'Hourly Forecast', Icons.schedule, '/hourly'),

          // 📅 3-Day Forecast
          _item(context, '3-Day Forecast', Icons.calendar_today, '/daily'),

          _item(context, 'Places', Icons.location_city, '/places'),
        ],
      ),
    );
  }
}
