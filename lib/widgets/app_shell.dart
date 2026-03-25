import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_header.dart';
import 'app_bottom_nav.dart';

class AppShell extends StatelessWidget {
  final String currentLocation;
  final Widget child;

  const AppShell({
    super.key,
    required this.currentLocation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // On back press: if not on home, go home. Otherwise let system handle (exit).
    return PopScope(
      canPop: currentLocation == '/',
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          context.go('/');
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const AppHeader(),
            Expanded(child: child),
          ],
        ),
        bottomNavigationBar: AppBottomNav(
          currentLocation: currentLocation,
          onNavigate: (path) => context.go(path),
        ),
      ),
    );
  }
}
