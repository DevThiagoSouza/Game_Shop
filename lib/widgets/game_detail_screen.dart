import 'package:flutter/material.dart';
import '../models/game.dart';

class GameDetailScreen extends StatelessWidget {
  final Game game;

  const GameDetailScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: game.imageUrl.isNotEmpty
                      ? AssetImage(game.imageUrl) // Imagem local
                      : NetworkImage(game.imageUrl) as ImageProvider, // Imagem da web
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              game.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('R\$ ${game.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            // Adicione outras informações sobre o jogo aqui
          ],
        ),
      ),
    );
  }
}
