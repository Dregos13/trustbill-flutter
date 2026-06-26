import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/utils/error_messages.dart';
import '../../data/models/task_form_options.dart';
import '../../data/providers.dart';
import '../../shared/tm_colors.dart';
import '../../shared/tm_spacing.dart';
import '../../shared/tm_type.dart';

typedef LatLngResult = ({double lat, double lng});

/// Lets the user give a client a map location (GPS or drop-pin), persists it via
/// `PATCH /clients/:id/location`, refreshes the map, and returns the saved
/// coordinates (or null if cancelled/failed).
Future<LatLngResult?> pickAndSaveClientLocation(
  BuildContext context,
  WidgetRef ref,
  TaskClientOption client,
) async {
  final choice = await showModalBottomSheet<_LocChoice>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => const _LocationChoiceSheet(),
  );
  if (choice == null || !context.mounted) return null;

  LatLngResult? coords;
  try {
    if (choice == _LocChoice.gps) {
      coords = await _currentGpsLocation();
    } else {
      coords = await Navigator.of(context).push<LatLngResult>(
        MaterialPageRoute(
          builder: (_) => _LocationPickerScreen(
            initial: client.hasLocation
                ? LatLng(client.latitude!, client.longitude!)
                : null,
            clientName: client.name,
          ),
        ),
      );
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(friendlyError(e))));
    }
    return null;
  }

  if (coords == null) return null;

  try {
    await ref
        .read(tasksRepositoryProvider)
        .updateClientLocation(client.id, coords.lat, coords.lng);
    ref.invalidate(mapClientsProvider);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ubicación del cliente guardada')),
      );
    }
    return coords;
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(friendlyError(e))));
    }
    return null;
  }
}

enum _LocChoice { gps, map }

Future<LatLngResult> _currentGpsLocation() async {
  if (!await Geolocator.isLocationServiceEnabled()) {
    throw 'Activa la ubicación del dispositivo para usar el GPS.';
  }
  var perm = await Geolocator.checkPermission();
  if (perm == LocationPermission.denied) {
    perm = await Geolocator.requestPermission();
  }
  if (perm == LocationPermission.denied ||
      perm == LocationPermission.deniedForever) {
    throw 'Permiso de ubicación denegado.';
  }
  final pos = await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
  );
  return (lat: pos.latitude, lng: pos.longitude);
}

class _LocationChoiceSheet extends StatelessWidget {
  const _LocationChoiceSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TmColors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(TmRadii.xl),
        ),
        border: Border(top: BorderSide(color: TmColors.glassBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(TmSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Fijar ubicación del cliente', style: TmType.h2),
              const SizedBox(height: TmSpacing.xs),
              Text(
                'Para que sus tareas aparezcan en el mapa.',
                style: TmType.label.copyWith(color: TmColors.textMuted),
              ),
              const SizedBox(height: TmSpacing.lg),
              _Option(
                icon: Icons.my_location_rounded,
                title: 'Usar mi ubicación (GPS)',
                subtitle: 'Estoy en el sitio del cliente',
                onTap: () => Navigator.of(context).pop(_LocChoice.gps),
              ),
              const SizedBox(height: TmSpacing.sm),
              _Option(
                icon: Icons.map_rounded,
                title: 'Fijar en el mapa',
                subtitle: 'Mover el mapa y confirmar el punto',
                onTap: () => Navigator.of(context).pop(_LocChoice.map),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: TmRadii.brMd,
      child: Container(
        padding: const EdgeInsets.all(TmSpacing.md),
        decoration: BoxDecoration(
          color: TmColors.bg.withValues(alpha: 0.4),
          borderRadius: TmRadii.brMd,
          border: Border.all(color: TmColors.glassBorder),
        ),
        child: Row(
          children: [
            Icon(icon, color: TmColors.accent),
            const SizedBox(width: TmSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TmType.body),
                  Text(
                    subtitle,
                    style: TmType.label.copyWith(color: TmColors.textMuted),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: TmColors.textMuted),
          ],
        ),
      ),
    );
  }
}

/// Full-screen map — the fixed center crosshair marks where the pin will drop.
class _LocationPickerScreen extends StatefulWidget {
  const _LocationPickerScreen({required this.initial, required this.clientName});

  final LatLng? initial;
  final String clientName;

  @override
  State<_LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<_LocationPickerScreen> {
  final _controller = MapController();
  static const _fallback = LatLng(40.2, -3.65);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _confirm() {
    final c = _controller.camera.center;
    Navigator.of(context).pop((lat: c.latitude, lng: c.longitude));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TmColors.bg,
      appBar: AppBar(
        title: Text(
          widget.clientName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          FlutterMap(
            mapController: _controller,
            options: MapOptions(
              initialCenter: widget.initial ?? _fallback,
              initialZoom: widget.initial != null ? 16 : 5.3,
              minZoom: 3,
              maxZoom: 19,
              backgroundColor: TmColors.bg,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://a.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png',
                userAgentPackageName: 'com.trustinfacts.mobile',
                retinaMode: RetinaMode.isHighDensity(context),
              ),
            ],
          ),
          const IgnorePointer(
            child: Padding(
              padding: EdgeInsets.only(bottom: 36),
              child: Icon(
                Icons.location_on,
                size: 44,
                color: TmColors.accent,
              ),
            ),
          ),
          Positioned(
            left: TmSpacing.lg,
            right: TmSpacing.lg,
            bottom: TmSpacing.lg,
            child: SafeArea(
              top: false,
              child: FilledButton.icon(
                onPressed: _confirm,
                icon: const Icon(Icons.check_rounded),
                label: const Text('Usar este punto'),
              ),
            ),
          ),
          const Positioned(
            top: TmSpacing.md,
            left: TmSpacing.lg,
            right: TmSpacing.lg,
            child: _PickerHint(),
          ),
        ],
      ),
    );
  }
}

class _PickerHint extends StatelessWidget {
  const _PickerHint();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TmSpacing.md,
        vertical: TmSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: TmColors.surface.withValues(alpha: 0.85),
        borderRadius: TmRadii.brMd,
        border: Border.all(color: TmColors.glassBorder),
      ),
      child: Text(
        'Mueve el mapa para centrar el punto sobre la ubicación del cliente.',
        textAlign: TextAlign.center,
        style: TmType.label.copyWith(color: TmColors.textSecondary),
      ),
    );
  }
}
