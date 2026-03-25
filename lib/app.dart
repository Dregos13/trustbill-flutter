import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/auth/auth_provider.dart';

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
      ref.read(authProvider.notifier).initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TrustInFacts',
      theme: buildAppTheme(),
      routerConfig: router,
    );
  }
}
