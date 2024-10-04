import 'package:flutter/material.dart';
import '../models/game.dart';

class CartItem extends StatelessWidget {
  final Game game;
  final VoidCallback onRemove;

  const CartItem({Key? key, required this.game, required this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(game.title),
      subtitle: Text('R\$ ${game.price.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: const Icon(Icons.remove_circle, color: Colors.red),
        onPressed: onRemove,
      ),
    );
  }
}
