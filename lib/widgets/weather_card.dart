import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String date;
  final double avgTemp;
  final String icon;
  final VoidCallback onTap;

  const WeatherCard({
    required this.date,
    required this.avgTemp,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: Image.network(
          'http://openweathermap.org/img/wn/$icon@2x.png',
          width: 50,
          height: 50,
        ),
        title: Text(date),
        subtitle: Text('${avgTemp.toStringAsFixed(1)}°C'),
        onTap: onTap,
      ),
    );
  }
}