import 'package:flutter/material.dart';

class ClientDashboardWallet extends StatelessWidget {
  const ClientDashboardWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Wallet')),
      body: const Center(child: Text('Wallet Balance & History')),
    );
  }
}
