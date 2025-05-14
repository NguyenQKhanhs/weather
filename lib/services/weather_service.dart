import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_day.dart';
import '../models/weather_hour.dart';
import '../utils/date_utils.dart';

class WeatherService {
  static const String _apiKey = '99a3e09f5a4fc67bb5e1feca90d80455'; // Replace with your API key
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';

  Future<List<WeatherDay>> getWeatherForecast(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?q=$city&appid=$_apiKey&units=metric'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> list = data['list'];

        // Group data by day
        Map<String, List<WeatherHour>> dailyData = {};
        for (var item in list) {
          final hour = WeatherHour.fromJson(item);
          final date = item['dt_txt'].split(' ')[0]; // Extract date (YYYY-MM-DD)
          final dayName = getDayName(date); // Convert to "Monday", etc.

          dailyData.putIfAbsent(dayName, () => []).add(hour);
        }

        // Create WeatherDay objects with interpolated hourly data
        List<WeatherDay> forecast = [];
        dailyData.forEach((dayName, hours) {
          // Interpolate to get 24 hours (00:00 to 23:00)
          List<WeatherHour> fullDayHours = [];
          for (int hour = 0; hour < 24; hour++) {
            final time = '${hour.toString().padLeft(2, '0')}:00';
            // Check if there's an exact match for the hour
            bool hasMatch = hours.any((h) => h.time == time);
            WeatherHour sourceHour = hasMatch
                ? hours.firstWhere((h) => h.time == time)
                : hours[0]; // Fallback to first hour if no match

            if (hasMatch) {
              // Use existing data if available
              fullDayHours.add(sourceHour);
            } else {
              // Interpolate or reuse data for missing hour
              WeatherHour? prevHour;
              WeatherHour? nextHour;
              for (var h in hours) {
                final hHour = int.parse(h.time.split(':')[0]);
                if (hHour < hour && (prevHour == null || hHour > int.parse(prevHour.time.split(':')[0]))) {
                  prevHour = h;
                }
                if (hHour > hour && (nextHour == null || hHour < int.parse(nextHour.time.split(':')[0]))) {
                  nextHour = h;
                }
              }

              // Default to sourceHour (first hour) if no interpolation possible
              double temp = sourceHour.temp;

              // Linear interpolation if both prev and next are available
              if (prevHour != null && nextHour != null) {
                final prevTime = int.parse(prevHour.time.split(':')[0]);
                final nextTime = int.parse(nextHour.time.split(':')[0]);
                final timeDiff = nextTime - prevTime;
                final tempDiff = nextHour.temp - prevHour.temp;
                final hourDiff = hour - prevTime;
                temp = prevHour.temp + (tempDiff * hourDiff / timeDiff);
              }

              fullDayHours.add(WeatherHour(
                time: time,
                temp: temp,
                icon: sourceHour.icon,
                description: sourceHour.description,
              ));
            }
          }

          final avgTemp = fullDayHours.map((h) => h.temp).reduce((a, b) => a + b) / fullDayHours.length;
          // Use the first hour's data for JSON compatibility
          final json = list.firstWhere((item) => getDayName(item['dt_txt'].split(' ')[0]) == dayName);
          forecast.add(WeatherDay.fromJson({
            'date': dayName,
            'main': {'temp': avgTemp},
            'weather': json['weather'],
          }, fullDayHours));
        });

        // Sort to ensure Monday to Sunday
        forecast.sort((a, b) => getDayIndex(a.date).compareTo(getDayIndex(b.date)));
        return forecast;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}