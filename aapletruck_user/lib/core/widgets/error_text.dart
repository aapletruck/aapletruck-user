import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String? message;

  const ErrorText({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    if (message == null || message!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        message!,
        style: const TextStyle(color: Colors.red, fontSize: 13),
      ),
    );
  }
}
