import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/card.dart';
import 'game_detail_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: cart.totalItems == 0
          ? Center(child: Text('Seu carrinho está vazio.'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.games.length,
              itemBuilder: (context, index) {
                final game = cart.games[index];
                final quantity = cart.items[game]!;

                return Dismissible(
                  key: ValueKey(game),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    cart.removeGame(game);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${game.title} removido do carrinho')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(game.title),
                    subtitle: Text('Quantidade: $quantity'),
                    trailing: Text('R\$ ${(game.price * quantity).toStringAsFixed(2)}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameDetailScreen(game: game),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Total: R\$ ${cart.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/payment');
                  },
                  child: Text('Ir para o Pagamento'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
