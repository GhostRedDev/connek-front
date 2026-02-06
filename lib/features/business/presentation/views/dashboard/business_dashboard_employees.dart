import 'package:flutter/material.dart';

class BusinessDashboardEmployees extends StatelessWidget {
  const BusinessDashboardEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employees')),
      body: const Center(child: Text('Employee Management')),
    );
  }
}
