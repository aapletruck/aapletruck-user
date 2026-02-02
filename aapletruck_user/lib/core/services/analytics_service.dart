import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  AnalyticsService._();

  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Track screen view
  static Future<void> logScreen(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }

  /// Track login method
  static Future<void> logLogin(String method) async {
    await _analytics.logLogin(loginMethod: method);
  }

  /// Track OTP verification
  static Future<void> logOtpVerified({required bool success}) async {
    await _analytics.logEvent(
      name: 'otp_verification',
      parameters: {'success': success},
    );
  }

  /// Track button clicks
  static Future<void> logButtonClick(String name) async {
    await _analytics.logEvent(name: 'button_click', parameters: {'name': name});
  }
}
