import 'package:flutter/material.dart';
import '../models/game.dart';
import '../screens/game_detail_screen.dart'; // Importe a tela de detalhes

class GameCard extends StatelessWidget {
  final Game game;

  const GameCard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        elevation: 4, // Elevação para dar uma leve sombra
        child: Column(
          children: [
            // Container para a imagem
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: game.imageUrl.isNotEmpty
                      ? AssetImage(game.imageUrl) // Imagem local
                      : NetworkImage(game.imageUrl) as ImageProvider, // Imagem da web
                  fit: BoxFit.cover, // Faz a imagem ocupar todo o espaço
                ),
              ),
            ),
            const SizedBox(height: 8), // Espaço entre a imagem e o título
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0), // Ajusta as laterais
              child: Text(
                game.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4), // Espaço entre o título e o preço
            Text('R\$ ${game.price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
