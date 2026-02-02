import 'package:flutter/material.dart';

import '../features/auth/presentation/screens/get_started_screen.dart';
import '../features/auth/presentation/screens/phone_input_screen.dart';
import '../features/auth/presentation/screens/otp_verification_screen.dart';
import '../features/auth/presentation/screens/email_input_screen.dart';
import '../features/auth/presentation/screens/name_input_screen.dart';
import '../features/auth/presentation/screens/terms_screen.dart';
import '../features/auth/presentation/screens/all_set_screen.dart';
import '../features/auth/presentation/screens/location_permission_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';
import 'route_names.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.getStarted:
        return _page(const GetStartedScreen());

      case RouteNames.phoneInput:
        return _page(const PhoneInputScreen());

      case RouteNames.otpVerification:
        final args = settings.arguments as Map<String, dynamic>?;
        return _page(
          OtpVerificationScreen(
            contact: args?['contact'] ?? '',
            isEmail: args?['isEmail'] ?? false,
          ),
        );

      case RouteNames.emailInput:
        return _page(const EmailInputScreen());

      case RouteNames.nameInput:
        return _page(const NameInputScreen());

      case RouteNames.terms:
        return _page(const TermsScreen());

      case RouteNames.allSet:
        return _page(const AllSetScreen());

      case RouteNames.locationPermission:
        return _page(const LocationPermissionScreen());

      case RouteNames.home:
        return _page(const HomeScreen());

      default:
        return _page(
          const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }

  static PageRoute _page(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }
}
