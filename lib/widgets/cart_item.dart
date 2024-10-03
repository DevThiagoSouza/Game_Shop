import 'package:flutter/material.dart';
import '../models/game.dart';

class CartItem extends StatelessWidget {
  final Game game;
  final VoidCallback onRemove;

  const CartItem({Key? key, required this.game, required this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(game.imageUrl, width: 50),
        title: Text(game.title),
        subtitle: Text('\$${game.price.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onRemove, // Chama a função para remover o item
        ),
      ),
    );
  }
}
