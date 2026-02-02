import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuthService._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Current Firebase user
  static User? get currentUser => _auth.currentUser;

  /// Sign out
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Delete account (use carefully)
  static Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.delete();
    }
  }
}
