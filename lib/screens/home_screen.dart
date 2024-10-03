import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/game.dart';
import '../widgets/game_card.dart';
import 'cart_screen.dart';
import '../widgets/pre_orders_screen.dart';
import '../widgets/best_sellers_screen.dart';
import '../services/game_service.dart';
import 'profile_screen.dart'; // Importa a nova tela de perfil

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GameService _gameService = GameService(); // Instância do GameService

  @override
  Widget build(BuildContext context) {
    final List<Game> games = _gameService.getAllGames();
    final List<Game> bestSellers = _gameService.getBestSellers();
    final List<Game> preOrders = _gameService.getPreOrders();

    final List<String> banners = [
      'lib/assets/images/banner/the-last-of-us.jpg', // Imagem local
      'lib/assets/images/banner/banner-resident-evil-7.jpg',
      'lib/assets/images/banner/gta-5.jpg',
      'lib/assets/images/banner/final-fantasy-7.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(cartItems: [])), // Passar os itens do carrinho
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Fecha o menu
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Carrinho'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen(cartItems: [])), // Passar os itens do carrinho
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Mais Vendidos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BestSellersScreen(games: bestSellers, bestSellers: [],)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.new_releases),
              title: const Text('Pré-Vendas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreOrdersScreen(games: preOrders, preOrders: const [],)),
                );
              },
            ),
            const Divider(), // Adiciona uma linha de separação
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner estático no topo
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/banner/red-dead-redemption-2-new-banner.jpg'), // Usando imagem local
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Carrossel
            CarouselSlider(
              options: CarouselOptions(height: 200, autoPlay: true),
              items: banners.map((bannerPath) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: bannerPath.startsWith('http')
                        ? Image.network(bannerPath, fit: BoxFit.cover)
                        : Image.asset(bannerPath, fit: BoxFit.cover), // Usando imagem local
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Seção de Todos os Jogos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Todos os Jogos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // Lógica para ver todos os jogos
                    },
                    child: const Text('Ver Todos'),
                  ),
                ],
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: games.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => GameCard(game: games[index]),
            ),
            const SizedBox(height: 20),

            // Seção de Mais Vendidos
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mais Vendidos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BestSellersScreen(games: bestSellers, bestSellers: [],)),
                      );
                    },
                    child: const Text('Ver Todos'),
                  ),
                ],
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: bestSellers.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => GameCard(game: bestSellers[index]),
            ),
            const SizedBox(height: 20),

            // Seção de Pré-Vendas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pré-Vendas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PreOrdersScreen(games: preOrders, preOrders: [],)),
                      );
                    },
                    child: const Text('Ver Todos'),
                  ),
                ],
              ),
            ),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: preOrders.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => GameCard(game: preOrders[index]),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
