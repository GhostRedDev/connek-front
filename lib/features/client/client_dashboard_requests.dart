import 'package:flutter/material.dart';

class ClientDashboardRequests extends StatelessWidget {
  const ClientDashboardRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Requests')),
      body: const Center(child: Text('Requests List')),
    );
  }
}
