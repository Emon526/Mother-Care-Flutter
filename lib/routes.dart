import 'package:flutter/material.dart';
import 'screens/doctors/doctorslist.dart';
import 'screens/reminder/reminder.dart';
import 'screens/reminder/reminderlist.dart';
import 'widget/persistent_nav_bar.dart';

class RouteManager {
  static const String initialRoute = '/';
  static const String memmographyscreening = '/memmographyscreening';
  static const String doctors = '/doctors';
  static const String reminderList = '/reminderList';
  static const String reminder = '/reminder';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(
          builder: (context) => const PersistentNavBar(),
        );
      case doctors:
        return MaterialPageRoute(
          builder: (context) => const DoctorsList(),
        );
      case reminderList:
        return MaterialPageRoute(
          builder: (context) => const ReminderList(),
        );
      case reminder:
        return MaterialPageRoute(
          builder: (context) => const Reminder(),
        );
      default:
        throw const FormatException("Route Not Found");
    }
  }
}
