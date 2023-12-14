import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/weatherbyday.dart';

void main() {
  group('Testing WeatherByDay Class', () {
    test('Testing fromJson of WeatherByDay Class', () {
      final weatherByDayJsonData = {
        'tempmin': 49.5,
          'tempmax': 55.5,
          'temp': 60.5,
          'feelslike': 45.5,
          'conditions': 'Cloudy',
          'icon': 'Cloud',
          'datetime': '12/08/2023',
          'humidity': 30.5,
          'sunset': '17:05:50'
      };
      WeatherByDay weatherByDay = WeatherByDay.fromJson(weatherByDayJsonData);
      expect(weatherByDay.tempmin, 49.5);
      expect(weatherByDay.feelslike, 45.5);
      expect(weatherByDay.icon, 'Cloud');
    });
  });
}
