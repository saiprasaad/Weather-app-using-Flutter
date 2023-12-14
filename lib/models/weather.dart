import 'package:mp5/models/weatherbyday.dart';
class Weather {
  String state;
  List<WeatherByDay> weatherData;

  Weather({required this.state, required this.weatherData});

  factory Weather.fromJson(Map<String,dynamic> json) {
    final daysJson = json['days'] as List<dynamic>;
    return Weather(
      state: (json['address'] ?? "")as String ,
      weatherData: daysJson
            .map((data) => WeatherByDay.fromJson(data))
            .toList());
  }
}