import 'package:flutter/material.dart';
import '../models/game.dart';
import '../widgets/game_card.dart';

class PreOrdersScreen extends StatelessWidget {
  final List<Game> preOrders;

  const PreOrdersScreen({Key? key, required this.preOrders, required List<Game> games}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pré-Vendas'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: preOrders.length,
        itemBuilder: (context, index) {
          return GameCard(game: preOrders[index], onRemove: (Game value) {  },);
        },
      ),
    );
  }
}
