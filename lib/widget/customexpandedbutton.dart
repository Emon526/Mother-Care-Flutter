import 'package:flutter/material.dart';

class CustomExpanedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomExpanedButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            // textAlign: TextAlign.center,
            // style: const TextStyle(
            //   fontWeight: FontWeight.bold,
            // ),
          ),
        ),
      ),
    );
  }
}
