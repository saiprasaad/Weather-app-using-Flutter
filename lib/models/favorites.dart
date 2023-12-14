import 'package:flutter/material.dart';
import 'package:mp5/utils/sharedpreferencemanager.dart';

class Favorites extends ChangeNotifier {
   List<String> _favoriteStates = [];

  List<String> get favoriteStateValues => _favoriteStates;

  Favorites() {
    SharedPreferenceManager.getFavoritesFromSharedPreference().then((value) => {
      _favoriteStates = value,
      notifyListeners()
    });
  }

  void add(String weather) {
    _favoriteStates.add(weather);
    SharedPreferenceManager.setFavoritesInSharedPreference(_favoriteStates);
    notifyListeners();
  }

  void remove(String weather) {
    _favoriteStates.remove(weather);
    SharedPreferenceManager.setFavoritesInSharedPreference(_favoriteStates);
    notifyListeners();
  }
}
