import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../routes/route_names.dart';
import '../controllers/auth_controller.dart';

class TermsScreen extends ConsumerStatefulWidget {
  const TermsScreen({super.key});

  @override
  ConsumerState<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends ConsumerState<TermsScreen> {
  bool _accepted = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Terms & Privacy",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),

          const Text(
            "Please read and accept our Terms of Service and Privacy Policy to continue.",
          ),

          const SizedBox(height: 24),

          CheckboxListTile(
            value: _accepted,
            onChanged: (value) {
              setState(() => _accepted = value ?? false);
            },
            title: const Text("I agree to Terms & Privacy"),
            controlAffinity: ListTileControlAffinity.leading,
          ),

          const Spacer(),

          PrimaryButton(
            text: "Next",
            onPressed: _accepted
                ? () {
                    ref.read(authControllerProvider.notifier).acceptTerms();
                    Navigator.pushNamed(context, RouteNames.allSet);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
