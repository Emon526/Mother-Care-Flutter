import 'package:flutter/material.dart';

class SymptomPrediction extends StatelessWidget {
  const SymptomPrediction({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Please discribe the symptom to get prediction result',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
