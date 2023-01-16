// import 'package:flutter/material.dart';
// import 'package:splashscreen/splashscreen.dart';

// import '../home_screen.dart';
// import '../utils/shared.dart';

// class Splashscreen extends StatefulWidget {
//   @override
//   _SplashscreenState createState() => _SplashscreenState();
// }

// class _SplashscreenState extends State<Splashscreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SplashScreen(
//       loaderColor: Colors.redAccent.shade400,
//       title: Text(
//         Shared.appName,
//         style: TextStyle(
//           fontSize: 30,
//           fontWeight: FontWeight.bold,
//           color: Colors.redAccent.shade400,
//         ),
//         textAlign: TextAlign.center,
//       ),
//       backgroundColor: Colors.white,
//       loadingText: Text('Loading...'),
//       navigateAfterSeconds: HomeScreen(),
//       seconds: 1,
//     );
//   }
// }
