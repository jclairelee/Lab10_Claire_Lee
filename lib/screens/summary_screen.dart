import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget {
  final String usd;
  final String cad;
  final double rate;

  const SummaryScreen({
    super.key,
    required this.usd,
    required this.cad,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversion Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('USD: $usd'),
            Text('CAD: $cad'),
            Text('Rate: 1 USD = $rate CAD'),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}