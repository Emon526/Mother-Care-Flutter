import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mothercare/providers/breastcancerprovider.dart';
import 'package:mothercare/screens/doctors/doctorslist.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'const/consts.dart';
import 'const/theme.dart';
import 'firebase_options.dart';
import 'providers/doctorprovider.dart';
import 'providers/reminderprovider.dart';
import 'services/notificationservice.dart';
import 'widget/persistent_nav_bar.dart';
import 'providers/modelprovider.dart';
import 'providers/nav_bar_provider.dart';
import 'providers/predictionprovider.dart';
import 'providers/themeprovider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  tz.initializeTimeZones();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await NotificationService().initNotification();
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
        ChangeNotifierProvider(
          create: (_) => NavBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ReminderProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DoctorProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BreastCancerProvider(),
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
          home: const PersistentNavBar(),
          // home: const DoctorsList(),
          //   initialRoute: RouteManager.initialRoute,
          //   onGenerateRoute: RouteManager.generateRoute,
        ),
      ),
    );
  }
}
