import 'package:flutter/material.dart';

class TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      title: RichText(
        text: const TextSpan(
          text: "I agree to ",
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: "Terms",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: " & "),
            TextSpan(
              text: "Privacy Policy",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
