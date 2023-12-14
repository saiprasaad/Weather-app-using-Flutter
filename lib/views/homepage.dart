import 'package:flutter/material.dart';
import 'package:mp5/models/favorites.dart';
import 'package:mp5/models/weather.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mp5/views/favouritepages.dart';
import 'package:mp5/views/weatherdescription.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String baseUrl =
      'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Weather>?> futureWeather;
  int _selectedIndex = 0;
  final iconsMap = {
    "clear-day": "☀️",
    "clear-night": "🌙",
    "snow": "❄️",
    "rain": "🌧️",
    "partly-cloudy-day": "⛅"
  };
  final locations = [
    "Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi",
    "Missouri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "New York",
    "North Carolina",
    "North Dakota",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Vermont",
    "Virginia",
    "Washington",
    "West Virginia",
    "Wisconsin",
    "Wyoming"
  ];

  @override
  void initState() {
    super.initState();
    futureWeather = _loadWeather();
  }

  Future<List<Weather>?> _loadWeather() async {
    List<Weather> weatherData = [];
    for (var location in locations) {
      final response = await http.get(
        Uri.parse(
            "${widget.baseUrl}/$location/next7days?unitGroup=metric&include=days&key=XEYA4PMWYMAYV3PQAD4XV6LJ9&contentType=json"),
      );
      Map<String, dynamic> map = json.decode(response.body);
      weatherData.add(Weather.fromJson(map));
    }
    return weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Favorites>(
        create: (context) => Favorites(),
        child: FutureBuilder<List<Weather>?>(
            future: futureWeather,
            initialData: const [],
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                var weatherData = (snapshot.data ?? []);
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Weather of US States'),
                  ),
                  body: [
                    Home(weatherData: weatherData, iconsMap: iconsMap),
                    const FavouritesPage()
                  ][_selectedIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    elevation: 0,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: _selectedIndex == 0
                            ? const Icon(Icons.home_filled)
                            : const Icon(Icons.home_outlined),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: _selectedIndex == 1
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border),
                        label: 'Favorites',
                      ),
                    ],
                    currentIndex: _selectedIndex, //New
                    onTap: _onItemTapped,
                  ),
                );
              }
            }));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.weatherData,
    required this.iconsMap,
  });

  final List<Weather> weatherData;
  final Map<String, String> iconsMap;

  @override
  Widget build(BuildContext context) {
    var favoritesList = Provider.of<Favorites>(context);
    return Column(
      children: [
        const Text(
            "Click on each weather to navigate to weather description page...", style: TextStyle(fontSize: 12),),
        Expanded(
          child: ListView.builder(
              itemCount: weatherData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return WeatherDescription(
                          weather: weatherData[index], iconsMap: iconsMap);
                    }));
                  },
                  child: Row(children: [
                    Flexible(
                        flex: 7,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.2),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 2.0,
                                      spreadRadius: 0.4,
                                      offset: Offset(0.1, 0.5)),
                                ],
                                color: Colors.blue[100]),
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          iconsMap.containsKey(
                                                  weatherData[index]
                                                      .weatherData[0]
                                                      .icon)
                                              ? Text(
                                                  iconsMap[weatherData[index]
                                                      .weatherData[0]
                                                      .icon]!,
                                                  style: const TextStyle(
                                                      fontSize: 35),
                                                )
                                              : const Text(
                                                  "☁️",
                                                  style:
                                                      TextStyle(fontSize: 35),
                                                ),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                        ]),
                                    Flexible(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // Flexible(child:
                                        // Row(children: [
                                        Text(weatherData[index].state,
                                            style:
                                                const TextStyle(fontSize: 20),
                                            textAlign: TextAlign.center
                                            // )]),
                                            ),
                                        const SizedBox(height: 10),

                                        Text(
                                          weatherData[index]
                                              .weatherData[0]
                                              .conditions,
                                          style: const TextStyle(fontSize: 14),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    )),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${weatherData[index].weatherData[0].temp} °F",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "${weatherData[index].weatherData[0].tempmin} °F / ${weatherData[index].weatherData[0].tempmax} °F",
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            key: Key(
                                                'icon_${weatherData[index].state}'),
                                            icon: favoritesList
                                                    .favoriteStateValues
                                                    .contains(weatherData[index]
                                                        .state)
                                                ? const Icon(Icons.favorite)
                                                : const Icon(
                                                    Icons.favorite_border),
                                            onPressed: () {
                                              !favoritesList.favoriteStateValues
                                                      .contains(
                                                          weatherData[index]
                                                              .state)
                                                  ? favoritesList.add(
                                                      weatherData[index].state)
                                                  : favoritesList.remove(
                                                      weatherData[index].state);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(favoritesList
                                                          .favoriteStateValues
                                                          .contains(
                                                              weatherData[index]
                                                                  .state)
                                                      ? 'Added the state to favorites.'
                                                      : 'Removed the state from favorites.'),
                                                  duration: const Duration(
                                                      seconds: 1),
                                                ),
                                              );
                                            },
                                          ),
                                        ])
                                  ],
                                )))),
                  ]),
                );
              }),
        )
      ],
    );
  }
}
