enum Platform {
  PlayStation,
  Xbox,
  PC,
  Switch,
}

class Game {
  final String title;
  final String imageUrl;
  final double price;
  final String description;
  final String videoUrl;
  final List<Platform> platforms;

  Game({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.videoUrl,
    required this.platforms,
  });
}
