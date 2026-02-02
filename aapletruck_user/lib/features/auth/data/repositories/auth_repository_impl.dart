import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../services/firebase_auth_service.dart';
import '../services/google_auth_service.dart';
import '../services/otp_service.dart';
import '../services/email_auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl();

  // =========================
  // GOOGLE AUTH
  // =========================

  @override
  Future<UserEntity?> signInWithGoogle() async {
    final credential = await GoogleAuthService.signInWithGoogle();
    if (credential == null) return null;

    final user = credential.user;
    if (user == null) return null;

    final model = UserModel(
      id: user.uid,
      email: user.email,
      phone: user.phoneNumber,
      firstName: user.displayName?.split(' ').first,
      lastName: user.displayName?.split(' ').skip(1).join(' '),
      isEmailVerified: user.emailVerified,
      isPhoneVerified: user.phoneNumber != null,
      isTermsAccepted: false,
      createdAt: DateTime.now(),
    );

    return model.toEntity();
  }

  // =========================
  // PHONE OTP
  // =========================

  @override
  Future<void> sendPhoneOtp({
    required String phoneNumber,
    required void Function() onCodeSent,
    required void Function(String error) onError,
  }) async {
    await OtpService.sendPhoneOtp(
      phoneNumber: phoneNumber,
      onCodeSent: onCodeSent,
      onError: onError,
    );
  }

  @override
  Future<bool> verifyPhoneOtp(String otp) async {
    return OtpService.verifyOtp(otp);
  }

  // =========================
  // EMAIL AUTH (OTP / LINK)
  // =========================

  @override
  Future<void> sendEmailOtp({
    required String email,
    required String appUrl,
  }) async {
    await EmailAuthService.sendEmailLink(email: email, appUrl: appUrl);
  }

  @override
  Future<UserEntity?> verifyEmailOtp({
    required String email,
    required String link,
  }) async {
    final credential = await EmailAuthService.verifyEmailLink(
      email: email,
      link: link,
    );

    final user = credential?.user;
    if (user == null) return null;

    final model = UserModel(
      id: user.uid,
      email: user.email,
      phone: user.phoneNumber,
      firstName: null,
      lastName: null,
      isEmailVerified: user.emailVerified,
      isPhoneVerified: false,
      isTermsAccepted: false,
      createdAt: DateTime.now(),
    );

    return model.toEntity();
  }

  // =========================
  // COMMON
  // =========================

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = FirebaseAuthService.currentUser;
    if (user == null) return null;

    return UserModel(
      id: user.uid,
      email: user.email,
      phone: user.phoneNumber,
      firstName: user.displayName?.split(' ').first,
      lastName: user.displayName?.split(' ').skip(1).join(' '),
      isEmailVerified: user.emailVerified,
      isPhoneVerified: user.phoneNumber != null,
      isTermsAccepted: false,
      createdAt: DateTime.now(),
    ).toEntity();
  }

  @override
  Future<void> signOut() async {
    await GoogleAuthService.signOut();
    await FirebaseAuthService.signOut();
  }
}
