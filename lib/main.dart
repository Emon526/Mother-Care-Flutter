import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'const/consts.dart';
import 'const/theme.dart';
import 'nav_bar.dart';
import 'providers/predictionprovider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PredictionProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Consts.APP_NAME,
        theme: Styles.themeData(
          context: context,
          isDarkTheme: false,
        ),
        themeMode: ThemeMode.system,
        // home: Splashscreen(),
        home: const NavBar(),
      ),
    );
  }
}
