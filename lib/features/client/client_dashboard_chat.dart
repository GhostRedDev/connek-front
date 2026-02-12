import 'package:flutter/material.dart';

class ClientDashboardChat extends StatelessWidget {
  const ClientDashboardChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support Chat')),
      body: const Center(child: Text('Chat with Support/Business')),
    );
  }
}
