import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/utils/validators.dart';
import '../../../../routes/route_names.dart';
import '../controllers/auth_controller.dart';

class EmailInputScreen extends ConsumerStatefulWidget {
  const EmailInputScreen({super.key});

  @override
  ConsumerState<EmailInputScreen> createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends ConsumerState<EmailInputScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get isValid => Validators.isValidEmail(_controller.text);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter email address",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),

          TextField(
            controller: _controller,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "name@example.com"),
            onChanged: (_) => setState(() {}),
          ),

          const Spacer(),

          PrimaryButton(
            text: "Next",
            onPressed: isValid
                ? () async {
                    await ref
                        .read(authControllerProvider.notifier)
                        .sendEmailOtp(
                          email: _controller.text,
                          appUrl: "https://example.app/login",
                        );

                    Navigator.pushNamed(
                      context,
                      RouteNames.otpVerification,
                      arguments: {'contact': _controller.text, 'isEmail': true},
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
