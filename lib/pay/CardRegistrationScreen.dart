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
  final TextEditingController _cvvController = TextEditingController();

  bool _isSubmitting = false;
  bool _showBack = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cardHolderController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _isSubmitting = true;
    });
    _controller.forward();
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isSubmitting = false;
      _controller.reset();
      Navigator.pop(context);
    });
  }

  void _toggleCard() {
    setState(() {
      _showBack = !_showBack;
      if (_showBack) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Cartão'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _toggleCard,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(_animation.value * 3.14), // 180 degrees
                    child: Container(
                      width: 300,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: _showBack ? _buildCardBack() : _buildCardFront(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            if (_showBack)
              TextField(
                controller: _cvvController,
                decoration: const InputDecoration(labelText: 'CVV'),
                keyboardType: TextInputType.number,
                obscureText: true,
                onChanged: (value) => setState(() {}),
              )
            else ...[
              TextField(
                controller: _cardNumberController,
                decoration: const InputDecoration(labelText: 'Número do Cartão'),
                keyboardType: TextInputType.number,
                onChanged: (value) => setState(() {}),
              ),
              TextField(
                controller: _expiryDateController,
                decoration: const InputDecoration(labelText: 'Validade (MM/AA)'),
                keyboardType: TextInputType.datetime,
                onChanged: (value) => setState(() {}),
              ),
              TextField(
                controller: _cardHolderController,
                decoration: const InputDecoration(labelText: 'Nome do Titular'),
                onChanged: (value) => setState(() {}),
              ),
            ],
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

  Widget _buildCardFront() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Cartão de Crédito',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          _cardNumberController.text.isEmpty ? '**** **** **** ****' : _cardNumberController.text,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        const SizedBox(height: 10),
        Text(
          _expiryDateController.text.isEmpty ? 'Validade: --/--' : 'Validade: ${_expiryDateController.text}',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Text(
          _cardHolderController.text.isEmpty ? 'Nome do Titular' : _cardHolderController.text,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildCardBack() {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'CVV',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            _cvvController.text.isEmpty ? '***' : _cvvController.text,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ],
      ),
    );
  }
}
