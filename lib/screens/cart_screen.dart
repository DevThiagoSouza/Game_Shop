import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pay/payment_screen.dart';
import '../widgets/cart_item.dart';
import '../widgets/card.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text('Seu carrinho está vazio!'))
          : ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final game = cart.items[index];
          return CartItem(
            game: game,
            onRemove: () {
              cart.removeGame(game);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentScreen()),
          );
        },
        child: const Icon(Icons.payment),
      ),
    );
  }
}
