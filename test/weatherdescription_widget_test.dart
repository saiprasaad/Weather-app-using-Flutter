import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/favorites.dart';
import 'package:mp5/models/weather.dart';
import 'package:mp5/models/weatherbyday.dart';
import 'package:mp5/views/weatherdescription.dart';
import 'package:provider/provider.dart';

void main() {
  
  testWidgets('WeatherDescription widget test', (WidgetTester tester) async {
    final Weather weather = Weather(state: 'Illinois', weatherData: [
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
      ]);
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => Favorites(),
          child: WeatherDescription(weather: weather, iconsMap: {})
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Illinois Weather'), findsOneWidget);
    expect(find.text('7 Days Weather Forecast'), findsOneWidget);
    expect(find.text('7.5'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });  testWidgets('WeatherDescription Icons widget test', (WidgetTester tester) async {
    final Weather weather = Weather(state: 'Illinois', weatherData: [
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
      ]);
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => Favorites(),
          child: WeatherDescription(weather: weather, iconsMap: {})
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('💧 Humidity'), findsOneWidget);
    expect(find.text('🔆 Sunset'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });

   testWidgets('Testing Scrolling', (tester) async {
    final Weather weather = Weather(state: 'Illinois', weatherData: [
        WeatherByDay(
            icon: 'rain',
            conditions: 'Rain',
            temp: 65.5,
            tempmin: 60.5,
            tempmax: 86.5,
            feelslike: 30,
            datetime: '12/08/2023',
            humidity: 7.5,
            sunset: '18:17:23'),
            WeatherByDay(
            icon: 'rain',
            conditions: 'Rain',
            temp: 65.5,
            tempmin: 60.5,
            tempmax: 86.5,
            feelslike: 30,
            datetime: '12/09/2023',
            humidity: 7.5,
            sunset: '18:17:23'),
            WeatherByDay(
            icon: 'rain',
            conditions: 'Rain',
            temp: 65.5,
            tempmin: 60.5,
            tempmax: 86.5,
            feelslike: 30,
            datetime: '12/10/2023',
            humidity: 7.5,
            sunset: '18:17:23'),
            WeatherByDay(
            icon: 'rain',
            conditions: 'Rain',
            temp: 65.5,
            tempmin: 60.5,
            tempmax: 86.5,
            feelslike: 30,
            datetime: '12/11/2023',
            humidity: 7.5,
            sunset: '18:17:23'),
            WeatherByDay(
            icon: 'rain',
            conditions: 'Rain',
            temp: 65.5,
            tempmin: 60.5,
            tempmax: 86.5,
            feelslike: 30,
            datetime: '12/12/2023',
            humidity: 7.5,
            sunset: '18:17:23'),
            WeatherByDay(
            icon: 'rain',
            conditions: 'Rain',
            temp: 65.5,
            tempmin: 60.5,
            tempmax: 86.5,
            feelslike: 30,
            datetime: '12/13/2023',
            humidity: 7.5,
            sunset: '18:17:23'),
            WeatherByDay(
            icon: 'rain',
            conditions: 'Rain',
            temp: 65.5,
            tempmin: 60.5,
            tempmax: 86.5,
            feelslike: 30,
            datetime: '12/14/2023',
            humidity: 7.5,
            sunset: '18:17:23'),
            WeatherByDay(
            icon: 'rain',
            conditions: 'Rain',
            temp: 65.5,
            tempmin: 60.5,
            tempmax: 86.5,
            feelslike: 30,
            datetime: '12/15/2023',
            humidity: 7.5,
            sunset: '18:17:23')
      ]);
      await tester.pumpWidget(MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => Favorites(),
          child: WeatherDescription(weather: weather, iconsMap: {})
        ),
      ),);
      expect(find.text('12/09/2023'), findsOneWidget);
      await tester.fling(
        find.byType(ListView),
        const Offset(0, -150),
        3000,
      );
      await tester.pumpAndSettle();
      expect(find.text('12/15/2023'), findsOneWidget);
      await tester.fling(
        find.byType(ListView),
        const Offset(0, -100),
        3000,
      );
      await tester.pumpAndSettle();
      expect(find.text('12/09/2023'), findsNothing);
    });

}
