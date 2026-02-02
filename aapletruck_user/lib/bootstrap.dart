import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'features/auth/presentation/controllers/auth_controller.dart';

/// =======================================================
/// BOOTSTRAP
/// =======================================================
///
/// Responsibilities:
/// - Initialize app-level services
/// - Load current user
/// - Decide initial navigation
///
/// main.dart should ONLY call bootstrap()
/// =======================================================

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();

  try {
    // Load user if already logged in
    await container.read(authControllerProvider.notifier).loadCurrentUser();
  } catch (_) {
    // Silent fail — app can still start
  }

  runApp(UncontrolledProviderScope(container: container, child: const App()));
}
