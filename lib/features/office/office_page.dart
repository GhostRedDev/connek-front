import 'package:flutter/material.dart';

class OfficePage extends StatelessWidget {
  const OfficePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Let shell background show
      body: const Center(child: Text('Office / Admin Dashboard', style: TextStyle(color: Colors.white))),
    );
  }
}
