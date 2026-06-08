import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/auth/permission_helpers.dart';
import '../../core/auth/permission_provider.dart';
import '../../core/theme/app_theme_tokens.dart';
import 'products_tab.dart';
import 'services_tab.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perms = ref.watch(permissionsProvider);
    final canSeeProducts = perms.contains(Permissions.productsRead) ||
        perms.contains('products.*');
    final canSeeServices = perms.contains(Permissions.servicesRead) ||
        perms.contains('services.*');

    final tabs = <Tab>[
      if (canSeeProducts) const Tab(text: 'Productos'),
      if (canSeeServices) const Tab(text: 'Servicios'),
    ];
    final views = <Widget>[
      if (canSeeProducts) const ProductsTab(),
      if (canSeeServices) const ServicesTab(),
    ];

    if (tabs.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Sin permisos de catálogo')),
      );
    }

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: context.appBackground,
        appBar: AppBar(
          backgroundColor: context.appSurface,
          elevation: 0,
          title: Text(
            'Catálogo',
            style: TextStyle(
              color: context.appText,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          bottom: TabBar(
            tabs: tabs,
            labelColor: context.appPrimary,
            unselectedLabelColor: context.appTextMuted,
            indicatorColor: context.appPrimary,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        body: TabBarView(children: views),
      ),
    );
  }
}
