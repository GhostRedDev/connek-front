import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold/AppBar handled by AppLayout
    return Center(
      child: Text(
        'User Settings',
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }
}
