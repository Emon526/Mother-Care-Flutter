import 'package:flutter/material.dart';

class PredictionResult extends StatelessWidget {
  const PredictionResult({super.key, required this.outputs});
  final List? outputs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Result: ${outputs![0]["label"]}\nAccuracy: ${(outputs![0]["confidence"] * 100).toStringAsFixed(1)}%",
          style: const TextStyle(
            // color: Colors.black,
            fontSize: 20.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
