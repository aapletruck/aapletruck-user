import 'package:aapletruck_user/di/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../domain/usecases/send_otp.dart';
import '../../domain/usecases/verify_otp.dart';
import '../../domain/usecases/sign_in_with_email.dart';
import '../../domain/usecases/save_user_name.dart';
import '../../domain/usecases/accept_terms.dart';

/// ===============================
/// AUTH STATE
/// ===============================
class AuthState {
  final bool isLoading;
  final UserEntity? user;
  final String? error;

  const AuthState({this.isLoading = false, this.user, this.error});

  factory AuthState.initial() {
    return const AuthState();
  }

  AuthState copyWith({bool? isLoading, UserEntity? user, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
    );
  }
}

/// ===============================
/// AUTH CONTROLLER
/// ===============================
class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthController(this._repository) : super(AuthState.initial());

  // ===============================
  // GOOGLE AUTH
  // ===============================

  Future<void> signInWithGoogle() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final user = await SignInWithGoogle(_repository).call();

      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // ===============================
  // PHONE OTP AUTH
  // ===============================

  Future<void> sendPhoneOtp({
    required String phoneNumber,
    required void Function() onCodeSent,
    required void Function(String error) onError,
  }) async {
    try {
      await SendOtp(_repository).call(
        phoneNumber: phoneNumber,
        onCodeSent: onCodeSent,
        onError: onError,
      );
    } catch (e) {
      onError(e.toString());
    }
  }

  Future<bool> verifyPhoneOtp(String otp) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final isVerified = await VerifyOtp(_repository).call(otp);

      state = state.copyWith(isLoading: false);

      if (!isVerified) {
        state = state.copyWith(error: 'Invalid OTP');
      }

      return isVerified;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  // ===============================
  // EMAIL AUTH
  // ===============================

  Future<void> sendEmailOtp({
    required String email,
    required String appUrl,
  }) async {
    try {
      await SignInWithEmail(_repository).send(email: email, appUrl: appUrl);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> verifyEmailOtp({
    required String email,
    required String link,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final user = await SignInWithEmail(
        _repository,
      ).verify(email: email, link: link);

      state = state.copyWith(isLoading: false, user: user);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // ===============================
  // PROFILE DATA
  // ===============================

  void saveUserName({required String firstName, String? lastName}) {
    final currentUser = state.user;
    if (currentUser == null) return;

    final updatedUser = SaveUserName().call(
      user: currentUser,
      firstName: firstName,
      lastName: lastName,
    );

    state = state.copyWith(user: updatedUser);
  }

  void acceptTerms() {
    final currentUser = state.user;
    if (currentUser == null) return;

    final updatedUser = AcceptTerms().call(currentUser);
    state = state.copyWith(user: updatedUser);
  }

  // ===============================
  // COMMON
  // ===============================

  Future<void> loadCurrentUser() async {
    final user = await _repository.getCurrentUser();
    state = state.copyWith(user: user);
  }

  Future<void> signOut() async {
    await _repository.signOut();
    state = AuthState.initial();
  }
}

/// ===============================
/// PROVIDER
/// ===============================
///
/// NOTE:
/// You must define `authRepositoryProvider`
/// in your dependency injection layer.
///
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>(
  (ref) {
    final repository = ref.read(authRepositoryProvider);
    return AuthController(repository);
  },
);
