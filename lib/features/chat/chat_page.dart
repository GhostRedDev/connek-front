import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String chatId;
  const ChatPage({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    // Scaffold/AppBar handled by AppLayout
    return Center(
      child: Text(
        'Chat ID: $chatId',
        style: TextStyle(
          fontSize: 18,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
    );
  }
}
