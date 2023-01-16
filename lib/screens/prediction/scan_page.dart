import 'package:flutter/material.dart';

import 'memmography.dart';
import 'symptom.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'You can get a prediction result by scaning your memmography or analysis the symptoms',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18.0,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MemmographyPrediction(),
              ),
            );
          },
          child: const Text('Memmography Predition'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SymptomPrediction(),
              ),
            );
          },
          child: const Text('Symptom Predition'),
        ),
      ],
    );
  }
}
