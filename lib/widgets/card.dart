import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import 'favorite_games.dart';

class Cart with ChangeNotifier {
  final Map<Game, int> _items = {};

  List<Game> get games => _items.keys.toList();
  Map<Game, int> get items => _items;

  void addGame(Game game) {
    if (_items.containsKey(game)) {
      _items[game] = _items[game]! + 1;
    } else {
      _items[game] = 1;
    }
    notifyListeners();
  }

  void removeGame(Game game) {
    if (_items.containsKey(game)) {
      _items[game] = _items[game]! - 1;
      if (_items[game] == 0) {
        _items.remove(game);
      }
      notifyListeners();
    }
  }

  double get totalPrice =>
      _items.entries.fold(0, (sum, entry) => sum + (entry.key.price * entry.value));

  int get totalItems =>
      _items.values.fold(0, (sum, quantity) => sum + quantity);

}
