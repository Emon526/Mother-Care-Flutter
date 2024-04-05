import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

import '../const/consts.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

// on tap on any notification
  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

  Future<void> initNotification() async {
    AndroidInitializationSettings settingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings settingsIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // onDidReceiveLocalNotification: (id, title, body, payload) {
      //   log(payload!, name: 'initializationSettingsIos');
      // },
    );
    var initializationSettings = InitializationSettings(
      android: settingsAndroid,
      iOS: settingsIos,
    );
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  Future deleteScheduleNotification({
    required int id,
  }) async {
    return notificationsPlugin.cancel(id);
  }

  Future showScheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduleDateTime,
    required String payload,
  }) async {
    return notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        scheduleDateTime,
        tz.local,
      ),
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        Consts.APPID,
        Consts.APP_NAME,
        channelDescription: 'reminders',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        //use action to add buttons
      ),
      iOS: DarwinNotificationDetails(),
    );
  }
}
