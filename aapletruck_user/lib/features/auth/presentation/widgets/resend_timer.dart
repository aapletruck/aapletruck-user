import 'dart:async';
import 'package:flutter/material.dart';

class ResendTimer extends StatefulWidget {
  final int seconds;
  final VoidCallback onResend;

  const ResendTimer({super.key, this.seconds = 30, required this.onResend});

  @override
  State<ResendTimer> createState() => _ResendTimerState();
}

class _ResendTimerState extends State<ResendTimer> {
  late int _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.seconds;
    _start();
  }

  void _start() {
    _timer?.cancel();
    _remaining = widget.seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining == 0) {
        timer.cancel();
      } else {
        setState(() => _remaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_remaining > 0) {
      return Text(
        "Resend code in 0:${_remaining.toString().padLeft(2, '0')}",
        style: Theme.of(context).textTheme.bodySmall,
      );
    }

    return TextButton(
      onPressed: () {
        widget.onResend();
        _start();
      },
      child: const Text("Resend code"),
    );
  }
}
