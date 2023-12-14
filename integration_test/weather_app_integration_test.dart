import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/favorites.dart';
import 'package:mp5/models/weather.dart';
import 'package:mp5/models/weatherbyday.dart';
import 'package:mp5/views/favouritepages.dart';
import 'package:mp5/views/homepage.dart';
import 'package:mp5/views/weatherdescription.dart';
import 'package:provider/provider.dart';

void main() {
  
  group('Testing Scrollability of the favorites', () {
  testWidgets('Testing Scrollability of the favorites', (WidgetTester tester) async {
    await tester.pumpAndSettle();
    final Favorites favorites = Favorites();
    favorites.add('Texas');
    favorites.add('Arizona');
    favorites.add('Alaska');
    favorites.add('Colorado');
    favorites.add('Ohio');
    favorites.add('Kentucky');
    favorites.add('Louisiana');
    favorites.add('Maine');
    favorites.add('Maryland');
    favorites.add('Massachusetts');
    favorites.add('Minnesota');
    favorites.add('Mississippi');
    favorites.add('Nebraska');
    favorites.add('New Jersey');
    favorites.add('New Hampshire');
    favorites.add('New Mexico');
    favorites.add('North Carolina');
    favorites.add('Oklahoma');
    favorites.add('Oregon');
    favorites.add('Pennsylvania');
    favorites.add('Rhode Island');
    favorites.add('South Carolina');
    favorites.add('South Dakota');
    favorites.add('Tennessee');
    favorites.add('Texas');
    favorites.add('Vermont');
    favorites.add('Virginia');
    favorites.add('Washington');
    favorites.add('West Virginia');
    favorites.add('Wisconsin');
    favorites.add('Indiana');
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: favorites,
          child: const FavouritesPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Texas'), findsOneWidget);
    await tester.dragUntilVisible(
        find.text('Indiana'), find.byType(ListView), const Offset(0, -1000));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text('Indiana'), findsOneWidget);
    await tester.pumpAndSettle();
  });
  });
  group('Testing Weather Listing and Weather Description Page', () {
    testWidgets('Weather operations test', (tester) async {
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
        Weather(state: 'California', weatherData: [
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
        Weather(state: 'Arizona', weatherData: [
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
            child: Scaffold(body: Home(weatherData: weatherData, iconsMap: {})),
          ),
        ),
      );
      final iconKeys = ['icon_Illinois', 'icon_California'];

      for (var icon in iconKeys) {
        await tester.tap(find.byKey(ValueKey(icon)));
        await tester.pumpAndSettle(const Duration(seconds: 1));
        expect(find.text('Added the state to favorites.'), findsOneWidget);
      }

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Illinois Weather'), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.text('Illinois'), findsOneWidget);
    });
  });


  group('Testing Scrollability', () {
  testWidgets('Scroll the forecast listview to bottom', (tester) async {
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
    await tester.pumpWidget(
      MaterialApp(
        // home: FavouritesPage(),
        home: ChangeNotifierProvider(
            create: (context) => Favorites(),
            child: WeatherDescription(weather: weather, iconsMap: {})),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.dragUntilVisible(
        find.text('12/15/2023'), find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text('12/15/2023'), findsOneWidget);
  });
  });
}
