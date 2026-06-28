import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/client.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/error_messages.dart';

class CreateClientScreen extends ConsumerStatefulWidget {
  /// If [existingClient] is provided, the screen is in edit mode.
  final Client? existingClient;

  const CreateClientScreen({super.key, this.existingClient});

  @override
  ConsumerState<CreateClientScreen> createState() => _CreateClientScreenState();
}

class _CreateClientScreenState extends ConsumerState<CreateClientScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;
  bool _locating = false;
  double? _latitude;
  double? _longitude;

  late final TextEditingController _nameCtrl;
  late final TextEditingController _taxIdCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _postalCtrl;
  late final TextEditingController _cityCtrl;

  bool get _isEditing => widget.existingClient != null;

  @override
  void initState() {
    super.initState();
    final c = widget.existingClient;
    _nameCtrl    = TextEditingController(text: c?.name ?? '');
    _taxIdCtrl   = TextEditingController(text: c?.taxId ?? '');
    _emailCtrl   = TextEditingController(text: c?.email ?? '');
    _phoneCtrl   = TextEditingController(text: c?.phone ?? '');
    _addressCtrl = TextEditingController(text: c?.address ?? '');
    _postalCtrl  = TextEditingController(text: c?.postalCode ?? '');
    _cityCtrl    = TextEditingController(text: c?.city ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _taxIdCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _postalCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  /// Geocodes the typed address via Nominatim. Falls back to GPS if no address.
  Future<void> _detectLocation() async {
    setState(() => _locating = true);
    try {
      double? lat;
      double? lng;

      final address = _addressCtrl.text.trim();
      final city    = _cityCtrl.text.trim();
      final postal  = _postalCtrl.text.trim();

      if (address.isNotEmpty || city.isNotEmpty) {
        // Build a query from the typed fields.
        final query = [address, postal, city].where((s) => s.isNotEmpty).join(', ');
        final uri = Uri.https('nominatim.openstreetmap.org', '/search', {
          'q': query,
          'format': 'json',
          'limit': '1',
          'addressdetails': '0',
        });
        final res = await http.get(
          uri,
          headers: {'User-Agent': 'com.trustinfacts.mobile'},
        );
        if (res.statusCode == 200) {
          final List<dynamic> data = json.decode(res.body) as List<dynamic>;
          if (data.isNotEmpty) {
            lat = double.tryParse(data[0]['lat'] as String? ?? '');
            lng = double.tryParse(data[0]['lon'] as String? ?? '');
          }
        }
        if (lat == null) {
          throw 'No se encontró la dirección. Intenta con más detalle o usa el GPS.';
        }
      } else {
        // No address typed — use device GPS.
        if (!await Geolocator.isLocationServiceEnabled()) {
          throw 'Escribe una dirección o activa el GPS para detectar la ubicación.';
        }
        var perm = await Geolocator.checkPermission();
        if (perm == LocationPermission.denied) {
          perm = await Geolocator.requestPermission();
        }
        if (perm == LocationPermission.denied || perm == LocationPermission.deniedForever) {
          throw 'Permiso de ubicación denegado.';
        }
        final pos = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
        );
        lat = pos.latitude;
        lng = pos.longitude;
      }

      if (!mounted) return;
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => _LocationConfirmDialog(lat: lat!, lng: lng!),
      );
      if (confirmed == true) {
        setState(() { _latitude = lat; _longitude = lng; });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(friendlyError(e, fallback: 'No se pudo obtener la ubicación.')),
          backgroundColor: AppColors.warning,
        ),
      );
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);

    final endpoints = ref.read(endpointsProvider);
    final data = {
      'name':       _nameCtrl.text.trim(),
      'taxId':      _taxIdCtrl.text.trim(),
      'email':      _emailCtrl.text.trim(),
      'phone':      _phoneCtrl.text.trim(),
      'address':    _addressCtrl.text.trim(),
      'postalCode': _postalCtrl.text.trim(),
      'city':       _cityCtrl.text.trim(),
    };

    try {
      Client result;
      if (_isEditing) {
        result = await endpoints.updateClient(widget.existingClient!.id, data);
      } else {
        result = await endpoints.createClient(data);
        if (_latitude != null && _longitude != null) {
          await endpoints.patchClientLocation(result.id, _latitude!, _longitude!);
        }
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? 'Cliente "${result.name}" actualizado.'
                : 'Cliente "${result.name}" creado correctamente.',
          ),
          backgroundColor: AppColors.success,
        ),
      );
      context.pop(result);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(friendlyError(e, fallback: 'No se pudo guardar el cliente. Intenta de nuevo.')),
          backgroundColor: AppColors.danger,
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar cliente' : 'Nuevo cliente'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          if (_saving)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                ),
              ),
            )
          else
            TextButton(
              onPressed: _save,
              child: const Text(
                'Guardar',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SectionTitle('Datos fiscales'),
            const SizedBox(height: 8),
            _field(
              controller: _nameCtrl,
              label: 'Nombre / Razón social',
              hint: 'Nombre del cliente',
              required: true,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 12),
            _field(
              controller: _taxIdCtrl,
              label: 'CIF / NIF',
              hint: 'Ej: B12345678',
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 20),
            _SectionTitle('Contacto'),
            const SizedBox(height: 8),
            _field(
              controller: _emailCtrl,
              label: 'Email',
              hint: 'cliente@ejemplo.com',
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return null;
                final re = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
                if (!re.hasMatch(v)) return 'Email no válido';
                return null;
              },
            ),
            const SizedBox(height: 12),
            _field(
              controller: _phoneCtrl,
              label: 'Teléfono',
              hint: 'Ej: 612 345 678',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            _SectionTitle('Dirección'),
            const SizedBox(height: 8),
            _field(
              controller: _addressCtrl,
              label: 'Dirección',
              hint: 'Calle, número...',
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _field(
                    controller: _postalCtrl,
                    label: 'Código postal',
                    hint: '28001',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: _field(
                    controller: _cityCtrl,
                    label: 'Ciudad',
                    hint: 'Madrid',
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ],
            ),
            if (!_isEditing) ...[
              const SizedBox(height: 20),
              _SectionTitle('Ubicación'),
              const SizedBox(height: 8),
              _LocationField(
                latitude: _latitude,
                longitude: _longitude,
                locating: _locating,
                onDetect: _detectLocation,
                onClear: () => setState(() { _latitude = null; _longitude = null; }),
              ),
            ],
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Text(
                        _isEditing ? 'Guardar cambios' : 'Crear cliente',
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    String? hint,
    bool required = false,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      validator: validator ??
          (required
              ? (v) => (v == null || v.trim().isEmpty) ? 'Campo obligatorio' : null
              : null),
    );
  }
}

class _LocationField extends StatelessWidget {
  const _LocationField({
    required this.latitude,
    required this.longitude,
    required this.locating,
    required this.onDetect,
    required this.onClear,
  });

  final double? latitude;
  final double? longitude;
  final bool locating;
  final VoidCallback onDetect;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    if (locating) {
      return const Row(
        children: [
          SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
          SizedBox(width: 10),
          Text('Obteniendo ubicación...', style: TextStyle(color: AppColors.gray500)),
        ],
      );
    }
    if (latitude != null && longitude != null) {
      return Row(
        children: [
          const Icon(Icons.location_on_rounded, color: AppColors.success, size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              '${latitude!.toStringAsFixed(5)}, ${longitude!.toStringAsFixed(5)}',
              style: const TextStyle(fontSize: 13, color: AppColors.success),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18, color: AppColors.gray500),
            onPressed: onClear,
            tooltip: 'Quitar ubicación',
          ),
        ],
      );
    }
    return OutlinedButton.icon(
      onPressed: onDetect,
      icon: const Icon(Icons.my_location_rounded, size: 18),
      label: const Text('Detectar ubicación'),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class _LocationConfirmDialog extends StatelessWidget {
  const _LocationConfirmDialog({required this.lat, required this.lng});

  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    final point = LatLng(lat, lng);
    return AlertDialog(
      title: const Text('¿Es correcta esta ubicación?'),
      content: SizedBox(
        width: double.maxFinite,
        height: 220,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FlutterMap(
            options: MapOptions(initialCenter: point, initialZoom: 15),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.trustinfacts.mobile',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: point,
                    width: 32,
                    height: 32,
                    child: const Icon(Icons.location_pin, color: AppColors.danger, size: 32),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('No es correcta'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
          child: const Text('Confirmar'),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.gray500,
        letterSpacing: 0.5,
      ),
    );
  }
}
