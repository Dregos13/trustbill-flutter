import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/client.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';

final clientDetailProvider =
    FutureProvider.autoDispose.family<Client, int>((ref, id) async {
  final endpoints = ref.read(endpointsProvider);
  return endpoints.getClient(id);
});

class ClientDetailScreen extends ConsumerWidget {
  final int id;

  const ClientDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientAsync = ref.watch(clientDetailProvider(id));

    return clientAsync.when(
      loading: () => const LoadingIndicator(),
      error: (err, _) => EmptyState(
        message:
            err is ApiError ? err.message : 'Error al cargar el cliente',
      ),
      data: (client) => _buildContent(context, client),
    );
  }

  Widget _buildContent(BuildContext context, Client client) {
    final initial = client.name.isNotEmpty ? client.name[0].toUpperCase() : '?';

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/clients');
                }
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppColors.gray100,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back,
                    size: 18, color: AppColors.gray600),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.primaryBg,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                initial,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.gray900,
                    ),
                  ),
                  Text(
                    client.taxId,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Details card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.gray100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Datos de contacto',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.gray900,
                ),
              ),
              const SizedBox(height: 14),
              _detailRow(Icons.badge_outlined, 'NIF/CIF', client.taxId),
              if (client.email != null && client.email!.isNotEmpty)
                _detailRow(Icons.email_outlined, 'Email', client.email!),
              if (client.phone != null && client.phone!.isNotEmpty)
                _detailRow(Icons.phone_outlined, 'Telefono', client.phone!),
              if (client.address != null && client.address!.isNotEmpty)
                _detailRow(
                    Icons.location_on_outlined, 'Direccion', client.address!),
              if (client.postalCode.isNotEmpty || client.city.isNotEmpty)
                _detailRow(
                  Icons.map_outlined,
                  'Localidad',
                  [client.postalCode, client.city]
                      .where((s) => s.isNotEmpty)
                      .join(', '),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.gray400),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray400,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
