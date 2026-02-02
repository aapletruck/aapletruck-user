import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../routes/route_names.dart';

class AllSetScreen extends StatelessWidget {
  const AllSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBack: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 96, color: Colors.green),
          const SizedBox(height: 24),

          Text(
            "You’re all set!",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),

          const Text("Your account is ready to use"),

          const SizedBox(height: 40),

          PrimaryButton(
            text: "Continue",
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.locationPermission);
            },
          ),
        ],
      ),
    );
  }
}
