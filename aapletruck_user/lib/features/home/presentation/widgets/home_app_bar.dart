import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  final String title;
  final VoidCallback? onProfileTap;
  final VoidCallback? onLogoutTap;

  const HomeAppBar({
    super.key,
    required this.title,
    this.onProfileTap,
    this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title / Greeting
            Text(title, style: Theme.of(context).textTheme.headlineMedium),

            // Actions
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.account_circle_outlined),
                  onPressed: onProfileTap,
                ),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: onLogoutTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
