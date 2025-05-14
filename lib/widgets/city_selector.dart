import 'package:flutter/material.dart';

class CitySelector extends StatelessWidget {
  final String selectedCity;
  final Function(String) onCitySelected;

  CitySelector({required this.selectedCity, required this.onCitySelected});

  final List<String> _cities = [
    'An Giang',
    'Ba Ria - Vung Tau',
    'Bac Giang',
    'Bac Kan',
    'Bac Lieu',
    'Bac Ninh',
    'Ben Tre',
    'Binh Dinh',
    'Binh Duong',
    'Binh Phuoc',
    'Binh Thuan',
    'Ca Mau',
    'Can Tho',
    'Cao Bang',
    'Da Nang',
    'Dak Lak',
    'Dak Nong',
    'Dien Bien Phu',
    'Dong Ha',
    'Dong Hoi',
    'Dong Nai',
    'Dong Thap',
    'Gia Lai',
    'Ha Dong', // Hà Tây, mapped to Hà Đông district
    'Ha Giang',
    'Ha Nam',
    'Ha Noi',
    'Ha Tinh',
    'Hai Duong',
    'Hai Phong',
    'Hau Giang',
    'Ho Chi Minh City',
    'Hoa Binh',
    'Hung Yen',
    'Khanh Hoa',
    'Kien Giang',
    'Kon Tum',
    'Lai Chau',
    'Lam Dong',
    'Lang Son',
    'Lao Cai',
    'Long An',
    'Nam Dinh',
    'Nghe An',
    'Ninh Binh',
    'Ninh Thuan',
    'Phu Tho',
    'Phu Yen',
    'Quang Binh',
    'Quang Nam',
    'Quang Ngai',
    'Quang Ninh',
    'Quang Tri',
    'Soc Trang',
    'Son La',
    'Tay Ninh',
    'Thai Binh',
    'Thai Nguyen',
    'Thanh Hoa',
    'Thua Thien Hue',
    'Tien Giang',
    'Tra Vinh',
    'Tuyen Quang',
    'Vinh Long',
    'Vinh Phuc',
    'Yen Bai',
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