import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'const/consts.dart';
import 'const/theme.dart';
import 'firebase_options.dart';
import 'providers/authprovider.dart';
import 'providers/breastcancerprovider.dart';
import 'providers/doctorprovider.dart';
import 'providers/languageprovider.dart';
import 'providers/reminderprovider.dart';
import 'providers/selfcheckprovider.dart';
import 'screens/auth/auth.dart';
import 'screens/onboarding/onboarding.dart';
import 'screens/selfcheck/self_check_steps.dart';
import 'services/apiservice.dart';
import 'services/notificationservice.dart';
import 'providers/modelprovider.dart';
import 'providers/nav_bar_provider.dart';
import 'providers/themeprovider.dart';
import 'services/permissionservice.dart';

// TODO: implement dispose to whole project
final navigatorKey = GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  tz.initializeTimeZones();

  ApiService.apirequest();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await NotificationService().initNotification();

  await Future.delayed(const Duration(seconds: 3), () {
    FlutterNativeSplash.remove();
    debugPrint('remove splash');
  });

  //  handle notification tap in terminated state
  var initialNotification =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (initialNotification?.didNotificationLaunchApp == true) {
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => const SelfCheckSteps(),
        ),
      );
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    listenToNotifications();
  }

// handle notification tap in active state
  void listenToNotifications() {
    debugPrint('Listening to notification');
    NotificationService.onClickNotification.stream.listen((event) {
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (context) => const SelfCheckSteps(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(context),
          ),
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PermissionService(),
          ),
          ChangeNotifierProvider(
            create: (_) => AuthrizationProviders(),
          ),
          ChangeNotifierProvider(
            create: (_) => NavBarProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => BreastCancerProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SelfCheckProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => DoctorProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ModelProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ReminderProvider(),
          ),
        ],
        builder: (context, child) {
          return Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
            return MaterialApp(
              navigatorKey: navigatorKey,
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
              home: context.watch<LanguageProvider>().isBoardingCompleate
                  ? const Auth()
                  : const OnBoardingScreen(),
            );
          });
        });
  }
}
