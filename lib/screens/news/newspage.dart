import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(7.0),
          child: Text(
            "Hello!",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 30,
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
                Text(
                  "Help Support Women In Need",
                  style: TextStyle(
                    // color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "We provide help and inspire hope to those affected by breast cancer through early detection, education, and support services",
                  style: TextStyle(
                    // color: Colors.pink,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: const [
                Text(
                  "We Are Making Progress",
                  style: TextStyle(
                    // color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Breast cancer death rates declined 40% from 2018 to 2021 among women. The progress is attributed to improvements in early detection.",
                  style: TextStyle(
                    // color: Colors.pink,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
