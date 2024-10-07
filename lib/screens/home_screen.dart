import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../services/game_service.dart';
import '../widgets/card.dart';
import '../widgets/favorite_games.dart';
import '../widgets/game_card.dart';
import 'cart_screen.dart';
import 'favorite_games_screen.dart';
import 'profile_screen.dart';
import '../widgets/pre_orders_screen.dart';
import '../widgets/best_sellers_screen.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameService = GameService();
    final games = gameService.getAllGames();
    final bestSellers = gameService.getBestSellers();
    final preOrders = gameService.getPreOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Store'),
        actions: [
          Consumer<FavoriteGames>(
            builder: (context, favoriteGames, child) {
              return IconButton(
                icon: badges.Badge(
                  badgeContent: Text('${favoriteGames.favorites.length}'),
                  child: const Icon(Icons.favorite),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoriteGamesScreen()),
                  );
                },
              );
            },
          ),
          Consumer<Cart>(
            builder: (context, cart, child) {
              return IconButton(
                icon: badges.Badge(
                  badgeContent: Text('${cart.totalItems}'),
                  child: const Icon(Icons.shopping_cart),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context, bestSellers, preOrders),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBanner(),
            const SizedBox(height: 16),
            _buildCarousel(),
            const SizedBox(height: 16),
            _buildSectionTitle(context, 'Todos os Jogos', games),
            _buildGameGrid(games),
            const SizedBox(height: 20),
            _buildSectionTitle(context, 'Mais Vendidos', bestSellers),
            _buildGameGrid(bestSellers),
            const SizedBox(height: 20),
            _buildSectionTitle(context, 'Pré-Vendas', preOrders),
            _buildGameGrid(preOrders),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/images/banner/red-dead-redemption-2-new-banner.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    final banners = [
      'lib/assets/images/banner/the-last-of-us.jpg',
      'lib/assets/images/banner/banner-resident-evil-7.jpg',
      'lib/assets/images/banner/gta-5.jpg',
      'lib/assets/images/banner/final-fantasy-7.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(height: 200, autoPlay: true),
      items: banners.map((bannerPath) {
        return Container(
          margin: const EdgeInsets.all(4.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(bannerPath, fit: BoxFit.cover),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, List<Game> games) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: () {
              // Lógica para navegar para a tela correspondente
            },
            child: const Text('Ver Todos'),
          ),
        ],
      ),
    );
  }

  Widget _buildGameGrid(List<Game> games) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: games.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => GameCard(game: games[index]),
    );
  }

  Widget _buildDrawer(BuildContext context, List<Game> bestSellers, List<Game> preOrders) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _buildDrawerItem(context, Icons.home, 'Home', () => Navigator.pop(context)),
          _buildDrawerItem(context, Icons.shopping_cart, 'Carrinho', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
          }),
          _buildDrawerItem(context, Icons.star, 'Mais Vendidos', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BestSellersScreen(games: bestSellers, bestSellers: [],)));
          }),
          _buildDrawerItem(context, Icons.new_releases, 'Pré-Vendas', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PreOrdersScreen(games: preOrders, preOrders: [],)));
          }),
          const Divider(),
          _buildDrawerItem(context, Icons.person, 'Perfil', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
