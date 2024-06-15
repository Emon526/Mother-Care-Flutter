import 'package:flutter/material.dart';

import '../const/consts.dart';

class ResponsiveSnackbar {
  static Future<void> show(BuildContext context, String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
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
