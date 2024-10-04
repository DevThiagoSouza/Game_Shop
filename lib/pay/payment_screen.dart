import 'package:flutter/material.dart';
import 'CardRegistrationScreen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    width: 300,
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 70,
                          left: 10,
                          child: Image.asset(
                            'lib/assets/images/chip.png',
                            width: 40,
                          ),
                        ),
                        Positioned(
                          top: 60,
                          left: 70,
                          child: const Text(
                            'Cartão de Crédito',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          top: 90,
                          left: 70,
                          child: const Text(
                            '**** **** **** 1234',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          left: 70,
                          child: const Text(
                            'Validade: 12/25',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 70,
                          child: const Text(
                            'Nome do Titular',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Processando Pagamento...',
                  style: TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CardRegistrationScreen()),
              );
            },
            child: const Text('Cadastrar Novo Cartão'),
          ),
        ],
      ),
    );
  }
}
