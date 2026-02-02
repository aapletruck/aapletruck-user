import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'routes/route_names.dart';

import 'features/auth/presentation/controllers/auth_controller.dart';
import 'features/auth/presentation/screens/get_started_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // ===============================
      // LOCALIZATION SETUP
      // ===============================
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        // Future:
        // Locale('hi'),
        // Locale('mr'),
      ],

      // ===============================
      // ROUTING
      // ===============================
      onGenerateRoute: AppRoutes.generateRoute,

      // ===============================
      // AUTH ↔ HOME DECISION
      // ===============================
      home: _buildHome(authState),
    );
  }

  /// ===============================
  /// DECIDE INITIAL SCREEN
  /// ===============================
  Widget _buildHome(AuthState authState) {
    // While bootstrap is loading user
    if (authState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // If user is logged in → Home
    if (authState.user != null) {
      return const HomeScreen();
    }

    // Else → Auth entry
    return const GetStartedScreen();
  }
}
