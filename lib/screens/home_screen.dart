import 'package:flutter/material.dart';
import '../models/weather_day.dart';
import '../services/weather_service.dart';
import '../widgets/city_selector.dart';
import '../widgets/weather_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  List<WeatherDay> _forecast = [];
  String _selectedCity = 'Hanoi';
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final forecast = await _weatherService.getWeatherForecast(_selectedCity);
      setState(() {
        _forecast = forecast;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString(); // Fixed typo from 'eosexi'
        _isLoading = false;
      });
    }
  }

  void _onCitySelected(String city) {
    setState(() {
      _selectedCity = city;
    });
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('7-Day Weather Forecast'),
      ),
      body: Column(
        children: [
          CitySelector(
            selectedCity: _selectedCity,
            onCitySelected: _onCitySelected,
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(child: Text(_error!))
                    : ListView.builder(
                        itemCount: _forecast.length,
                        itemBuilder: (context, index) {
                          final day = _forecast[index];
                          return WeatherCard(
                            date: day.date,
                            avgTemp: day.avgTemp,
                            icon: day.icon,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(day: day),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}