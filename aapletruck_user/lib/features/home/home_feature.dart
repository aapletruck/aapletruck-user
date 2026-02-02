import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/presentation/controllers/auth_controller.dart';

/// =======================================================
/// HOME FEATURE – DEPENDENCY & STATE WIRING
/// =======================================================
///
/// Purpose of this file:
/// - Acts as the SINGLE entry point for Home feature wiring
/// - Keeps Home logic isolated from App/Auth wiring
/// - Makes future expansion safe and predictable
///
/// This file intentionally contains:
/// - HomeState
/// - HomeController (lightweight)
/// - Providers
///
/// Home feature currently depends on:
/// - AuthController (to read user & auth status)
///
/// Later it may depend on:
/// - HomeRepository
/// - MapService
/// - BookingService
/// =======================================================

/// ===============================
/// HOME STATE
/// ===============================
///
/// Lightweight state for Home screen.
/// Do NOT duplicate AuthState here.
///
class HomeState {
  final bool isLoading;
  final String? error;

  const HomeState({this.isLoading = false, this.error});

  HomeState copyWith({bool? isLoading, String? error}) {
    return HomeState(isLoading: isLoading ?? this.isLoading, error: error);
  }

  factory HomeState.initial() => const HomeState();
}

/// ===============================
/// HOME CONTROLLER
/// ===============================
///
/// NOTE:
/// - HomeController does NOT own User data
/// - User always comes from AuthController
/// - This prevents state duplication bugs
///
class HomeController extends StateNotifier<HomeState> {
  final Ref ref;

  HomeController(this.ref) : super(HomeState.initial());

  /// Example future action
  /// (API call / map load / dashboard data)
  Future<void> loadHomeData() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      // TODO:
      // final user = ref.read(authControllerProvider).user;
      // Call HomeRepository using user.id

      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Logout proxy (delegates to AuthController)
  Future<void> logout() async {
    await ref.read(authControllerProvider.notifier).signOut();
  }
}

/// ===============================
/// HOME CONTROLLER PROVIDER
/// ===============================
///
/// UI will use this to:
/// - trigger Home actions
/// - read Home-specific loading/error
///
final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>(
  (ref) {
    return HomeController(ref);
  },
);

/// ===============================
/// HOME FEATURE PROVIDER
/// ===============================
///
/// This provider exists for:
/// - Feature boundary clarity
/// - Future repository/service injection
/// - Consistency across features
///
/// Currently no external dependencies,
/// so it simply exists as a feature marker.
///
final homeFeatureProvider = Provider<void>((ref) {
  // Reserved for future Home dependencies
});
