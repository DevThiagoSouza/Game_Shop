import 'package:flutter/material.dart';
import '../models/game.dart';
import '../widgets/game_card.dart';

class BestSellersScreen extends StatelessWidget {
  final List<Game> bestSellers;

  const BestSellersScreen({Key? key, required this.bestSellers, required List<Game> games}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mais Vendidos'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: bestSellers.length,
        itemBuilder: (context, index) {
          return GameCard(game: bestSellers[index], onRemove: (Game value) {  },);
        },
      ),
    );
  }
}
