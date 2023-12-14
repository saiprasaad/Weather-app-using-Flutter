import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/weather.dart';

void main() {
  group('Testing Weather Class', () {
    test('Testing fromJson of Weather Class', () {
      final weatherJsonData = {
        'address':'Illinois',
        'days':[{
          'tempmin': 49.5,
          'tempmax': 55.5,
          'temp': 60.5,
          'feelslike': 45.5,
          'conditions': 'Cloudy',
          'icon': 'Cloud',
          'datetime': '12/08/2023',
          'humidity': 30.5,
          'sunset': '17:05:50'
        }]
      };
      Weather weather = Weather.fromJson(weatherJsonData);
      expect(weather.state, 'Illinois');
      expect(weather.weatherData[0].conditions, 'Cloudy');
      expect(weather.weatherData.length, 1);
      expect(weather.weatherData[0].temp, 60.5);
    });
  });
}
