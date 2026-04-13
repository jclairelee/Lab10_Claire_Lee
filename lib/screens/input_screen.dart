import 'package:flutter/material.dart';
import 'summary_screen.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Input'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to summary screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SummaryScreen(),
              ),
            );
          },
          child: const Text('Go to Summary'),
        ),
      ),
    );
  }
}