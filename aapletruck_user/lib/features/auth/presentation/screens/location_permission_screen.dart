import 'package:flutter/material.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../../../core/services/location_service.dart';
import '../../../../routes/route_names.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBack: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_on, size: 96),
          const SizedBox(height: 24),

          Text(
            "Enable location",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),

          const Text(
            "We use your location to show nearby drivers faster.",
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32),

          PrimaryButton(
            text: "Allow while using app",
            onPressed: () async {
              await LocationService.requestPermission();
              Navigator.pushReplacementNamed(context, RouteNames.home);
            },
          ),

          const SizedBox(height: 8),

          SecondaryButton(
            text: "Not now",
            onPressed: () {
              Navigator.pushReplacementNamed(context, RouteNames.home);
            },
          ),
        ],
      ),
    );
  }
}
