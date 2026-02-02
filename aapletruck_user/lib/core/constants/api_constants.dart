class ApiConstants {
  ApiConstants._();

  // Base URLs
  static const String baseUrl = 'https://api.example.com';

  // Auth
  static const String sendOtp = '/auth/send-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String googleLogin = '/auth/google';
  static const String emailLogin = '/auth/email';

  // Headers
  static const String contentType = 'application/json';
  static const String authorization = 'Authorization';
}
