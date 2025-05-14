import 'weather_hour.dart'; // Add this import

class WeatherDay {
  final String date; // e.g., "Monday"
  final double avgTemp; // Average temperature
  final String icon; // Weather icon code
  final List<WeatherHour> hourlyData; // Hourly data for the day

  WeatherDay({
    required this.date,
    required this.avgTemp,
    required this.icon,
    required this.hourlyData,
  });

  factory WeatherDay.fromJson(Map<String, dynamic> json, List<WeatherHour> hourlyData) {
    return WeatherDay(
      date: json['date'],
      avgTemp: json['main']['temp'].toDouble(), // Corrected to use API data
      icon: json['weather'][0]['icon'],
      hourlyData: hourlyData,
    );
  }
}