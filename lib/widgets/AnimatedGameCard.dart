import 'package:flutter/cupertino.dart';

import '../models/game.dart';
import 'game_card.dart';

class AnimatedGameCard extends StatefulWidget {
  final Game game;
  final Duration duration;

  const AnimatedGameCard({Key? key, required this.game, this.duration = const Duration(milliseconds: 300)}) : super(key: key);

  @override
  _AnimatedGameCardState createState() => _AnimatedGameCardState();
}

class _AnimatedGameCardState extends State<AnimatedGameCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: GameCard(game: widget.game, onRemove: (Game value) {  },),
    );
  }
}
