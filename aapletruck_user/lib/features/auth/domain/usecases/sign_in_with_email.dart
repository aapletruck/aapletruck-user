import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmail {
  final AuthRepository repository;

  SignInWithEmail(this.repository);

  /// Step 1: Send email OTP / link
  Future<void> send({required String email, required String appUrl}) {
    return repository.sendEmailOtp(email: email, appUrl: appUrl);
  }

  /// Step 2: Verify email OTP / link
  Future<UserEntity?> verify({required String email, required String link}) {
    return repository.verifyEmailOtp(email: email, link: link);
  }
}
