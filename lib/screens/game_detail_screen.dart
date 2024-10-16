import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/game.dart';
import 'package:provider/provider.dart';
import '../widgets/card.dart';
import '../widgets/favorite_games.dart';

class GameDetailScreen extends StatefulWidget {
  final Game game;

  const GameDetailScreen({Key? key, required this.game}) : super(key: key);

  @override
  _GameDetailScreenState createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.game.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      }).catchError((error) {
        print("Error loading video: $error");
      });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _videoController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Provider.of<FavoriteGames>(context, listen: false).toggleFavorite(widget.game);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${widget.game.title} adicionado aos favoritos!')),
              );
            },
          ),
        ],
      ),
      body: ScaleTransition(
        scale: _scaleAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                child: Image.asset(
                  widget.game.imageUrl,
                  height: 250,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.game.title,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'R\$ ${widget.game.price.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.green),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.game.platforms.isNotEmpty
                              ? 'Plataformas: ${widget.game.platforms.map((p) => p.toString().split('.').last).join(', ')}'
                              : 'Plataformas: Não disponíveis',
                          style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.game.description.isNotEmpty ? widget.game.description : 'Descrição não disponível.',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<Cart>(context, listen: false).addGame(widget.game);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${widget.game.title} adicionado ao carrinho!')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          child: const Text('Adicionar ao Carrinho', style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
