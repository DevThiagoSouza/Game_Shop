import 'package:flutter/material.dart';
import '../models/game.dart';

class FavoriteGames with ChangeNotifier {
  final List<Game> _favorites = [];

  List<Game> get favorites => _favorites;

  void toggleFavorite(Game game) {
    if (_favorites.contains(game)) {
      _favorites.remove(game);
    } else {
      _favorites.add(game);
    }
    notifyListeners();
  }

  bool isFavorite(Game game) {
    return _favorites.contains(game);
  }
}
