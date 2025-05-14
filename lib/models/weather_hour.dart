class WeatherHour {
  final String time; // e.g., "00:00"
  final double temp; // Temperature
  final String icon; // Weather icon code
  final String description; // e.g., "Clear"

  WeatherHour({
    required this.time,
    required this.temp,
    required this.icon,
    required this.description,
  });

  factory WeatherHour.fromJson(Map<String, dynamic> json) {
    return WeatherHour(
      time: json['dt_txt'].split(' ')[1].substring(0, 5), // Extract HH:MM
      temp: json['main']['temp'].toDouble(),
      icon: json['weather'][0]['icon'],
      description: json['weather'][0]['description'],
    );
  }
}