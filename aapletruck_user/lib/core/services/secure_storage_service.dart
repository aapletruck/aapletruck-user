import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // Keys
  static const String _keyAuthToken = 'auth_token';
  static const String _keyUserId = 'user_id';
  static const String _keyIsLoggedIn = 'is_logged_in';

  /// Save auth token
  static Future<void> saveAuthToken(String token) async {
    await _storage.write(key: _keyAuthToken, value: token);
  }

  /// Get auth token
  static Future<String?> getAuthToken() async {
    return _storage.read(key: _keyAuthToken);
  }

  /// Save user ID
  static Future<void> saveUserId(String userId) async {
    await _storage.write(key: _keyUserId, value: userId);
  }

  /// Get user ID
  static Future<String?> getUserId() async {
    return _storage.read(key: _keyUserId);
  }

  /// Save login state
  static Future<void> setLoggedIn(bool value) async {
    await _storage.write(key: _keyIsLoggedIn, value: value.toString());
  }

  /// Check login state
  static Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: _keyIsLoggedIn);
    return value == 'true';
  }

  /// Clear all secure data (logout)
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
