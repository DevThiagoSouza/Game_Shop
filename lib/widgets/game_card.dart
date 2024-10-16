import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../screens/game_detail_screen.dart';
import '../widgets/favorite_games.dart';
import 'card.dart';

class GameCard extends StatefulWidget {
  final Game game;
  final ValueChanged<Game> onRemove;

  const GameCard({Key? key, required this.game, required this.onRemove}) : super(key: key);

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  bool _isAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    final favoriteGames = Provider.of<FavoriteGames>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetailScreen(game: widget.game),
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
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            image: DecorationImage(
              image: widget.game.imageUrl.isNotEmpty
                  ? (widget.game.imageUrl.startsWith('http')
                  ? NetworkImage(widget.game.imageUrl)
                  : AssetImage(widget.game.imageUrl) as ImageProvider)
                  : AssetImage('assets/placeholder.png'), // Placeholder
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
    final isFavorite = favoriteGames.isFavorite(widget.game);

    return IconButton(
      icon: FaIcon(
        isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        favoriteGames.toggleFavorite(widget.game);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isFavorite
                  ? '${widget.game.title} removido dos favoritos!'
                  : '${widget.game.title} adicionado aos favoritos!',
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
        widget.game.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPrice() {
    return Text('R\$ ${widget.game.price.toStringAsFixed(2)}');
  }

  Widget _buildPurchaseButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (!_isAddedToCart) {
          Provider.of<Cart>(context, listen: false).addGame(widget.game);
          setState(() {
            _isAddedToCart = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${widget.game.title} adicionado ao carrinho!')),
          );
        } else {
          Provider.of<Cart>(context, listen: false).removeGame(widget.game);
          setState(() {
            _isAddedToCart = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${widget.game.title} removido do carrinho!')),
          );
          widget.onRemove(widget.game);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _isAddedToCart ? Colors.green : Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isAddedToCart) ...[
            Icon(Icons.check),
            const SizedBox(width: 4),
          ],
          Text(_isAddedToCart ? 'Adicionado' : 'Adicionar ao Carrinho'),
        ],
      ),
    );
  }

}
