import 'package:flutter/material.dart';

class ClientDashboardPost extends StatelessWidget {
  const ClientDashboardPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Post')),
      body: const Center(child: Text('Create a Post')),
    );
  }
}
