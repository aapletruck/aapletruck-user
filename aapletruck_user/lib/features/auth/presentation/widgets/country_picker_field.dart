import 'package:flutter/material.dart';

class CountryPickerField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  const CountryPickerField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: const InputDecoration(labelText: "Country"),
      items: const [
        DropdownMenuItem(value: "+91", child: Text("🇮🇳 +91")),
        DropdownMenuItem(value: "+1", child: Text("🇺🇸 +1")),
        DropdownMenuItem(value: "+44", child: Text("🇬🇧 +44")),
      ],

      // ✅ FIX IS HERE
      onChanged: (String? newValue) {
        if (newValue != null) {
          onChanged(newValue);
        }
      },
    );
  }
}
