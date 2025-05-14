import 'package:flutter/material.dart';
import '../models/weather_day.dart';

class DetailScreen extends StatelessWidget {
  final WeatherDay day;

  const DetailScreen({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${day.date} Hourly Forecast'),
      ),
      body: ListView.builder(
        itemCount: day.hourlyData.length, // Should be 24
        itemBuilder: (context, index) {
          final hour = day.hourlyData[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              leading: Image.network(
                'http://openweathermap.org/img/wn/${hour.icon}@2x.png',
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
              ),
              title: Text(hour.time),
              subtitle: Text('${hour.temp.toStringAsFixed(1)}°C - ${hour.description}'),
            ),
          );
        },
      ),
    );
  }
}