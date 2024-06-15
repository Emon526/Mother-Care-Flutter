import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import '../models/remindermodel.dart';
import '../services/notificationservice.dart';
import '../utils/utils.dart';

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

  Time _time = Time(
    hour: DateTime.now().hour,
    minute: DateTime.now().minute,
  );
  Time get time => _time;
  set time(Time newtime) {
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

  String getDuration(
      {required DateTime reminderDate,
      required String local,
      required BuildContext context}) {
    List<String> durationParts =
        reminderDate.difference(DateTime.now()).toString().split(':');

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

    String formattedDuration = '${Utils(context).checkEmpty(
      duration: days,
      days: AppLocalizations.of(context)!.days,
    )}${Utils(context).checkEmpty(
      duration: hoursRemainder,
      days: AppLocalizations.of(context)!.hours,
    )}${Utils(context).checkEmpty(
      duration: minutesRemainder,
      days: AppLocalizations.of(context)!.minutes,
    )}${Utils(context).checkEmpty(
      duration: secondsRemainder,
      days: AppLocalizations.of(context)!.seconds,
    )}';

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
        reminderTitle: notification.body ?? '',
        reminderDateTime: DateTime.parse(notification.payload ?? ''),
      );
    }).toList();
    notifyListeners();
  }
}
