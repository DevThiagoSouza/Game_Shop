import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../widgets/favorite_games.dart';
import '../widgets/game_card.dart';

class FavoriteGamesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoriteGames = Provider.of<FavoriteGames>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogos Favoritos'),
      ),
      body: favoriteGames.favorites.isEmpty
          ? Center(child: Text('Nenhum jogo favorito encontrado.'))
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: favoriteGames.favorites.length,
        itemBuilder: (context, index) {
          return GameCard(game: favoriteGames.favorites[index]);
        },
      ),
    );
  }
}
