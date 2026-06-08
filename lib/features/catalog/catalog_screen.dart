import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/auth/permission_helpers.dart';
import '../../core/auth/permission_provider.dart';
import '../../core/theme/app_colors.dart';
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
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          title: const Text(
            'Catálogo',
            style: TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          bottom: TabBar(
            tabs: tabs,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.gray500,
            indicatorColor: AppColors.primary,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ),
        body: TabBarView(children: views),
      ),
    );
  }
}
