import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/client.dart';
import '../../core/models/paginated.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/client_card.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/pagination_controls.dart';

final _clientsSearchProvider = StateProvider.autoDispose<String>((ref) => '');
final _clientsOffsetProvider = StateProvider.autoDispose<int>((ref) => 0);

final clientsProvider =
    FutureProvider.autoDispose<PaginatedResponse<Client>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final search = ref.watch(_clientsSearchProvider);
  final offset = ref.watch(_clientsOffsetProvider);
  return endpoints.getClients(limit: 50, offset: offset, search: search);
});

class ClientsScreen extends ConsumerStatefulWidget {
  const ClientsScreen({super.key});

  @override
  ConsumerState<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String value) {
    ref.read(_clientsOffsetProvider.notifier).state = 0;
    ref.read(_clientsSearchProvider.notifier).state = value;
  }

  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(clientsProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.refresh(clientsProvider.future),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Clientes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.gray900,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar clientes...',
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 12, right: 8),
                child: Icon(Icons.search, size: 20, color: AppColors.gray400),
              ),
              prefixIconConstraints:
                  const BoxConstraints(minWidth: 36, minHeight: 0),
            ),
            onChanged: _onSearch,
          ),
          const SizedBox(height: 16),
          clientsAsync.when(
            loading: () => const LoadingIndicator(),
            error: (err, _) => EmptyState(
              message: err is ApiError
                  ? err.message
                  : 'Error al cargar clientes',
            ),
            data: (response) {
              if (response.items.isEmpty) {
                return const EmptyState(
                    message: 'No se encontraron clientes');
              }
              return Column(
                children: [
                  ...response.items.map((c) => ClientCard(
                        name: c.name,
                        taxId: c.taxId,
                        email: c.email,
                      )),
                  PaginationControls(
                    currentPage: response.currentPage,
                    totalPages: response.totalPages,
                    hasPrevious: response.hasPrevious,
                    hasNext: response.hasNext,
                    onPrevious: () {
                      ref.read(_clientsOffsetProvider.notifier).state =
                          ref.read(_clientsOffsetProvider) - 50;
                    },
                    onNext: () {
                      ref.read(_clientsOffsetProvider.notifier).state =
                          ref.read(_clientsOffsetProvider) + 50;
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
