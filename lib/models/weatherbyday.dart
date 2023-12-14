class WeatherByDay {
  double tempmin;
  double tempmax;
  double temp;
  double feelslike;
  String conditions;
  String icon;
  String datetime;
  double humidity;
  String sunset;

  WeatherByDay({required this.tempmin, required this.tempmax, required this.temp, required this.feelslike, required this.conditions, required this.icon, required this.datetime, required this.humidity, required this.sunset});

  factory WeatherByDay.fromJson(Map<String, dynamic> json) {
    return WeatherByDay(
        tempmin: json['tempmin'] as double, 
        tempmax: json['tempmax'] as double,
        temp: json['temp'] as double,
        feelslike: json['feelslike'] as double, 
        conditions: json['conditions'] as String,
        icon: json['icon'] as String, 
        datetime: json['datetime'] as String, 
        humidity: json['humidity'] as double,
        sunset: json['sunset'] as String);
  }
}