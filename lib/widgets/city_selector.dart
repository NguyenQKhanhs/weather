import 'package:flutter/material.dart';

class CitySelector extends StatelessWidget {
  final String selectedCity;
  final Function(String) onCitySelected;

  CitySelector({required this.selectedCity, required this.onCitySelected});

  final List<String> _cities = [
    'Hanoi',
    'Ho Chi Minh City',
    'Da Nang',
    'Hue',
    'Nha Trang',
    'Can Tho',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButton<String>(
        value: selectedCity,
        isExpanded: true,
        hint: const Text('Select a city'),
        items: _cities.map((city) {
          return DropdownMenuItem<String>(
            value: city,
            child: Text(city),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            onCitySelected(value);
          }
        },
      ),
    );
  }
}
