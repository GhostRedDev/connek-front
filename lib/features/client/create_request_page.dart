import 'package:flutter/material.dart';

class CreateRequestPage extends StatelessWidget {
  const CreateRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Request')),
      body: const Center(child: Text('Create Booking Request')),
    );
  }
}
