class UserEntity {
  final String id;
  final String? email;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isTermsAccepted;

  const UserEntity({
    required this.id,
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.isTermsAccepted,
  });

  /// Full name (safe for UI)
  String get fullName {
    if (firstName == null && lastName == null) return '';
    return '${firstName ?? ''} ${lastName ?? ''}'.trim();
  }

  /// Whether profile is minimally complete
  bool get isProfileComplete {
    return firstName != null && firstName!.isNotEmpty && isTermsAccepted;
  }

  /// Copy with updated values (immutable)
  UserEntity copyWith({
    String? id,
    String? email,
    String? phone,
    String? firstName,
    String? lastName,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    bool? isTermsAccepted,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
    );
  }
}
