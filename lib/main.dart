import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'const/consts.dart';
import 'const/theme.dart';
import 'firebase_options.dart';
import 'nav_bar.dart';
import 'providers/modelprovider.dart';
import 'providers/predictionprovider.dart';
import 'providers/themeprovider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ModelProvider(),
        ),
      ],
      builder: (context, child) => Consumer<ThemeProvider>(
        builder: (context, value, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Consts.APP_NAME,
          theme: Styles.themeData(
            context: context,
            isDarkTheme: false,
          ),
          darkTheme: Styles.themeData(
            context: context,
            isDarkTheme: true,
          ),
          themeMode: context.watch<ThemeProvider>().themeMode,
          // home: Splashscreen(),
          home: const NavBar(),
        ),
      ),
    );
  }
}
