import 'package:flutter/material.dart';

import 'screens/doctors/doctorslist.dart';
import 'screens/memmographyscreening/memmography.dart';
import 'widget/persistent_nav_bar.dart';

class RouteManager {
  static const String initialRoute = '/';
  static const String memmographyscreening = '/memmographyscreening';
  static const String doctors = '/doctors';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (context) => const PersistentNavBar(),
        );
      case memmographyscreening:
        return MaterialPageRoute(
          builder: (context) => const MemmographyPrediction(),
        );
      case doctors:
        return MaterialPageRoute(
          builder: (context) => const DoctorsList(),
        );
      default:
        throw const FormatException("Route Not Found");
    }
  }
}
