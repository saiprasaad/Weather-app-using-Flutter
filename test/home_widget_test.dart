import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/favorites.dart';
import 'package:mp5/models/weather.dart';
import 'package:mp5/models/weatherbyday.dart';
import 'package:mp5/views/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Home widget test', (WidgetTester tester) async {
    final List<Weather> weatherData = [
      Weather(state: 'Illinois', weatherData: [
        WeatherByDay(
            icon: 'Cloudy',
            conditions: 'Clear',
            temp: 75.5,
            tempmin: 70.5,
            tempmax: 80.5,
            feelslike: 32,
            datetime: '12/08/2023',
            humidity: 12.5,
            sunset: '17:30:00')
      ]),
    ];
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => Favorites(),
          child: Home(weatherData: weatherData, iconsMap: {}),
        ),
      ),
    );
    expect(find.text('Illinois'), findsOneWidget);
    expect(find.text('Clear'), findsOneWidget);
    expect(find.text('75.5 °F'), findsOneWidget);
    expect(find.text('70.5 °F / 80.5 °F'), findsOneWidget);
  });

  testWidgets('Testing Icons of Home Widget', (WidgetTester tester) async {
    final List<Weather> weatherData = [
      Weather(state: 'Illinois', weatherData: [
        WeatherByDay(
            icon: 'clear-day',
            conditions: 'Clear',
            temp: 75.5,
            tempmin: 70.5,
            tempmax: 80.5,
            feelslike: 32,
            datetime: '12/08/2023',
            humidity: 12.5,
            sunset: '17:30:00')
      ]),
      Weather(state: 'Illinois', weatherData: [
        WeatherByDay(
            icon: 'rain',
            conditions: 'Rain',
            temp: 65.5,
            tempmin: 60.5,
            tempmax: 86.5,
            feelslike: 30,
            datetime: '12/08/2023',
            humidity: 7.5,
            sunset: '18:17:23')
      ])
    ];

    final Map<String, String> iconsMap = {'clear-day': '☀️', 'rain': '🌧️'};
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => Favorites(),
          child: Home(weatherData: weatherData, iconsMap: iconsMap),
        ),
      ),
    );
    expect(find.text('☀️'), findsOneWidget);
    expect(find.text('🌧️'), findsOneWidget);
  });
}
