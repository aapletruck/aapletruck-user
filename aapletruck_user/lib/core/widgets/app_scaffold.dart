import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  final bool showBack;

  const AppScaffold({super.key, required this.child, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showBack ? AppBar(leading: const BackButton()) : null,
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
    );
  }
}
