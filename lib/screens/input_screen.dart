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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),

          const Text(
            'Currency Converter',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          // Card container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // USD
                TextField(
                  controller: usdController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'USD',
                    hintText: 'Enter USD amount',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                  convertUsdToCad(value);
                  setState(() {}); // rebuild UI
                },
                ),

                const SizedBox(height: 20),

                // CAD
                TextField(
                  controller: cadController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'CAD',
                    hintText: 'Enter CAD amount',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    convertCadToUsd(value);
                    setState(() {}); // rebuild UI
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: const Color(0xFF1E88E5),
            ),
            onPressed: isValidInput()
                ? () {
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
            child: const Text(
              'Go to Summary',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    ),
    );
  }
}