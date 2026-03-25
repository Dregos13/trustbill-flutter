import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/auth/auth_provider.dart';
import 'core/auth/auth_state.dart';

class TrustInFactsApp extends ConsumerStatefulWidget {
  const TrustInFactsApp({super.key});

  @override
  ConsumerState<TrustInFactsApp> createState() => _TrustInFactsAppState();
}

class _TrustInFactsAppState extends ConsumerState<TrustInFactsApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(authProvider.notifier).tryAutoLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final authState = ref.watch(authProvider);

    // Show splash while checking auth
    if (authState is AuthInitial) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TrustInFacts',
      theme: buildAppTheme(),
      routerConfig: router,
    );
  }
}
