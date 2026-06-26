import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/auth/auth_state.dart';
import '../../core/models/client.dart';
import '../../core/models/product.dart';
import '../../core/models/service.dart';
import '../../core/models/sale.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/error_messages.dart';
import '../../widgets/doc_line_editor.dart';

final _clientsForSaleProvider =
    FutureProvider.autoDispose<List<Client>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final res = await endpoints.getClients(limit: 100);
  return res.items;
});

final _productsForSaleProvider =
    FutureProvider.autoDispose<List<Product>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final res = await endpoints.getProducts(limit: 100);
  return res.items;
});

final _servicesForSaleProvider =
    FutureProvider.autoDispose<List<Service>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final res = await endpoints.getServices(limit: 100);
  return res.items;
});

final _availableBudgetsProvider = FutureProvider.autoDispose
    .family<List<AvailableBudget>, int>((ref, clientId) async {
  final endpoints = ref.watch(endpointsProvider);
  return endpoints.getAvailableBudgets(clientId);
});

class CreateSaleScreen extends ConsumerStatefulWidget {
  final int? initialBudgetId;
  final int? initialClientId;

  const CreateSaleScreen({super.key, this.initialBudgetId, this.initialClientId});

  @override
  ConsumerState<CreateSaleScreen> createState() => _CreateSaleScreenState();
}

