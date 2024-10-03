import 'package:flutter/material.dart';

class CardRegistrationScreen extends StatefulWidget {
  const CardRegistrationScreen({Key? key}) : super(key: key);

  @override
  _CardRegistrationScreenState createState() => _CardRegistrationScreenState();
}

class _CardRegistrationScreenState extends State<CardRegistrationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cardHolderController.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _isSubmitting = true;
    });
    _controller.forward();

    // Simula um atraso para o cadastro do cartão
    await Future.delayed(const Duration(seconds: 2));

    // Aqui você pode adicionar a lógica para salvar os dados do cartão

    setState(() {
      _isSubmitting = false;
      _controller.reset();
      Navigator.pop(context); // Voltar à tela anterior
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Cartão'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _cardNumberController,
              decoration: const InputDecoration(labelText: 'Número do Cartão'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _expiryDateController,
              decoration: const InputDecoration(labelText: 'Validade (MM/AA)'),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: _cardHolderController,
              decoration: const InputDecoration(labelText: 'Nome do Titular'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submit,
              child: _isSubmitting
                  ? FadeTransition(
                opacity: _animation,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : const Text('Cadastrar Cartão'),
            ),
          ],
        ),
      ),
    );
  }
}
