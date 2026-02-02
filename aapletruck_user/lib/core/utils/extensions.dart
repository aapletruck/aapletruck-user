import 'package:flutter/material.dart';

/// String extensions
extension StringExtensions on String {
  bool get isNullOrEmpty => trim().isEmpty;

  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

/// Context extensions
extension ContextExtensions on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// Quick snackbar
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }
}

/// Widget extensions
extension WidgetExtensions on Widget {
  Widget withPadding([EdgeInsets padding = const EdgeInsets.all(16)]) {
    return Padding(padding: padding, child: this);
  }
}
