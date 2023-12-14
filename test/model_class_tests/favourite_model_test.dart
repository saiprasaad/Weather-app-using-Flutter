import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/favorites.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  group('Testing Favorite Class', () {
    test('Testing Adding Favorite States', () async {
      SharedPreferences.setMockInitialValues({});
      WidgetsFlutterBinding.ensureInitialized();
      Favorites favorites = Favorites();
      favorites.add('Illinois');
      favorites.add('California');
      expect(favorites.favoriteStateValues, ['Illinois', 'California']);
      favorites.remove('California');
      expect(favorites.favoriteStateValues, ['Illinois']);
    });

    test('Testing Removing Favourite States', ()  async {
      SharedPreferences.setMockInitialValues({});
      WidgetsFlutterBinding.ensureInitialized();
      Favorites favorites = Favorites();
      favorites.add('Illinois');
      favorites.remove('Illinois');
      expect(favorites.favoriteStateValues, List.empty());
    });
  });
}
