import '../entities/user_entity.dart';

abstract class AuthRepository {
  // =========================
  // GOOGLE AUTH
  // =========================

  /// Sign in using Google
  /// Returns [UserEntity] on success, null if cancelled
  Future<UserEntity?> signInWithGoogle();

  // =========================
  // PHONE OTP AUTH
  // =========================

  /// Send OTP to phone number
  Future<void> sendPhoneOtp({
    required String phoneNumber,
    required void Function() onCodeSent,
    required void Function(String error) onError,
  });

  /// Verify phone OTP
  /// Returns true if verification succeeds
  Future<bool> verifyPhoneOtp(String otp);

  // =========================
  // EMAIL AUTH
  // =========================

  /// Send OTP / link to email
  Future<void> sendEmailOtp({required String email, required String appUrl});

  /// Verify email OTP / link
  Future<UserEntity?> verifyEmailOtp({
    required String email,
    required String link,
  });

  // =========================
  // COMMON
  // =========================

  /// Get currently logged-in user
  Future<UserEntity?> getCurrentUser();

  /// Logout
  Future<void> signOut();
}
