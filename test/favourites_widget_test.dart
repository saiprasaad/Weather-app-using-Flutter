import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/favorites.dart';
import 'package:mp5/views/favouritepages.dart';
import 'package:provider/provider.dart';

late Favorites favoritesList;

Widget createFavoritePageScreen() => ChangeNotifierProvider<Favorites>(
      create: (context) {
        favoritesList = Favorites();
        return favoritesList;
      },
      child: const MaterialApp(
        home: FavouritesPage(),
      ),
    );

void addItems() {
  favoritesList.add("Illinois");
}

void main() {
  testWidgets('Favourites widget test', (WidgetTester tester) async {
    await tester.pumpWidget(createFavoritePageScreen());
    addItems();
    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
  });
}
