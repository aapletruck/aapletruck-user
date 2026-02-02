import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../routes/route_names.dart';
import '../controllers/auth_controller.dart';

class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String contact;
  final bool isEmail;

  const OtpVerificationScreen({
    super.key,
    required this.contact,
    required this.isEmail,
  });

  @override
  ConsumerState<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen> {
  final _otpController = TextEditingController();
  Timer? _timer;
  int _seconds = 30;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _seconds = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
      } else {
        setState(() => _seconds--);
      }
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  bool get isComplete => _otpController.text.length == 4;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Enter OTP", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text("Sent to ${widget.contact}"),

          const SizedBox(height: 24),

          TextField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            maxLength: 4,
            decoration: const InputDecoration(
              hintText: "4-digit OTP",
              counterText: "",
            ),
            onChanged: (value) async {
              if (value.length == 4) {
                final success = await ref
                    .read(authControllerProvider.notifier)
                    .verifyPhoneOtp(value);

                if (success && mounted) {
                  Navigator.pushNamed(context, RouteNames.nameInput);
                }
              }
            },
          ),

          const SizedBox(height: 12),

          Text(
            _seconds > 0
                ? "Resend code in 0:${_seconds.toString().padLeft(2, '0')}"
                : "Resend code",
          ),

          const Spacer(),

          PrimaryButton(
            text: "Verify",
            isLoading: authState.isLoading,
            onPressed: isComplete
                ? () async {
                    final success = await ref
                        .read(authControllerProvider.notifier)
                        .verifyPhoneOtp(_otpController.text);

                    if (success && mounted) {
                      Navigator.pushNamed(context, RouteNames.nameInput);
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
