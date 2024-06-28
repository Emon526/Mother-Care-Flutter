// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/utils.dart';

class PermissionService extends ChangeNotifier {
  final List<Permission> _permissions = [
    Permission.photos,
    Permission.notification
  ];
  Map<Permission, PermissionStatus> _permissionStatuses = {};

  PermissionStatus _photosStatus = PermissionStatus.denied;
  PermissionStatus get photosStatus => _photosStatus;

  set photosStatus(PermissionStatus status) {
    _photosStatus = status;
    notifyListeners();
  }

  PermissionStatus _notificationStatus = PermissionStatus.denied;
  PermissionStatus get notificationStatus => _notificationStatus;

  set notificationStatus(PermissionStatus status) {
    _notificationStatus = status;
    notifyListeners();
  }

  bool _isRequesting = false;

  Future<bool> initialize(BuildContext context) async {
    if (_isRequesting) return false;

    _isRequesting = true;

    // Request multiple permissions at once
    _permissionStatuses = await _permissions.request();

    _isRequesting = false;
    if (_permissionStatuses.containsValue(PermissionStatus.permanentlyDenied)) {
      showPermissionDeniedDialog(context);
    }
    return _permissionStatuses.values.every((status) => status.isGranted);
  }

  Future<PermissionStatus> hasPermission(Permission permission) async {
    PermissionStatus status = await permission.status;
    notifyListeners();
    return status;
  }

  void showPermissionDeniedDialog(BuildContext context) {
    Utils(context).showCustomDialog(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.permissionpermanentlydenied,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Utils(context).verticalSpace,
          Text(
            // 'The $permissionName permission is permanently denied. Please go to settings to enable it.'),
            AppLocalizations.of(context)!.permissionpermanentlydeniednote,
            textAlign: TextAlign.center,
          ),
          Utils(context).verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  AppLocalizations.of(context)!.cancelbutton,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await openAppSettings();
                  Navigator.of(context).pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.settings,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
