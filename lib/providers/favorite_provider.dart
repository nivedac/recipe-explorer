import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<String> _favorites = [];

  List<String> get favorites => _favorites;

  bool isFavorite(String id) {
    return _favorites.contains(id);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    _favorites.clear();

    _favorites.addAll(
      prefs.getStringList('favorites') ?? [],
    );

    notifyListeners();
  }

  Future<void> toggleFavorite(String id) async {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      'favorites',
      _favorites,
    );

    notifyListeners();
  }
}