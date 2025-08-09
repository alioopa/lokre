import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<_Question> _questions = const [
    _Question(
      text: 'كم عدد الكواكب في المجموعة الشمسية؟',
      options: ['7', '8', '9', '10'],
      answerIndex: 1,
    ),
    _Question(
      text: 'ما نتيجة 5 × 3؟',
      options: ['8', '15', '20', '25'],
      answerIndex: 1,
    ),
  ];

  int _current = 0;
  int _score = 0;

  void _answer(int index) {
    if (_questions[_current].answerIndex == index) {
      _score++;
    }
    if (_current < _questions.length - 1) {
      setState(() => _current++);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('النتيجة'),
          content: Text('حصلت على $_score من ${_questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('حسناً'),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_current];
    return Scaffold(
      appBar: AppBar(title: const Text('الاختبارات')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('السؤال ${_current + 1}/${_questions.length}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(q.text),
            const SizedBox(height: 20),
            ...List.generate(q.options.length, (i) {
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => _answer(i),
                  child: Text(q.options[i]),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class _Question {
  final String text;
  final List<String> options;
  final int answerIndex;

  const _Question({
    required this.text,
    required this.options,
    required this.answerIndex,
  });
}
