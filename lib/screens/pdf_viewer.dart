import 'package:flutter/material.dart';

class PdfViewerScreen extends StatelessWidget {
  const PdfViewerScreen({super.key, required this.url, required this.tag});

  final String url;
  final Object tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('عرض الكتاب')),
      body: Center(
        child: Hero(
          tag: tag,
          child: Text('عرض PDF من: \$url'),
        ),
      ),
    );
  }
}
