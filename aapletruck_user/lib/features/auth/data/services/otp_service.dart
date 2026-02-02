import 'package:firebase_auth/firebase_auth.dart';

class OtpService {
  OtpService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static String? _verificationId;

  /// Send OTP to phone
  static Future<void> sendPhoneOtp({
    required String phoneNumber,
    required void Function() onCodeSent,
    required void Function(String error) onError,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 30),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto verification (Android)
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        onError(e.message ?? 'OTP failed');
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        onCodeSent();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  /// Verify OTP manually
  static Future<bool> verifyOtp(String otp) async {
    try {
      if (_verificationId == null) return false;

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Clear OTP state (on resend)
  static void clear() {
    _verificationId = null;
  }
}
