import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  static const String _favStateNames = 'favStates';

  static Future<List<String>> getFavoritesFromSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favStateNames)?? [];
  }

  static Future<void> setFavoritesInSharedPreference(List<String> states) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favStateNames, states);
  }
}