class _CreateSaleScreenState extends ConsumerState<CreateSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  Client? _selectedClient;
  int? _selectedBudgetId;
  String _taxKind = 'IVA';
  String _status = 'OPEN';
  final _internalNotesCtrl = TextEditingController();
  final List<DocLine> _lines = [];

  final _currencyFmt = NumberFormat.currency(locale: 'es_ES', symbol: '€');

  @override
  void dispose() {
    _internalNotesCtrl.dispose();
    super.dispose();
  }

  bool get _hasBudget => _selectedBudgetId != null;
  double get _subtotal => _lines.fold(0, (s, l) => s + l.base);
  double get _totalTax => _lines.fold(0, (s, l) => s + l.taxAmount);
  double get _total => _lines.fold(0, (s, l) => s + l.total);

  int? get _currentUserId {
    final auth = ref.read(authProvider);
    return auth is AuthAuthenticated ? auth.user.id : null;
  }

  String get _currentUserName {
    final auth = ref.read(authProvider);
    return auth is AuthAuthenticated ? auth.user.name : '—';
  }

  Future<void> _submit() async {
    final clientId = _selectedClient?.id;
    if (clientId == null) {
      _toast('Selecciona un cliente para continuar.', AppColors.warning);
      return;
    }
    final vendorId = _currentUserId;
    if (vendorId == null) {
      _toast('No se pudo identificar el vendedor.', AppColors.danger);
      return;
    }
    if (!_hasBudget) {
      if (_lines.isEmpty) {
        _toast('Añade al menos una línea o selecciona un presupuesto.',
            AppColors.warning);
        return;
      }
      if (!_formKey.currentState!.validate()) return;
    }

    setState(() => _saving = true);

    final payload = <String, dynamic>{
      'clientId': clientId,
      'vendorId': vendorId,
      'status': _status,
      if (_internalNotesCtrl.text.trim().isNotEmpty)
        'internalNotes': _internalNotesCtrl.text.trim(),
      if (_hasBudget) 'budgetId': _selectedBudgetId,
      if (!_hasBudget) 'regime': _taxKind,
      if (!_hasBudget)
        'lines': _lines
            .map((l) => {
                  'description': l.description.trim(),
                  'quantity': l.quantity.toInt(),
                  'unitPrice': l.unitPrice,
                  'taxRate': l.taxRate,
                  'discountRate': l.discountRate,
                  if (l.productId != null) 'productId': l.productId,
                  if (l.serviceId != null) 'serviceId': l.serviceId,
                })
            .toList(),
    };

    try {
      final endpoints = ref.read(endpointsProvider);
      final sale = await endpoints.createSale(payload);
      if (!mounted) return;
      _toast('Venta ${sale.code} creada.', AppColors.success);
      context.go('/sales/${sale.id}');
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      _toast(
          friendlyError(e,
              fallback: 'No se pudo crear la venta. Verifica los datos.'),
          AppColors.danger);
    }
  }

  void _toast(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: color));
  }

  @override
  void initState() {
    super.initState();
    _selectedBudgetId = widget.initialBudgetId;
    // Resolve the preselected client (from "Convertir en venta") once loaded.
    if (widget.initialClientId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _resolveInitialClient());
    }
  }

  Future<void> _resolveInitialClient() async {
    final clients = await ref.read(_clientsForSaleProvider.future);
    final match = clients.where((c) => c.id == widget.initialClientId);
    if (match.isNotEmpty && mounted) {
      setState(() => _selectedClient = match.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(_clientsForSaleProvider);
    final productsAsync = ref.watch(_productsForSaleProvider);
    final servicesAsync = ref.watch(_servicesForSaleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva venta'),
        backgroundColor: context.appPrimary,
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
                        strokeWidth: 2, color: Colors.white)),
              ),
            )
          else
            TextButton(
              onPressed: _submit,
              child: const Text('Guardar',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _sectionTitle(context, 'Cliente y vendedor'),
            const SizedBox(height: 8),
            clientsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('Error cargando clientes: $e'),
              data: (clients) => _clientSelector(context, clients),
            ),
            const SizedBox(height: 10),
            _vendorRow(context),
            const SizedBox(height: 20),

            if (_selectedClient != null) ...[
              _sectionTitle(context, 'Desde presupuesto (opcional)'),
              const SizedBox(height: 8),
              _budgetSelector(context),
              const SizedBox(height: 20),
            ],

            if (!_hasBudget) ...[
              _sectionTitle(context, 'Régimen y estado'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _taxKindField(context)),
                  const SizedBox(width: 12),
                  Expanded(child: _statusField(context)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _sectionTitle(context, 'Líneas de venta'),
                  TextButton.icon(
                    onPressed: () => setState(() => _lines
                        .add(DocLine(taxRate: _taxKind == 'IVA' ? 21 : 10))),
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Añadir línea'),
                    style: TextButton.styleFrom(
                        foregroundColor: context.appPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_lines.isEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.appSurface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: context.appBorder),
                  ),
                  child: Text(
                    'Añade líneas o selecciona un presupuesto para importarlas.',
                    style: TextStyle(color: context.appTextMuted, fontSize: 13),
                  ),
                )
              else
                ..._lines.asMap().entries.map((entry) {
                  final idx = entry.key;
                  return DocLineCard(
                    key: ValueKey('sale-line-$idx'),
                    line: entry.value,
                    taxKind: _taxKind,
                    products: productsAsync.asData?.value ?? [],
                    services: servicesAsync.asData?.value ?? [],
                    canDelete: true,
                    onDelete: () => setState(() => _lines.removeAt(idx)),
                    onChanged: () => setState(() {}),
                  );
                }),
              const SizedBox(height: 20),
              DocTotalsBox(
                subtotal: _subtotal,
                totalTax: _totalTax,
                total: _total,
                taxKind: _taxKind,
                fmt: _currencyFmt,
              ),
              const SizedBox(height: 20),
            ],

            if (_hasBudget) ...[
              _sectionTitle(context, 'Estado'),
              const SizedBox(height: 8),
              _statusField(context),
              const SizedBox(height: 16),
            ],
            _sectionTitle(context, 'Observaciones internas (opcional)'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _internalNotesCtrl,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Uso interno. No se imprime...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: _saving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : const Text('Crear venta',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) => Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: context.appTextMuted,
          letterSpacing: 0.8,
        ),
      );

  Widget _clientSelector(BuildContext context, List<Client> clients) {
    final resolved =
        clients.any((c) => c.id == _selectedClient?.id) ? _selectedClient : null;
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Cliente *',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Client>(
          value: resolved,
          hint: Text('Selecciona cliente...',
              style: TextStyle(color: context.appTextMuted)),
          isExpanded: true,
          isDense: true,
          dropdownColor: context.appSurfaceRaised,
          items: clients
              .map((c) => DropdownMenuItem<Client>(
                    value: c,
                    child: Text(c.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: context.appText)),
                  ))
              .toList(),
          onChanged: (c) => setState(() {
            _selectedClient = c;
            _selectedBudgetId = null; // reset budget when client changes
          }),
        ),
      ),
    );
  }

  Widget _vendorRow(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: context.appSurface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.appBorder),
        ),
        child: Row(
          children: [
            Icon(Icons.person_outline, size: 18, color: context.appTextMuted),
            const SizedBox(width: 8),
            Text('Vendedor: ',
                style: TextStyle(color: context.appTextMuted, fontSize: 13)),
            Expanded(
              child: Text(_currentUserName,
                  style: TextStyle(
                      color: context.appText,
                      fontSize: 13,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );

  Widget _budgetSelector(BuildContext context) {
    final clientId = _selectedClient!.id;
    final budgetsAsync = ref.watch(_availableBudgetsProvider(clientId));
    return budgetsAsync.when(
      loading: () => const LinearProgressIndicator(),
      error: (e, _) => Text('Error cargando presupuestos: $e',
          style: TextStyle(color: context.appTextMuted, fontSize: 12)),
      data: (budgets) {
        if (budgets.isEmpty) {
          return Text('No hay presupuestos disponibles para este cliente.',
              style: TextStyle(color: context.appTextMuted, fontSize: 13));
        }
        return InputDecorator(
          decoration: InputDecoration(
            labelText: 'Presupuesto',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int?>(
              value: _selectedBudgetId,
              isExpanded: true,
              isDense: true,
              dropdownColor: context.appSurfaceRaised,
              hint: Text('(Sin presupuesto)',
                  style: TextStyle(color: context.appTextMuted)),
              items: [
                DropdownMenuItem<int?>(
                  value: null,
                  child: Text('(Sin presupuesto)',
                      style: TextStyle(color: context.appText)),
                ),
                ...budgets.map((b) => DropdownMenuItem<int?>(
                      value: b.id,
                      child: Text(
                        '${b.series}-${b.number}  ·  ${_currencyFmt.format(b.total)}',
                        style: TextStyle(color: context.appText),
                      ),
                    )),
              ],
              onChanged: (v) => setState(() => _selectedBudgetId = v),
            ),
          ),
        );
      },
    );
  }

  Widget _taxKindField(BuildContext context) => InputDecorator(
        decoration: InputDecoration(
          labelText: 'Régimen fiscal',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _taxKind,
            isDense: true,
            isExpanded: true,
            dropdownColor: context.appSurfaceRaised,
            items: [
              DropdownMenuItem(
                  value: 'IVA',
                  child: Text('IVA', style: TextStyle(color: context.appText))),
              DropdownMenuItem(
                  value: 'IPSI',
                  child:
                      Text('IPSI', style: TextStyle(color: context.appText))),
            ],
            onChanged: (v) {
              if (v != null) {
                setState(() {
                  _taxKind = v;
                  for (final line in _lines) {
                    line.taxRate = v == 'IVA' ? 21 : 10;
                  }
                });
              }
            },
          ),
        ),
      );

  Widget _statusField(BuildContext context) => InputDecorator(
        decoration: InputDecoration(
          labelText: 'Estado inicial',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _status,
            isDense: true,
            isExpanded: true,
            dropdownColor: context.appSurfaceRaised,
            items: [
              DropdownMenuItem(
                  value: 'OPEN',
                  child:
                      Text('Abierta', style: TextStyle(color: context.appText))),
              DropdownMenuItem(
                  value: 'LOST',
                  child:
                      Text('Perdida', style: TextStyle(color: context.appText))),
            ],
            onChanged: (v) => setState(() => _status = v ?? 'OPEN'),
          ),
        ),
      );
}
