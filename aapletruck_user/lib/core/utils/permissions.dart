import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  AppPermissions._();

  /// Request location permission
  static Future<bool> requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  /// Check if location permission is already granted
  static Future<bool> isLocationGranted() async {
    return Permission.locationWhenInUse.isGranted;
  }

  /// Open app settings if permanently denied
  static Future<void> openSettingsIfDenied() async {
    if (await Permission.locationWhenInUse.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}
