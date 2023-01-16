import 'package:flutter/material.dart';

import 'const/consts.dart';
import 'const/theme.dart';
import 'nav_bar.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Consts.APP_NAME,
      theme: Styles.themeData(
        context: context,
        isDarkTheme: false,
      ),
      themeMode: ThemeMode.system,
      // home: Splashscreen(),
      home: const NavBar(),
    );
  }
}
