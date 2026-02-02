import '../repositories/auth_repository.dart';

class SendOtp {
  final AuthRepository repository;

  SendOtp(this.repository);

  Future<void> call({
    required String phoneNumber,
    required void Function() onCodeSent,
    required void Function(String error) onError,
  }) {
    return repository.sendPhoneOtp(
      phoneNumber: phoneNumber,
      onCodeSent: onCodeSent,
      onError: onError,
    );
  }
}
