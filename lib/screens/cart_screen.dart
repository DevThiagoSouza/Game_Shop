import 'package:flutter/material.dart';
import '../models/game.dart';
import '../pay/payment_screen.dart';
import '../widgets/cart_item.dart';
 // Importa a tela de pagamento

class CartScreen extends StatelessWidget {
  final List<Game> cartItems;

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Seu carrinho está vazio!'))
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final game = cartItems[index];
          return CartItem(
            game: game,
            onRemove: () {
              // Ação para remover o item do carrinho
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
