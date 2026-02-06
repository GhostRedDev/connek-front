import 'package:flutter/material.dart';

class BusinessDashboardAddServices extends StatelessWidget {
  const BusinessDashboardAddServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Services')),
      body: const Center(child: Text('Add New Services')),
    );
  }
}
