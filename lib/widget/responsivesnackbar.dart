import 'package:flutter/material.dart';

class ResponsiveSnackbar {
  static show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        width:
            MediaQuery.of(context).size.width * 0.8, // adjust width as needed
        // margin: EdgeInsets.symmetric(
        //   horizontal: MediaQuery.of(context).size.width *
        //       0.1, // adjust horizontal margin as needed
        //   vertical: 16,
        // ),
      ),
    );
  }
}
