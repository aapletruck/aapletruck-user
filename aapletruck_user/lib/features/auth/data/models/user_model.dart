import '../../domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String? email;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isTermsAccepted;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.isTermsAccepted,
    required this.createdAt,
  });

  /// ---------- FACTORY: FROM API / FIREBASE ----------
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      isEmailVerified: json['is_email_verified'] ?? false,
      isPhoneVerified: json['is_phone_verified'] ?? false,
      isTermsAccepted: json['is_terms_accepted'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  /// ---------- TO API ----------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'first_name': firstName,
      'last_name': lastName,
      'is_email_verified': isEmailVerified,
      'is_phone_verified': isPhoneVerified,
      'is_terms_accepted': isTermsAccepted,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// ---------- COPY WITH (IMMUTABLE UPDATES) ----------
  UserModel copyWith({
    String? id,
    String? email,
    String? phone,
    String? firstName,
    String? lastName,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    bool? isTermsAccepted,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// ---------- DATA → DOMAIN ----------
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      phone: phone,
      firstName: firstName,
      lastName: lastName,
      isEmailVerified: isEmailVerified,
      isPhoneVerified: isPhoneVerified,
      isTermsAccepted: isTermsAccepted,
    );
  }
}
