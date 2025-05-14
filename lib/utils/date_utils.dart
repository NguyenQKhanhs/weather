import 'package:intl/intl.dart';

String getDayName(String dateStr) {
  final date = DateTime.parse(dateStr);
  return DateFormat('EEEE').format(date); // e.g., "Monday"
}

int getDayIndex(String dayName) {
  const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  return days.indexOf(dayName);
}