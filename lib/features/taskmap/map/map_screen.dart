import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../data/models/map_client.dart';
import '../data/providers.dart';
import '../shared/state_views.dart';
import '../shared/tm_colors.dart';
import '../shared/tm_spacing.dart';
import '../shared/tm_type.dart';
import 'client_tasks_sheet.dart';
import 'widgets/task_pin.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();
  bool _locating = false;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _openClientSheet(BuildContext context, MapClient client) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ClientTasksSheet(
        clientId: client.id,
        clientName: client.name,
        latitude: client.latitude,
        longitude: client.longitude,
      ),
    );
  }

  Future<void> _moveToUser() async {
    if (_locating) return;
    setState(() => _locating = true);
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        _showSnack('Activa la ubicación del dispositivo.');
        return;
      }
      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.denied ||
          perm == LocationPermission.deniedForever) {
        _showSnack('Permiso de ubicación denegado.');
        return;
      }
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      _mapController.move(LatLng(pos.latitude, pos.longitude), 14);
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(mapClientsProvider);
    final clients = clientsAsync.asData?.value ?? const <MapClient>[];

    return Stack(
      children: [
        Positioned.fill(
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(40.2, -3.65),
              initialZoom: 5.3,
              minZoom: 3,
              maxZoom: 18,
              backgroundColor: context.tm.bg,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://a.basemaps.cartocdn.com/${context.tm.mapTilesLight ? 'light_all' : 'dark_all'}/{z}/{x}/{y}{r}.png',
                userAgentPackageName: 'com.trustinfacts.mobile',
                retinaMode: RetinaMode.isHighDensity(context),
              ),
              if (clients.isNotEmpty)
                MarkerClusterLayerWidget(
                  options: MarkerClusterLayerOptions(
                    maxClusterRadius: 46,
                    size: const Size(46, 46),
                    padding: const EdgeInsets.all(50),
                    markers: [
                      for (final c in clients)
                        Marker(
                          point: LatLng(c.latitude, c.longitude),
                          width: 44,
                          height: 44,
                          child: TaskPin(
                            client: c,
                            onTap: () => _openClientSheet(context, c),
                          ),
                        ),
                    ],
                    builder: (context, markers) =>
                        ClusterBadge(count: markers.length),
                  ),
                ),
              RichAttributionWidget(
                alignment: AttributionAlignment.bottomLeft,
                attributions: [
                  TextSourceAttribution('OpenStreetMap'),
                  TextSourceAttribution('CARTO'),
                ],
              ),
            ],
          ),
        ),

        // Header overlay
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(TmSpacing.md),
            child: _MapHeader(
              count: clients.length,
              loading: clientsAsync.isLoading,
              locating: _locating,
              onRefresh: () => ref.invalidate(mapClientsProvider),
              onLocate: _moveToUser,
            ),
          ),
        ),

        // Error overlay
        if (clientsAsync.hasError)
          Positioned.fill(
            child: ColoredBox(
              color: context.tm.bg.withValues(alpha: 0.45),
              child: ErrorView(
                error: clientsAsync.error!,
                onRetry: () => ref.invalidate(mapClientsProvider),
              ),
            ),
          ),

        // Empty overlay
        if (clientsAsync.hasValue && clients.isEmpty)
          const Positioned.fill(
            child: EmptyView(
              icon: Icons.location_off_rounded,
              title: 'Sin trabajos en el mapa',
              subtitle: 'No hay clientes con tareas y ubicación.',
            ),
          ),
      ],
    );
  }
}

class _MapHeader extends StatelessWidget {
  const _MapHeader({
    required this.count,
    required this.loading,
    required this.locating,
    required this.onRefresh,
    required this.onLocate,
  });

  final int count;
  final bool loading;
  final bool locating;
  final VoidCallback onRefresh;
  final VoidCallback onLocate;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: TmRadii.brLg,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: TmSpacing.lg,
            vertical: TmSpacing.md,
          ),
          decoration: BoxDecoration(
            color: context.tm.surface.withValues(alpha: 0.72),
            borderRadius: TmRadii.brLg,
            border: Border.all(color: context.tm.glassBorder),
          ),
          child: Row(
            children: [
              Icon(Icons.map_rounded, color: context.tm.accent, size: 20),
              const SizedBox(width: TmSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Mapa de trabajos', style: TmType.title(context)),
                    Text(
                      loading
                          ? 'Cargando…'
                          : '$count cliente${count == 1 ? '' : 's'} con tareas',
                      style: TmType.label(context).copyWith(color: context.tm.textMuted),
                    ),
                  ],
                ),
              ),
              // GPS center-on-user button
              IconButton(
                onPressed: locating ? null : onLocate,
                tooltip: 'Mi ubicación',
                icon: locating
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: context.tm.accent,
                        ),
                      )
                    : Icon(
                        Icons.my_location_rounded,
                        color: context.tm.accent,
                        size: 20,
                      ),
              ),
              // Refresh button
              IconButton(
                onPressed: loading ? null : onRefresh,
                tooltip: 'Actualizar',
                icon: loading
                    ? SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: context.tm.accent,
                        ),
                      )
                    : Icon(
                        Icons.refresh_rounded,
                        color: context.tm.textSecondary,
                        size: 20,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
