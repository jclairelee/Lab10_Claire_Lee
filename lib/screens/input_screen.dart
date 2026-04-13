import 'package:flutter/material.dart';
import 'summary_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  // Controllers for input fields
  final TextEditingController usdController = TextEditingController();
  final TextEditingController cadController = TextEditingController();

  // Static exchange rate
  final double exchangeRate = 1.35;

  // Prevent infinite loop
  bool isUpdating = false;

  @override
  void dispose() {
    usdController.dispose();
    cadController.dispose();
    super.dispose();
  }

  void convertUsdToCad(String value) {
    if (isUpdating) return;

    isUpdating = true;

    double? usd = double.tryParse(value);

    if (usd != null) {
      double cad = usd * exchangeRate;
      cadController.text = cad.toStringAsFixed(2);
    } else {
      cadController.clear();
    }

    isUpdating = false;
  }

  void convertCadToUsd(String value) {
    if (isUpdating) return;

    isUpdating = true;

    double? cad = double.tryParse(value);

    if (cad != null) {
      double usd = cad / exchangeRate;
      usdController.text = usd.toStringAsFixed(2);
    } else {
      usdController.clear();
    }

    isUpdating = false;
  }

  // Check if inputs are valid
  bool isValidInput() {
    final usd = double.tryParse(usdController.text);
    final cad = double.tryParse(cadController.text);

    return usd != null || cad != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // USD input
            TextField(
              controller: usdController,
             keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'USD',
                hintText: 'Enter amount in USD',
                border: OutlineInputBorder(),
              ),
            onChanged: (value) {
              convertUsdToCad(value);
              setState(() {}); // trigger rebuild
            },
            ),

            const SizedBox(height: 20),

            // CAD input
            TextField(
              controller: cadController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'CAD',
                hintText: 'Enter amount in CAD',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
              convertCadToUsd(value);
              setState(() {}); // trigger rebuild
            },
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: isValidInput() ? () {
                // Navigate with values
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SummaryScreen(
                      usd: usdController.text,
                      cad: cadController.text,
                      rate: exchangeRate,
                    ),
                  ),
                );
              }
              : null,
              child: const Text('Go to Summary'),
            ),
          ],
        ),
      ),
    );
  }
}