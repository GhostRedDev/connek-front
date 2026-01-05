import 'package:flutter/material.dart';

class CheckoutResume extends StatelessWidget {
  const CheckoutResume({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout Summary')),
      body: const Center(child: Text('Checkout Details')),
    );
  }
}
