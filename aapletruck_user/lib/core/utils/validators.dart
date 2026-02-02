class Validators {
  Validators._();

  /// Email validation
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email.trim());
  }

  /// Indian mobile number validation (10 digits)
  static bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^[6-9]\d{9}$');
    return phoneRegex.hasMatch(phone.trim());
  }

  /// OTP validation (exact length)
  static bool isValidOtp(String otp, {int length = 4}) {
    return otp.length == length && int.tryParse(otp) != null;
  }

  /// Name validation (used for first name / last name)
  static bool isValidName(String name) {
    return name.trim().length >= 2;
  }
}
