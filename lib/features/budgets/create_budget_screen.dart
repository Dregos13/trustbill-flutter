import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/client.dart';
import '../../core/models/product.dart';
import '../../core/models/service.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../core/utils/error_messages.dart';
import '../../widgets/doc_line_editor.dart';

final _clientsForBudgetProvider =
    FutureProvider.autoDispose<List<Client>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final res = await endpoints.getClients(limit: 100);
  return res.items;
});

final _productsForBudgetProvider =
    FutureProvider.autoDispose<List<Product>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final res = await endpoints.getProducts(limit: 100);
  return res.items;
});

final _servicesForBudgetProvider =
    FutureProvider.autoDispose<List<Service>>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  final res = await endpoints.getServices(limit: 100);
  return res.items;
});

class CreateBudgetScreen extends ConsumerStatefulWidget {
  const CreateBudgetScreen({super.key});

  @override
  ConsumerState<CreateBudgetScreen> createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends ConsumerState<CreateBudgetScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  Client? _selectedClient;
  String _taxKind = 'IVA';
  String _status = 'confirmed';
  int _paymentPlanCount = 1;
  DateTime _issuedAt = DateTime.now();
  final _internalNotesCtrl = TextEditingController();
  final _clientNotesCtrl = TextEditingController();
  final List<DocLine> _lines = [DocLine()];

  final _currencyFmt = NumberFormat.currency(locale: 'es_ES', symbol: '€');

  @override
  void dispose() {
    _internalNotesCtrl.dispose();
    _clientNotesCtrl.dispose();
    super.dispose();
  }

  double get _subtotal => _lines.fold(0, (s, l) => s + l.base);
  double get _totalTax => _lines.fold(0, (s, l) => s + l.taxAmount);
  double get _total => _lines.fold(0, (s, l) => s + l.total);

  Future<void> _submit() async {
    if (_selectedClient == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Selecciona un cliente para continuar.'),
        backgroundColor: AppColors.warning,
      ));
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final payload = {
      'clientId': _selectedClient!.id,
      'status': _status,
      'issuedAt': _issuedAt.toUtc().toIso8601String(),
      'taxKind': _taxKind,
      if (_paymentPlanCount > 1) 'paymentPlanCount': _paymentPlanCount,
      if (_internalNotesCtrl.text.trim().isNotEmpty)
        'internalNotes': _internalNotesCtrl.text.trim(),
      if (_clientNotesCtrl.text.trim().isNotEmpty)
        'clientNotes': _clientNotesCtrl.text.trim(),
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
      await endpoints.createBudget(payload);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Presupuesto creado.'),
        backgroundColor: AppColors.success,
      ));
      context.go('/budgets');
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(friendlyError(e,
            fallback: 'No se pudo crear el presupuesto. Verifica los datos.')),
        backgroundColor: AppColors.danger,
      ));
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _issuedAt,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _issuedAt = picked);
  }

  Future<void> _createClientInline() async {
    final result = await context.push<Client>('/clients/new');
    if (result != null) {
      ref.invalidate(_clientsForBudgetProvider);
      setState(() => _selectedClient = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(_clientsForBudgetProvider);
    final productsAsync = ref.watch(_productsForBudgetProvider);
    final servicesAsync = ref.watch(_servicesForBudgetProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo presupuesto'),
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
            _sectionTitle(context, 'Cliente'),
            const SizedBox(height: 8),
            clientsAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (e, _) => Text('Error cargando clientes: $e'),
              data: (clients) => _clientSelector(context, clients),
            ),
            const SizedBox(height: 20),

            _sectionTitle(context, 'Datos del presupuesto'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _dateField(context)),
                const SizedBox(width: 12),
                Expanded(child: _taxKindField(context)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _statusField(context)),
                const SizedBox(width: 12),
                Expanded(child: _paymentPlanField(context)),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sectionTitle(context, 'Líneas'),
                TextButton.icon(
                  onPressed: () => setState(() => _lines
                      .add(DocLine(taxRate: _taxKind == 'IVA' ? 21 : 10))),
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Añadir línea'),
                  style:
                      TextButton.styleFrom(foregroundColor: context.appPrimary),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ..._lines.asMap().entries.map((entry) {
              final idx = entry.key;
              return DocLineCard(
                key: ValueKey('budget-line-$idx'),
                line: entry.value,
                taxKind: _taxKind,
                products: productsAsync.valueOrNull ?? [],
                services: servicesAsync.valueOrNull ?? [],
                canDelete: _lines.length > 1,
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

            _sectionTitle(context, 'Observaciones para el cliente (opcional)'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _clientNotesCtrl,
              maxLines: 2,
              maxLength: 200,
              decoration: InputDecoration(
                hintText: 'Se incluyen en el documento...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            _sectionTitle(context, 'Observaciones internas (opcional)'),
            const SizedBox(height: 8),
            TextFormField(
              controller: _internalNotesCtrl,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'Uso interno. No se imprime...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
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
                    : const Text('Crear presupuesto',
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
    return Row(
      children: [
        Expanded(
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Cliente *',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
                onChanged: (c) => setState(() => _selectedClient = c),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: _createClientInline,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 44,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: context.appPrimary),
              borderRadius: BorderRadius.circular(8),
              color: context.appPrimarySoft,
            ),
            child: Icon(Icons.person_add, color: context.appPrimary, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _dateField(BuildContext context) => InkWell(
        onTap: _pickDate,
        borderRadius: BorderRadius.circular(8),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Fecha de emisión',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            suffixIcon: const Icon(Icons.calendar_today, size: 18),
          ),
          child: Text(DateFormat('dd/MM/yyyy').format(_issuedAt),
              style: TextStyle(fontSize: 14, color: context.appText)),
        ),
      );

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
                  child:
                      Text('IVA', style: TextStyle(color: context.appText))),
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
          labelText: 'Estado',
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
                  value: 'draft',
                  child: Text('Borrador',
                      style: TextStyle(color: context.appText))),
              DropdownMenuItem(
                  value: 'confirmed',
                  child: Text('Confirmado',
                      style: TextStyle(color: context.appText))),
            ],
            onChanged: (v) => setState(() => _status = v ?? 'confirmed'),
          ),
        ),
      );

  Widget _paymentPlanField(BuildContext context) => TextFormField(
        initialValue: '1',
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: 'Nº de pagos',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          isDense: true,
        ),
        onChanged: (v) =>
            setState(() => _paymentPlanCount = int.tryParse(v) ?? 1),
      );
}
