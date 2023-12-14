import 'package:flutter/material.dart';
import 'package:mp5/models/weather.dart';

class WeatherDescription extends StatefulWidget {
  final Weather weather;
  final Map<String, String> iconsMap;
  const WeatherDescription(
      {super.key, required this.weather, required this.iconsMap});

  @override
  State<WeatherDescription> createState() => _WeatherDescriptionState();
}

class _WeatherDescriptionState extends State<WeatherDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("${widget.weather.state} Weather")),
        backgroundColor: Colors.blueAccent,
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    widget.weather.state,
                    style: const TextStyle(fontSize: 50, color: Colors.white),
                  )
                ])),
            Expanded(
                flex: 2,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "${widget.weather.weatherData[0].temp} °F",
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  )
                ])),
            const Expanded(
                flex: 1,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Today",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ])),
                Expanded(
                flex: 1,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    widget.weather.weatherData[0].conditions,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  )
                ])),
                 Expanded(
                  flex: 3,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   
                    Card(
                     color: Colors.white,child: 
                      Padding(padding: const EdgeInsets.only(left: 20, right: 20),child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [const Text("💧 Humidity",), Text(widget.weather.weatherData[0].humidity.toString())],) ,)),
                     Card(
                     color: Colors.white,child: 
                      Padding(padding: const EdgeInsets.only(left: 20, right: 20),child:
                      Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [const Text("🔆 Sunset",),Text(widget.weather.weatherData[0].sunset.toString())])))])),
            
            const Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "7 Days Weather Forecast",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        ]))),
            Expanded(
                flex: 10,
                child: Container(
                    alignment: Alignment.center,
                    child: ListView.builder(
                        itemCount: widget.weather.weatherData.length,
                        itemBuilder: (context, index) {
                          if (index > 0) {
                            return Card(
                                child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.weather.weatherData[index]
                                              .datetime),
                                          widget.iconsMap.containsKey(widget
                                                  .weather
                                                  .weatherData[index]
                                                  .icon)
                                              ? Text(
                                                  widget.iconsMap[widget
                                                      .weather
                                                      .weatherData[index]
                                                      .icon]!,
                                                  style: const TextStyle(
                                                      fontSize: 20),
                                                )
                                              : const Text(
                                                  "☁️",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                          Text(
                                              "${widget.weather.weatherData[index].tempmin} °F"),
                                          Text(
                                              "${widget.weather.weatherData[index].tempmax} °F")
                                        ])));
                          }
                          return Container();
                        })))
          ],
        ));
  }
}