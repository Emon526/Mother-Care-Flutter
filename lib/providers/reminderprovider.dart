import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/remindermodel.dart';
import '../services/notificationservice.dart';

class ReminderProvider extends ChangeNotifier {
  ReminderProvider() {
    getPendingReminders();
  }
  List<ReminderModel> _reminders = [];
  List<ReminderModel> get reminders => _reminders;
  DateTime _seletedDate = DateTime.now();
  DateTime get seletedDate => _seletedDate;
  set seletedDate(DateTime dateTime) {
    _seletedDate = dateTime;
    notifyListeners();
  }

  DateTime _reminderDate = DateTime.now();
  DateTime get reminderDate => _reminderDate;
  set reminderDate(DateTime reminderDate) {
    _reminderDate = reminderDate;
    notifyListeners();
  }

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

  String getDuration() {
    List<String> durationParts =
        _reminderDate.difference(DateTime.now()).toString().split(':');

    int hours = int.parse(durationParts[0]);
    int minutes = int.parse(durationParts[1]);
    double seconds = double.parse(durationParts[2]);

    Duration duration = Duration(
        hours: hours,
        minutes: minutes,
        seconds: seconds.floor(),
        milliseconds: ((seconds - seconds.floor()) * 1000).floor());

    int days = duration.inDays;
    int hoursRemainder = duration.inHours % 24;
    int minutesRemainder = duration.inMinutes % 60;
    int secondsRemainder = duration.inSeconds % 60;

    String formattedDuration =
        '$days days $hoursRemainder hours $minutesRemainder minutes $secondsRemainder seconds';

    return formattedDuration;
  }

  Future<void> getPendingReminders() async {
    var pendingNotifications = await NotificationService()
        .notificationsPlugin
        .pendingNotificationRequests();
    _reminders = pendingNotifications.map((notification) {
      debugPrint(notification.payload.toString());
      return ReminderModel(
        reminderId: notification.id,
        reminderTitle: notification.title ?? '',
        reminderDate: DateFormat('EEE, dd MMMM yyyy')
            .format(DateTime.parse(notification.payload ?? '')),
        reminderTime: DateFormat("h:mma")
            .format(DateTime.parse(notification.payload ?? '')),
      );
    }).toList();
    debugPrint(reminders.length.toString());
    notifyListeners();
  }
}
