import '../repositories/auth_repository.dart';

class VerifyOtp {
  final AuthRepository repository;

  VerifyOtp(this.repository);

  Future<bool> call(String otp) {
    return repository.verifyPhoneOtp(otp);
  }
}
