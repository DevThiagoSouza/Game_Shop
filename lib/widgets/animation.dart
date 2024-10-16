import 'package:flutter/material.dart';

class AddToCartAnimation extends StatefulWidget {
  final Offset startPosition;
  final Offset endPosition;
  final Duration duration;

  const AddToCartAnimation({
    Key? key,
    required this.startPosition,
    required this.endPosition,
    this.duration = const Duration(seconds: 1), required Icon child,
  }) : super(key: key);

  @override
  _AddToCartAnimationState createState() => _AddToCartAnimationState();
}

class _AddToCartAnimationState extends State<AddToCartAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward().then((_) => Navigator.of(context).pop());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double xOffset = widget.endPosition.dx - widget.startPosition.dx;
    double yOffset = widget.endPosition.dy - widget.startPosition.dy;

    return Positioned(
      left: widget.startPosition.dx,
      top: widget.startPosition.dy,
      child: Transform.scale(
        scale: _animation.value,
        child: Opacity(
          opacity: 1 - _animation.value,
          child: Icon(
            Icons.shopping_cart,
            size: 100,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
