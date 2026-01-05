import 'package:flutter/material.dart';

class OfficePage extends StatelessWidget {
  const OfficePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Office')),
      body: const Center(child: Text('Office / Admin Dashboard')),
    );
  }
}
