import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/cache/cache_providers.dart';
import '../../core/models/client.dart';
import '../../core/models/paginated.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../widgets/client_card.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/pagination_controls.dart';

class _ClientsSearchNotifier extends Notifier<String> {
  @override
  String build() => '';
  void set(String v) => state = v;
}

final _clientsSearchProvider =
    NotifierProvider.autoDispose<_ClientsSearchNotifier, String>(
  _ClientsSearchNotifier.new,
);

class _ClientsOffsetNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void set(int v) => state = v;
}

final _clientsOffsetProvider =
    NotifierProvider.autoDispose<_ClientsOffsetNotifier, int>(
  _ClientsOffsetNotifier.new,
);

/// Contador que fuerza saltarse la caché (pull-to-refresh). Al incrementar,
/// el provider vuelve a ejecutarse y va directo a red en vez de emitir caché.
class _ClientsRefreshNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void bump() => state++;
}

final _clientsRefreshProvider =
    NotifierProvider.autoDispose<_ClientsRefreshNotifier, int>(
  _ClientsRefreshNotifier.new,
);

/// Clave de caché de la lista de clientes (solo la vista por defecto: primera
/// página, sin búsqueda). Incluye el scope tenant:empresa.
String _clientsCacheKey(String scope) => 'clients:$scope';

String _encodeClients(PaginatedResponse<Client> r) => jsonEncode({
      'items': r.items.map((c) => c.toJson()).toList(),
      'total': r.total,
      'limit': r.limit,
      'offset': r.offset,
    });

PaginatedResponse<Client> _decodeClients(String s) =>
    PaginatedResponse.fromJson(
      jsonDecode(s) as Map<String, dynamic>,
      Client.fromJson,
    );

/// Borra la caché de clientes del scope actual. Llamar tras crear/editar un
/// cliente para que la siguiente carga traiga datos frescos sin flash stale.
Future<void> invalidateClientsCache(WidgetRef ref) async {
  final scope = ref.read(cacheScopeProvider);
  await ref.read(cacheRepositoryProvider).delete(_clientsCacheKey(scope));
}

/// Lista de clientes con estrategia stale-while-revalidate:
/// 1. Si la vista es cacheable (1ª página, sin búsqueda) emite la caché al
///    instante → la pantalla pinta sin spinner.
/// 2. Lanza el GET, guarda la respuesta y emite los datos frescos.
/// 3. Si la red falla pero ya servimos caché, se mantiene lo cacheado (modo
///    tolerante a fallos/offline). Sin caché previa, propaga el error.
final clientsProvider =
    StreamProvider.autoDispose<PaginatedResponse<Client>>((ref) async* {
  final endpoints = ref.watch(endpointsProvider);
  final cache = ref.watch(cacheRepositoryProvider);
  final scope = ref.watch(cacheScopeProvider);
  final search = ref.watch(_clientsSearchProvider);
  final offset = ref.watch(_clientsOffsetProvider);
  final forceNetwork = ref.watch(_clientsRefreshProvider) > 0;

  final cacheable = search.isEmpty && offset == 0;
  final key = _clientsCacheKey(scope);

  var servedCache = false;
  if (cacheable && !forceNetwork) {
    final entry = await cache.read(key);
    if (entry != null) {
      yield _decodeClients(entry.payload);
      servedCache = true;
    }
  }

  try {
    final fresh =
        await endpoints.getClients(limit: 50, offset: offset, search: search);
    if (cacheable) await cache.write(key, _encodeClients(fresh));
    yield fresh;
  } catch (e) {
    // Con caché ya mostrada, la mantenemos (no rompemos la pantalla por un
    // fallo de red). Sin caché, propagamos para mostrar el error.
    if (!servedCache) rethrow;
  }
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
    ref.read(_clientsOffsetProvider.notifier).set(0);
    ref.read(_clientsSearchProvider.notifier).set(value);
  }

  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(clientsProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        // Pull-to-refresh: fuerza red (ignora caché) y espera datos frescos.
        ref.read(_clientsRefreshProvider.notifier).bump();
        await ref.read(clientsProvider.future);
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Clientes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: context.appText,
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
                        onTap: () => context.push('/clients/${c.id}'),
                      )),
                  PaginationControls(
                    currentPage: response.currentPage,
                    totalPages: response.totalPages,
                    hasPrevious: response.hasPrevious,
                    hasNext: response.hasNext,
                    onPrevious: () {
                      ref.read(_clientsOffsetProvider.notifier).set(
                          ref.read(_clientsOffsetProvider) - 50);
                    },
                    onNext: () {
                      ref.read(_clientsOffsetProvider.notifier).set(
                          ref.read(_clientsOffsetProvider) + 50);
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
