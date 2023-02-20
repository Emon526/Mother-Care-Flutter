import 'package:flutter/material.dart';

import '../models/reminder.dart';

class ReminderProvider extends ChangeNotifier {
  final List<ReminderModel> _reminders = [];
  List<ReminderModel> get reminders => _reminders;
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay get time => _time;
  set time(TimeOfDay newtime) {
    _time = newtime;
    notifyListeners();
  }

  addReminder({required ReminderModel reminder}) {
    _reminders.add(reminder);
    notifyListeners();
  }
}
