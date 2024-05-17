import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<void> showPermissionRequest(BuildContext context) async {
    await _requestPermissions(context);
  }

  Future<void> _requestPermissions(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.notification,
    ].request();

    _handlePermissionStatus(
        context, statuses[Permission.photos], 'Media Library');
    _handlePermissionStatus(
        context, statuses[Permission.notification], 'Notification');
  }

  void _handlePermissionStatus(
      BuildContext context, PermissionStatus? status, String permissionName) {
    if (status == PermissionStatus.permanentlyDenied) {
      _showPermissionDeniedDialog(context, permissionName);
    }
  }

  void _showPermissionDeniedDialog(
      BuildContext context, String permissionName) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('$permissionName Permission'),
        content: Text(
            'The $permissionName permission is permanently denied. Please go to settings to enable it.'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Settings'),
            onPressed: () {
              openAppSettings();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
