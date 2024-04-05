import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService() {
    _showPermissionRequest();
  }
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // void _showPermissionRequest() async {
  //   if (Platform.isAndroid) {
  //     flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //             AndroidFlutterLocalNotificationsPlugin>()!
  //         .requestNotificationsPermission();
  //   } else if (Platform.isIOS) {
  //     flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //             IOSFlutterLocalNotificationsPlugin>()!
  //         .requestPermissions(
  //           badge: true,
  //           alert: true,
  //           sound: true,
  //         );
  //   }
  // }
  void _showPermissionRequest() async {
    if (await Permission.notification.isDenied ||
        await Permission.notification.isLimited ||
        await Permission.notification.isPermanentlyDenied ||
        await Permission.notification.isProvisional ||
        await Permission.notification.isRestricted) {
      Permission.notification.request();
    }
    // await Permission.notification.isDenied.then((value) {
    //   if (value) {
    //     Permission.notification.request();
    //   }
    // });
  }
}
