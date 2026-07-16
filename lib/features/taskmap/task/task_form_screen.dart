import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/error_messages.dart';
import '../data/models/task_form_options.dart';
import '../data/models/task_status.dart';
import '../data/providers.dart';
import '../data/task_actions.dart';
import '../shared/format.dart';
import '../shared/tm_colors.dart';
import '../shared/tm_spacing.dart';
import '../shared/tm_type.dart';
import 'widgets/set_location.dart';

/// Create (`/task/new`) or edit (`/task/:id/edit`) a field task.
class TaskFormScreen extends ConsumerStatefulWidget {
  const TaskFormScreen({super.key, this.taskId, this.presetClientId, this.initialScheduledAt});

  final int? taskId;
  final int? presetClientId;
  final DateTime? initialScheduledAt;

  bool get isEditing => taskId != null;

  @override
  ConsumerState<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
  final _title = TextEditingController();
  final _notes = TextEditingController();

  List<TaskClientOption> _clients = const [];
  List<AssignableUser> _users = const [];
  List<InvoiceOption> _invoices = const [];

  int? _clientId;
  int? _documentId;
  int? _assignedToId;
  TaskStatus _status = TaskStatus.pending;
  DateTime? _scheduledAt;

  bool _loading = true;
  bool _saving = false;
  bool _confirmDelete = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _title.dispose();
    _notes.dispose();
    super.dispose();
  }

  TaskClientOption? get _selectedClient {
    for (final c in _clients) {
      if (c.id == _clientId) return c;
    }
    return null;
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final repo = ref.read(tasksRepositoryProvider);
    try {
      final clientsF = repo.formClients();
      final usersF = repo.formUsers();
      _clients = await clientsF;
      _users = await usersF;

      if (widget.isEditing) {
        final t = await repo.getTask(widget.taskId!);
        _title.text = t.title;
        _notes.text = t.notes ?? '';
        _clientId = t.client.id;
        _documentId = t.bill?.id;
        _assignedToId = t.assignedToId;
        _status = t.status;
        _scheduledAt = t.scheduledAt;
        if (_clientId != null) {
          _invoices = await repo.invoicesForClient(_clientId!);
        }
      } else {
        if (widget.presetClientId != null) {
          _clientId = widget.presetClientId;
          _invoices = await repo.invoicesForClient(_clientId!);
        }
        if (widget.initialScheduledAt != null) {
          _scheduledAt = widget.initialScheduledAt;
        }
      }
    } catch (e) {
      _error = friendlyError(e);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _onClientChanged(TaskClientOption client) async {
    setState(() {
      _clientId = client.id;
      _documentId = null;
      _invoices = const [];
    });
    try {
      final inv =
          await ref.read(tasksRepositoryProvider).invoicesForClient(client.id);
      if (mounted) setState(() => _invoices = inv);
    } catch (_) {}
  }

  Future<void> _pickClient() async {
    final picked = await showModalBottomSheet<TaskClientOption>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ClientPickerSheet(clients: _clients),
    );
    if (picked != null) await _onClientChanged(picked);
  }

  Future<void> _pickSchedule() async {
    final now = DateTime.now();
    final base = _scheduledAt?.toLocal() ?? now;
    final date = await showDatePicker(
      context: context,
      initialDate: base,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 2),
    );
    if (date == null || !mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(base),
    );
    setState(() {
      _scheduledAt = DateTime(
        date.year,
        date.month,
        date.day,
        time?.hour ?? 9,
        time?.minute ?? 0,
      );
    });
  }

  Future<void> _setLocation() async {
    final client = _selectedClient;
    if (client == null) return;
    final coords = await pickAndSaveClientLocation(context, ref, client);
    if (coords == null || !mounted) return;
    setState(() {
      _clients = [
        for (final c in _clients)
          if (c.id == client.id)
            c.copyWith(latitude: coords.lat, longitude: coords.lng)
          else
            c,
      ];
    });
  }

  Future<void> _save() async {
    if (_title.text.trim().isEmpty) {
      setState(() => _error = 'El título es obligatorio.');
      return;
    }
    if (_clientId == null) {
      setState(() => _error = 'Selecciona un cliente.');
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    final input = TaskInput(
      title: _title.text.trim(),
      clientId: _clientId!,
      documentId: _documentId,
      status: _status,
      scheduledAt: _scheduledAt,
      notes: _notes.text.trim(),
      assignedToId: _assignedToId,
    );
    try {
      final actions = ref.read(taskActionsProvider);
      if (widget.isEditing) {
        await actions.update(widget.taskId!, input);
      } else {
        await actions.create(input);
      }
      if (!mounted) return;
      _leave(created: !widget.isEditing);
    } catch (e) {
      setState(() {
        _error = friendlyError(e);
        _saving = false;
      });
    }
  }

  Future<void> _delete() async {
    if (!_confirmDelete) {
      setState(() => _confirmDelete = true);
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      await ref.read(taskActionsProvider).delete(widget.taskId!);
      if (!mounted) return;
      context.go('/tasks');
    } catch (e) {
      setState(() {
        _error = friendlyError(e);
        _saving = false;
        _confirmDelete = false;
      });
    }
  }

  void _leave({required bool created}) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/tasks');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(created ? 'Tarea creada' : 'Tarea actualizada')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final client = _selectedClient;
    final missingLocation = client != null && !client.hasLocation;
    final tm = context.tm;
    // Foreground that reads on the accent-filled primary button in each mode.
    final onAccent = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF06212E)
        : Colors.white;

    return Theme(
      data: _tmTheme(context),
      child: Scaffold(
        backgroundColor: tm.bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: tm.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(widget.isEditing ? 'Editar tarea' : 'Nueva tarea'),
        ),
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: tm.backgroundGradient,
          ),
          child: SafeArea(
            child: _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: tm.accent,
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.fromLTRB(
                      TmSpacing.lg,
                      TmSpacing.sm,
                      TmSpacing.lg,
                      TmSpacing.xxl,
                    ),
                    children: [
                      _Field(
                        label: 'Título',
                        required: true,
                        child: TextField(
                          controller: _title,
                          enabled: !_saving,
                          maxLength: 200,
                          style: TmType.body(context).copyWith(
                            color: tm.textPrimary,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Instalar caldera, revisión anual…',
                            counterText: '',
                          ),
                        ),
                      ),
                      _Field(
                        label: 'Cliente',
                        required: true,
                        child: _PickerField(
                          text: client?.name ?? 'Seleccionar cliente',
                          placeholder: client == null,
                          icon: Icons.person_pin_circle_rounded,
                          onTap: _saving ? null : _pickClient,
                        ),
                      ),
                      if (missingLocation) ...[
                        const SizedBox(height: TmSpacing.sm),
                        _LocationWarning(onSet: _saving ? null : _setLocation),
                      ],
                      _Field(
                        label: 'Factura (opcional)',
                        child: DropdownButtonFormField<int?>(
                          // ignore: deprecated_member_use
                          value: _documentId,
                          isExpanded: true,
                          dropdownColor: tm.surface,
                          style: TmType.body(context).copyWith(
                            color: tm.textPrimary,
                          ),
                          decoration: const InputDecoration(),
                          hint: Text(
                            'Sin factura',
                            style: TmType.body(context).copyWith(
                              color: tm.textMuted,
                            ),
                          ),
                          onChanged: (_saving || client == null)
                              ? null
                              : (v) => setState(() => _documentId = v),
                          items: [
                            DropdownMenuItem<int?>(
                              value: null,
                              child: Text(
                                'Sin factura',
                                style: TmType.body(context).copyWith(
                                  color: tm.textMuted,
                                ),
                              ),
                            ),
                            for (final i in _invoices)
                              DropdownMenuItem<int?>(
                                value: i.id,
                                child: Text(
                                  '${i.number} · ${i.total} €',
                                  overflow: TextOverflow.ellipsis,
                                  style: TmType.body(context).copyWith(
                                    color: tm.textPrimary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      _Field(
                        label: 'Fecha y hora',
                        child: _PickerField(
                          text: _scheduledAt != null
                              ? formatDayTime(_scheduledAt!)
                              : 'Sin programar',
                          placeholder: _scheduledAt == null,
                          icon: Icons.event_rounded,
                          onTap: _saving ? null : _pickSchedule,
                          onClear: _scheduledAt != null
                              ? () => setState(() => _scheduledAt = null)
                              : null,
                        ),
                      ),
                      _Field(
                        label: 'Asignada a',
                        child: DropdownButtonFormField<int?>(
                          // ignore: deprecated_member_use
                          value: _assignedToId,
                          isExpanded: true,
                          dropdownColor: tm.surface,
                          style: TmType.body(context).copyWith(
                            color: tm.textPrimary,
                          ),
                          decoration: const InputDecoration(),
                          hint: Text(
                            'Sin asignar',
                            style: TmType.body(context).copyWith(
                              color: tm.textMuted,
                            ),
                          ),
                          onChanged: _saving
                              ? null
                              : (v) => setState(() => _assignedToId = v),
                          items: [
                            DropdownMenuItem<int?>(
                              value: null,
                              child: Text(
                                'Sin asignar',
                                style: TmType.body(context).copyWith(
                                  color: tm.textMuted,
                                ),
                              ),
                            ),
                            for (final u in _users)
                              DropdownMenuItem<int?>(
                                value: u.id,
                                child: Text(
                                  u.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TmType.body(context).copyWith(
                                    color: tm.textPrimary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      _Field(
                        label: 'Estado',
                        child: _StatusSelector(
                          value: _status,
                          enabled: !_saving,
                          onChanged: (s) => setState(() => _status = s),
                        ),
                      ),
                      _Field(
                        label: 'Notas',
                        child: TextField(
                          controller: _notes,
                          enabled: !_saving,
                          minLines: 3,
                          maxLines: 6,
                          maxLength: 2000,
                          style: TmType.body(context).copyWith(
                            color: tm.textPrimary,
                          ),
                          decoration: const InputDecoration(
                            hintText:
                                'Detalles del trabajo, materiales, acceso…',
                            alignLabelWithHint: true,
                            counterText: '',
                          ),
                        ),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: TmSpacing.sm),
                        Text(
                          _error!,
                          style: TmType.label(context).copyWith(color: tm.danger),
                        ),
                      ],
                      const SizedBox(height: TmSpacing.lg),
                      FilledButton(
                        onPressed: _saving ? null : _save,
                        style: FilledButton.styleFrom(
                          backgroundColor: tm.accent,
                          foregroundColor: onAccent,
                        ),
                        child: _saving
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.4,
                                  color: onAccent,
                                ),
                              )
                            : Text(
                                widget.isEditing ? 'Guardar' : 'Crear tarea',
                              ),
                      ),
                      if (widget.isEditing) ...[
                        const SizedBox(height: TmSpacing.sm),
                        TextButton.icon(
                          onPressed: _saving ? null : _delete,
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            color: tm.danger,
                          ),
                          label: Text(
                            _confirmDelete
                                ? 'Confirmar eliminación'
                                : 'Eliminar',
                            style: TextStyle(color: tm.danger),
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// ── Adaptive theme for form fields (matches active brightness) ─────────────────

ThemeData _tmTheme(BuildContext context) {
  final tm = context.tm;
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final scheme = isDark
      ? ColorScheme.dark(
          primary: tm.accent,
          secondary: tm.accent,
          surface: tm.surface,
          error: tm.danger,
        )
      : ColorScheme.light(
          primary: tm.accent,
          secondary: tm.accent,
          surface: tm.surface,
          error: tm.danger,
        );
  return ThemeData(
    colorScheme: scheme,
    scaffoldBackgroundColor: tm.bg,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: tm.glassFill,
      border: OutlineInputBorder(
        borderRadius: TmRadii.brMd,
        borderSide: BorderSide(color: tm.glassBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: TmRadii.brMd,
        borderSide: BorderSide(color: tm.glassBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: TmRadii.brMd,
        borderSide: BorderSide(color: tm.accent, width: 1.5),
      ),
      hintStyle: TmType.body(context).copyWith(color: tm.textMuted),
      iconColor: tm.textMuted,
    ),
  );
}

// ── Small building blocks ──────────────────────────────────────────────────────

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.child,
    this.required = false,
  });

  final String label;
  final Widget child;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: TmSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label.toUpperCase(), style: TmType.overline(context)),
              if (required)
                Text(
                  ' *',
                  style: TmType.overline(context).copyWith(color: context.tm.accent),
                ),
            ],
          ),
          const SizedBox(height: TmSpacing.xs),
          child,
        ],
      ),
    );
  }
}

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.text,
    required this.placeholder,
    required this.icon,
    required this.onTap,
    this.onClear,
  });

  final String text;
  final bool placeholder;
  final IconData icon;
  final VoidCallback? onTap;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: TmRadii.brMd,
      child: InputDecorator(
        decoration: InputDecoration(
          prefixIcon: Icon(icon, size: 20),
          suffixIcon: onClear != null
              ? IconButton(
                  icon: const Icon(Icons.clear_rounded, size: 18),
                  onPressed: onClear,
                )
              : const Icon(Icons.chevron_right_rounded),
        ),
        child: Text(
          text,
          style: TmType.body(context).copyWith(
            color: placeholder ? context.tm.textMuted : context.tm.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _LocationWarning extends StatelessWidget {
  const _LocationWarning({required this.onSet});

  final VoidCallback? onSet;

  @override
  Widget build(BuildContext context) {
    final tm = context.tm;
    return Container(
      padding: const EdgeInsets.all(TmSpacing.md),
      decoration: BoxDecoration(
        color: tm.statusPending.withValues(alpha: 0.12),
        borderRadius: TmRadii.brMd,
        border: Border.all(
          color: tm.statusPending.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_off_rounded,
            color: tm.statusPending,
            size: 20,
          ),
          const SizedBox(width: TmSpacing.sm),
          Expanded(
            child: Text(
              'Sin ubicación: no aparecerá en el mapa.',
              style: TmType.label(context).copyWith(color: tm.textSecondary),
            ),
          ),
          TextButton(
            onPressed: onSet,
            child: Text(
              'Fijar',
              style: TextStyle(color: tm.accent),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusSelector extends StatelessWidget {
  const _StatusSelector({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final TaskStatus value;
  final bool enabled;
  final ValueChanged<TaskStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    const statuses = [
      TaskStatus.pending,
      TaskStatus.inProgress,
      TaskStatus.done,
      TaskStatus.cancelled,
    ];
    return Wrap(
      spacing: TmSpacing.sm,
      runSpacing: TmSpacing.sm,
      children: [
        for (final s in statuses)
          _StatusChip(
            status: s,
            selected: s == value,
            onTap: enabled ? () => onChanged(s) : null,
          ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.status,
    required this.selected,
    required this.onTap,
  });

  final TaskStatus status;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tm = context.tm;
    final color = status.color;
    return InkWell(
      onTap: onTap,
      borderRadius: TmRadii.brSm,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: TmSpacing.md,
          vertical: TmSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected
              ? color.withValues(alpha: 0.18)
              : tm.bg.withValues(alpha: 0.4),
          borderRadius: TmRadii.brSm,
          border: Border.all(
            color: selected ? color : tm.glassBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              status.icon,
              size: 16,
              color: selected ? color : tm.textMuted,
            ),
            const SizedBox(width: 6),
            Text(
              status.label,
              style: TmType.label(context).copyWith(
                color: selected ? color : tm.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Searchable, full-height client picker.
class _ClientPickerSheet extends StatefulWidget {
  const _ClientPickerSheet({required this.clients});

  final List<TaskClientOption> clients;

  @override
  State<_ClientPickerSheet> createState() => _ClientPickerSheetState();
}

class _ClientPickerSheetState extends State<_ClientPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final tm = context.tm;
    final q = _query.trim().toLowerCase();
    final results = (q.isEmpty
            ? widget.clients
            : widget.clients.where((c) => c.name.toLowerCase().contains(q)))
        .take(80)
        .toList();

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: tm.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(TmRadii.xl),
          ),
          border: Border(top: BorderSide(color: tm.glassBorder)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              TmSpacing.lg,
              TmSpacing.md,
              TmSpacing.lg,
              0,
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: tm.glassBorder,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: TmSpacing.md),
                TextField(
                  autofocus: true,
                  style: TmType.body(context).copyWith(color: tm.textPrimary),
                  decoration: const InputDecoration(
                    hintText: 'Buscar cliente…',
                    prefixIcon: Icon(Icons.search_rounded),
                  ),
                  onChanged: (v) => setState(() => _query = v),
                ),
                const SizedBox(height: TmSpacing.sm),
                Expanded(
                  child: results.isEmpty
                      ? Center(
                          child: Text(
                            'Sin clientes',
                            style: TmType.body(context).copyWith(
                              color: tm.textMuted,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (_, i) {
                            final c = results[i];
                            return ListTile(
                              title: Text(c.name, style: TmType.body(context)),
                              subtitle: c.hasLocation
                                  ? null
                                  : Text(
                                      'Sin ubicación',
                                      style: TmType.label(context).copyWith(
                                        color: tm.textMuted,
                                      ),
                                    ),
                              trailing: c.hasLocation
                                  ? Icon(
                                      Icons.place_rounded,
                                      size: 18,
                                      color: tm.accent,
                                    )
                                  : null,
                              onTap: () => Navigator.of(context).pop(c),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
