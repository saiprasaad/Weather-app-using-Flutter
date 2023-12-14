import 'package:flutter/material.dart';
import 'package:mp5/models/weather.dart';
import 'package:mp5/views/weatherdescription.dart';
import 'package:provider/provider.dart';
import '../models/favorites.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Favorites>(
          builder: (context, value, child) => ListView.builder(
                itemCount: value.favoriteStateValues.length,
                itemBuilder: (context, index) =>
                    FavouriteItem(value.favoriteStateValues[index]),
              )),
    );
  }
}

class FavouriteItem extends StatefulWidget {
  final String stateName;
  final String baseUrl =
      'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline';
  const FavouriteItem(this.stateName, {super.key});

  @override
  State<FavouriteItem> createState() => _FavouriteItemState();
}

class _FavouriteItemState extends State<FavouriteItem> {
  Future<Weather>? _loadWeatherByStateName(String stateName) async {
    final response = await http.get(
      Uri.parse(
          "${widget.baseUrl}/$stateName/next7days?unitGroup=metric&include=days&key=XEYA4PMWYMAYV3PQAD4XV6LJ9&contentType=json"),
    );
    Map<String, dynamic> map = json.decode(response.body);
    return Weather.fromJson(map);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: ElevatedButton(
          key: Key('favorites_text_${widget.stateName}'),
          onPressed: () async {
            _loadWeatherByStateName(widget.stateName)?.then((value) => {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return WeatherDescription(weather: value, iconsMap: const {
                      "clear-day": "☀️",
                      "clear-night": "🌙",
                      "snow": "❄️",
                      "rain": "🌧️",
                      "partly-cloudy-day": "⛅"
                    });
                  }))
                });
          },
          child: Text(
            widget.stateName,
            textAlign: TextAlign.start,
          ),
        ),
        trailing: IconButton(
          key: Key('remove_icon_${widget.stateName}'),
          icon: const Icon(Icons.close),
          onPressed: () {
            Provider.of<Favorites>(context, listen: false)
                .remove(widget.stateName);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Removed the state from favorites.'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
