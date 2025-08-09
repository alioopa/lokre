import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'books_list.dart';
import 'chat_room.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> _openedBooks = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('كتب وملازم الصف الثالث'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
            child: const _BannerCarousel(),
          ),
          ValueListenableBuilder<int>(
            valueListenable: _openedBooks,
            builder: (context, value, _) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('الكتب المفتوحة: $value'),
            ),
          ),
          Expanded(
            child: BooksList(
              onBookOpened: () => _openedBooks.value++,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton(
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
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const QuizScreen(),
                      ),
                    );
                  },
                  child: const Text('الاختبارات'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerCarousel extends StatefulWidget {
  const _BannerCarousel();

  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final List<String> _images = const [
    'https://via.placeholder.com/400x150.png?text=Banner+1',
    'https://via.placeholder.com/400x150.png?text=Banner+2',
    'https://via.placeholder.com/400x150.png?text=Banner+3',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;
      _currentPage = (_currentPage + 1) % _images.length;
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: _images.length,
      itemBuilder: (context, index) {
        return Image.network(_images[index], fit: BoxFit.cover);
      },
    );
  }
}
