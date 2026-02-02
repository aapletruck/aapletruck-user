import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthService {
  EmailAuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Send email sign-in link
  static Future<void> sendEmailLink({
    required String email,
    required String appUrl,
  }) async {
    final settings = ActionCodeSettings(
      url: appUrl,
      handleCodeInApp: true,
      androidPackageName: 'com.example.app',
      androidInstallApp: true,
      androidMinimumVersion: '1',
    );

    await _auth.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: settings,
    );
  }

  /// Verify email link
  static Future<UserCredential?> verifyEmailLink({
    required String email,
    required String link,
  }) async {
    if (_auth.isSignInWithEmailLink(link)) {
      return _auth.signInWithEmailLink(email: email, emailLink: link);
    }
    return null;
  }
}
