import 'package:flutter/material.dart';

class BusinessDashboardServices extends StatelessWidget {
  const BusinessDashboardServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Services Dashboard')),
      body: const Center(child: Text('Manage Services')),
    );
  }
}
