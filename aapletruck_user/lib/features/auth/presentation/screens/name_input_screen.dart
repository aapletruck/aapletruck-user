import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../routes/route_names.dart';
import '../controllers/auth_controller.dart';

class NameInputScreen extends ConsumerStatefulWidget {
  const NameInputScreen({super.key});

  @override
  ConsumerState<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends ConsumerState<NameInputScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  bool get isValid => _firstNameController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider).user;

    if (user != null && user.firstName != null) {
      _firstNameController.text = user.firstName!;
      _lastNameController.text = user.lastName ?? '';
    }

    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What’s your name?",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),

          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(hintText: "First name"),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(hintText: "Last name (optional)"),
          ),

          const Spacer(),

          PrimaryButton(
            text: "Next",
            onPressed: isValid
                ? () {
                    ref
                        .read(authControllerProvider.notifier)
                        .saveUserName(
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                        );

                    Navigator.pushNamed(context, RouteNames.terms);
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
