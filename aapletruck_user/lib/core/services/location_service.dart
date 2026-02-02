import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  LocationService._();

  /// Request location permission
  static Future<bool> requestPermission() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  /// Check if permission already granted
  static Future<bool> hasPermission() async {
    return Permission.locationWhenInUse.isGranted;
  }

  /// Get current position (safe call)
  static Future<Position?> getCurrentLocation() async {
    final hasPermission = await LocationService.hasPermission();
    if (!hasPermission) return null;

    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) return null;

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /// Open settings if permanently denied
  static Future<void> openAppSettingsIfNeeded() async {
    if (await Permission.locationWhenInUse.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}
