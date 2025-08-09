import 'package:flutter/material.dart';
import 'books_list.dart';
import 'chat_room.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('كتب وملازم الصف الثالث')),
      body: Column(
        children: [
          Expanded(child: BooksList()),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChatRoom(roomId: 'general'),
                  ),
                );
              },
              child: const Text('الدردشة الجماعية'),
            ),
          ),
        ],
      ),
    );
  }
}
