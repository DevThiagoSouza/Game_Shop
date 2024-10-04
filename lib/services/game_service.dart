import 'package:flutter/material.dart';
import '../models/game.dart';

class GameService {

  final List<Game> _games = [
    Game(title: 'God of War', imageUrl: 'lib/assets/images/banner/banner-god-of-war.jpg', price: 59.99, platforms: []),
    Game(title: 'EA FC 24', imageUrl: 'lib/assets/images/banner/fc-24.png', price: 39.99, platforms: []),
    Game(title: 'The Last Of Us Part 2', imageUrl: 'lib/assets/images/banner/the-last-of-us-4k.jpg', price: 49.99, platforms: []),
    Game(title: 'Cyberpunk 2077', imageUrl: 'lib/assets/images/banner/ciberpunk.jpg', price: 29.99, platforms: []),
    Game(title: 'Forza Horizon 5', imageUrl: 'lib/assets/images/banner/forza-horizon.jpg', price: 39.99, platforms: []),
    Game(title: 'Mario Kart 8', imageUrl: 'lib/assets/images/banner/mario-kart-8.jpg', price: 29.99, platforms: []),
    Game(title: 'Forza Horizon 5', imageUrl: 'lib/assets/images/banner/forza-horizon.jpg', price: 39.99, platforms: []),
    Game(title: 'Game 7', imageUrl: 'https://via.placeholder.com/150', price: 49.99, platforms: []),
    Game(title: 'Game 8', imageUrl: 'https://via.placeholder.com/150', price: 19.99, platforms: []),
  ];

  List<Game> getAllGames() {
    return _games;
  }

  List<Game> getBestSellers() {
    return _games.where((game) => game.price > 30).toList();
  }

  List<Game> getPreOrders() {
    return _games.where((game) => game.price < 30).toList();
  }
}
