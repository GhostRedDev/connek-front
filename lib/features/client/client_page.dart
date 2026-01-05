import 'package:flutter/material.dart';

class ClientPage extends StatelessWidget {
  final String clientId;
  const ClientPage({super.key, required this.clientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Client Details')),
      body: Center(child: Text('Client ID: $clientId')),
    );
  }
}
