class Game {
  final String title;
  final String imageUrl;
  final double price;
  bool isFavorite; // Adicionando o campo isFavorite

  Game({
    required this.title,
    required this.imageUrl,
    required this.price,
    this.isFavorite = false, // Valor padrão como false
  });
}
