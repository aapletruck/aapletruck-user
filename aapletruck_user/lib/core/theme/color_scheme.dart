import 'package:flutter/material.dart';

class AppColorScheme {
  AppColorScheme._();

  static const Color primary = Color(0xFF000000);
  static const Color secondary = Color(0xFF1E88E5);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5);
  static const Color error = Color(0xFFD32F2F);

  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color disabled = Color(0xFFBDBDBD);

  static ColorScheme lightScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    secondary: secondary,
    onSecondary: Colors.white,
    background: background,
    onBackground: textPrimary,
    surface: surface,
    onSurface: textPrimary,
    error: error,
    onError: Colors.white,
  );
}
