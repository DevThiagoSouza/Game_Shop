import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../screens/game_detail_screen.dart';
import '../widgets/favorite_games.dart';
import 'card.dart';

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteGames = Provider.of<FavoriteGames>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailScreen(game: game),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            _buildImage(context, favoriteGames),
            const SizedBox(height: 8),
            _buildTitle(),
            const SizedBox(height: 4),
            _buildPrice(),
            const SizedBox(height: 8),
            _buildPurchaseButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context, FavoriteGames favoriteGames) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: game.imageUrl.isNotEmpty
                  ? AssetImage(game.imageUrl)
                  : NetworkImage(game.imageUrl) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: _buildFavoriteIcon(context, favoriteGames),
        ),
      ],
    );
  }

  Widget _buildFavoriteIcon(BuildContext context, FavoriteGames favoriteGames) {
    final isFavorite = favoriteGames.isFavorite(game);

    return IconButton(
      icon: FaIcon(
        isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        favoriteGames.toggleFavorite(game);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isFavorite
                  ? '${game.title} removido dos favoritos!'
                  : '${game.title} adicionado aos favoritos!',
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        game.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPrice() {
    return Text('R\$ ${game.price.toStringAsFixed(2)}');
  }

  Widget _buildPurchaseButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Provider.of<Cart>(context, listen: false).addGame(game);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${game.title} adicionado ao carrinho!')),
        );
      },
      child: const Text('Adicionar ao Carrinho'),
    );
  }
}
