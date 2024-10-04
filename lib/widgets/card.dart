import 'package:flutter/material.dart';
import '../models/game.dart';

class Cart with ChangeNotifier {
  final List<Game> _items = [];

  List<Game> get items => _items;

  void addGame(Game game) {
    _items.add(game);
    notifyListeners();
  }

  void removeGame(Game game) {
    _items.remove(game);
    notifyListeners();
  }

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.price);
}
