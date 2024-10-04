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
              child: game.imageUrl.isNotEmpty
                  ? Image(
                image: game.imageUrl.startsWith('http')
                    ? NetworkImage(game.imageUrl)
                    : AssetImage(game.imageUrl) as ImageProvider,
                fit: BoxFit.cover,
              )
                  : const Placeholder(),
            ),
            const SizedBox(height: 20),
            Text(
              game.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('R\$ ${game.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
