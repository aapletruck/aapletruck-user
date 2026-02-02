import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/divider_with_text.dart';
import '../../../../routes/route_names.dart';
import '../controllers/auth_controller.dart';

class GetStartedScreen extends ConsumerStatefulWidget {
  const GetStartedScreen({super.key});

  @override
  ConsumerState<GetStartedScreen> createState() =>
      _GetStartedScreenState();
}

class _GetStartedScreenState
    extends ConsumerState<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return AppScaffold(
      showBack: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),

          Text(
            "Let’s get started",
            style: Theme.of(context).textTheme.headlineLarge,
          ),

          const SizedBox(height: 32),

          /// ===============================
          /// CONTINUE WITH GOOGLE
          /// ===============================
          PrimaryButton(
            text: "Continue with Google",
            isLoading: authState.isLoading,
            onPressed: () async {
              final controller =
              ref.read(authControllerProvider.notifier);

              await controller.signInWithGoogle();

              if (!mounted) return;

              final user =
                  ref.read(authControllerProvider).user;

              if (user != null) {
                Navigator.pushNamed(
                  context,
                  RouteNames.terms,
                );
              }
            },
          ),

          const SizedBox(height: 16),

          const DividerWithText(text: "OR"),

          const SizedBox(height: 16),

          /// ===============================
          /// CONTINUE WITH MOBILE
          /// ===============================
          PrimaryButton(
            text: "Continue with Mobile",
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteNames.phoneInput,
              );
            },
          ),

          const SizedBox(height: 12),

          /// ===============================
          /// CONTINUE WITH EMAIL
          /// ===============================
          PrimaryButton(
            text: "Continue with Email",
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteNames.emailInput,
              );
            },
          ),
        ],
      ),
    );
  }
}
