import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/utils/validators.dart';
import '../../../../routes/route_names.dart';
import '../controllers/auth_controller.dart';

class PhoneInputScreen extends ConsumerStatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  ConsumerState<PhoneInputScreen> createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends ConsumerState<PhoneInputScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get isValid => Validators.isValidPhone(_controller.text);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter mobile number",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),

          TextField(
            controller: _controller,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            decoration: const InputDecoration(
              prefixText: "+91 ",
              hintText: "Mobile number",
              counterText: "",
            ),
            onChanged: (_) => setState(() {}),
          ),

          const Spacer(),

          PrimaryButton(
            text: "Continue",
            onPressed: isValid
                ? () {
                    ref
                        .read(authControllerProvider.notifier)
                        .sendPhoneOtp(
                          phoneNumber: "+91${_controller.text}",
                          onCodeSent: () {
                            Navigator.pushNamed(
                              context,
                              RouteNames.otpVerification,
                              arguments: {
                                'contact': _controller.text,
                                'isEmail': false,
                              },
                            );
                          },
                          onError: (error) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(error)));
                          },
                        );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
