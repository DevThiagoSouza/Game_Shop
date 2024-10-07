import 'package:flutter/material.dart';
import 'package:loja_games_project/pay/payment_screen.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'widgets/card.dart';
import 'widgets/favorite_games.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => FavoriteGames()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mario Verde',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
      routes: {
        '/payment': (context) => const PaymentScreen(),
      },
    );
  }
}
