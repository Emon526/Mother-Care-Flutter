import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'const/consts.dart';
import 'const/theme.dart';
import 'firebase_options.dart';
import 'providers/breastcancerprovider.dart';
import 'providers/doctorprovider.dart';
import 'providers/languageprovider.dart';
import 'providers/pdfgenerateprovider.dart';
import 'providers/reminderprovider.dart';
import 'providers/selfcheckprovider.dart';
import 'screens/onboarding/onboarding.dart';
import 'services/apiservice.dart';
import 'services/notificationservice.dart';
import 'widget/persistent_nav_bar.dart';
import 'providers/modelprovider.dart';
import 'providers/nav_bar_provider.dart';
import 'providers/predictionprovider.dart';
import 'providers/themeprovider.dart';

void main() async {
  //add splash time
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
  ApiService.apirequest();
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
            create: (_) => ThemeProvider(context),
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
          ChangeNotifierProvider(
            create: (_) => PdfGenerateProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SelfCheckProvider(),
          ),
        ],
        builder: (context, child) {
          return Consumer<ThemeProvider>(builder: (context, value, child) {
            FlutterStatusbarcolor.setStatusBarColor(
              value.isDarkTheme
                  ? Colors.black
                  : Colors.white, // set status bar color based on the theme
            );
            FlutterStatusbarcolor.setStatusBarWhiteForeground(
              value.isDarkTheme, // set status bar icons based on the theme
            );
            FlutterStatusbarcolor.setNavigationBarColor(
              value.isDarkTheme
                  ? Colors.black
                  : Colors.white, // set status bar color based on the theme
            );
            FlutterStatusbarcolor.setNavigationBarWhiteForeground(
              value.isDarkTheme, // set status bar icons based on the theme
            );
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Consts.APP_NAME,
              locale: Locale(context.watch<LanguageProvider>().languageCode),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              theme: Styles.themeData(
                context: context,
                isDarkTheme: false,
              ),
              darkTheme: Styles.themeData(
                context: context,
                isDarkTheme: true,
              ),
              themeMode: context.watch<ThemeProvider>().themeMode,
              // home: const PersistentNavBar(),
              home: context.watch<LanguageProvider>().isBoardingCompleate
                  ? const PersistentNavBar()
                  : const OnBoardingScreen(),
              // home: const OnBoardingScreen(),
              // home: const MemmographyPrediction(),
              //   initialRoute: RouteManager.initialRoute,
              //   onGenerateRoute: RouteManager.generateRoute,
            );
          });
        });
  }
}
