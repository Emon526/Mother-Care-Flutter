import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  PermissionService() {
    _showPermissionRequest();
  }
  void _showPermissionRequest() async {
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }
}
