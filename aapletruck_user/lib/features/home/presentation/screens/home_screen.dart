import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final user = authState.user;

    return AppScaffold(
      showBack: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================
          // HEADER
          // =========================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                user?.firstName != null
                    ? "Hi, ${user!.firstName} 👋"
                    : "Welcome 👋",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await ref.read(authControllerProvider.notifier).signOut();
                },
              ),
            ],
          ),

          const SizedBox(height: 24),

          // =========================
          // MAIN CONTENT PLACEHOLDER
          // =========================
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.home_filled, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("Home Screen", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 8),
                  Text(
                    "Your app content starts here",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          // =========================
          // PRIMARY ACTION (FUTURE)
          // =========================
          PrimaryButton(
            text: "Start Using App",
            onPressed: () {
              // TODO:
              // Navigate to Map / Booking / Dashboard
            },
          ),
        ],
      ),
    );
  }
}
