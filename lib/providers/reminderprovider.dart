import 'package:flutter/material.dart';

import '../models/remindermodel.dart';

class ReminderProvider extends ChangeNotifier {
  final List<ReminderModel> _reminders = [];
  List<ReminderModel> get reminders => _reminders;
  TimeOfDay _time = TimeOfDay.fromDateTime(
    DateTime.now().add(
      const Duration(minutes: 1),
    ),
  );
  TimeOfDay get time => _time;
  set time(TimeOfDay newtime) {
    _time = newtime;
    notifyListeners();
  }

  addReminder({required ReminderModel reminder}) {
    _reminders.add(reminder);
    notifyListeners();
  }

  deleteReminder({required int id}) {
    _reminders.removeWhere((element) => element.reminderId == id);
    notifyListeners();
  }
}
