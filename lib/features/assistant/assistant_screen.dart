import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/chat.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import 'assistant_provider.dart';

/// Mapea las pantallas semánticas que puede pedir el gateway
/// (`app/tools/navigation.py::Screen`) a rutas reales de la app. Si el
/// gateway añade una pantalla nueva a su enum y esta tabla no se actualiza,
/// `_routeForGatewayScreen` devuelve null y simplemente no se navega — nunca
/// un crash por una ruta desconocida.
String? _routeForGatewayScreen(String screen, String? entityId) {
  switch (screen) {
    case 'trustinfacts.dashboard':
    case 'trustinfacts.reports':
      return '/';
    case 'trustinfacts.customers.list':
      return '/clients';
    case 'trustinfacts.customers.detail':
      return entityId != null ? '/clients/$entityId' : '/clients';
    case 'trustinfacts.invoices.list':
      return '/invoices';
    case 'trustinfacts.invoices.create':
      return '/invoices/new';
    case 'trustinfacts.invoices.detail':
      return entityId != null ? '/invoices/$entityId' : '/invoices';
    // "expenses" en el gateway es el libro de gastos (ExpenseEntry); la
    // pantalla más cercana en la app es "Compras" (facturas/tickets de
    // proveedor), que es de donde salen esos gastos. Todavía no existe una
    // pantalla "/expenses" dedicada.
    case 'trustinfacts.expenses.list':
      return '/purchases';
    case 'trustinfacts.expenses.create':
      return '/scan';
    case 'trustinfacts.expenses.detail':
      return entityId != null ? '/purchases/$entityId' : '/purchases';
    case 'trustinfacts.settings.taxes':
      return '/tax';
    default:
      return null;
  }
}

class AssistantScreen extends ConsumerStatefulWidget {
  const AssistantScreen({super.key});

  @override
  ConsumerState<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends ConsumerState<AssistantScreen> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final _focus = FocusNode();
  bool _hasText = false;

  static const _suggestions = <String>[
    '¿Cuánto he facturado este mes?',
    'Facturas pendientes de cobro',
    'Prepara una factura de 100€ para un cliente',
    '¿Qué es el IPSI?',
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final has = _controller.text.trim().isNotEmpty;
      if (has != _hasText) setState(() => _hasText = has);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _send([String? preset]) {
    final text = (preset ?? _controller.text).trim();
    if (text.isEmpty) return;
    _controller.clear();
    ref.read(assistantProvider.notifier).send(text);
    _focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(assistantProvider);

    // Auto-scroll cuando llega un mensaje nuevo, cambia "escribiendo…" o
    // cambia el estado de una confirmación (para que la tarjeta actualizada
    // quede visible).
    ref.listen<AssistantState>(assistantProvider, (prev, next) {
      if (prev == null ||
          prev.messages.length != next.messages.length ||
          prev.sending != next.sending ||
          prev.confirmations.length != next.confirmations.length) {
        _scrollToBottom();
      }

      final navigate = next.pendingNavigation;
      if (navigate != null) {
        final path = _routeForGatewayScreen(navigate.screen, navigate.entityId);
        ref.read(assistantProvider.notifier).consumePendingNavigation();
        if (path != null) context.push(path);
      }
    });

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: context.appPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            const Icon(Icons.auto_awesome, size: 20),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Asistente',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                Text(
                  state.sending ? 'Escribiendo…' : 'IA · consulta y prepara borradores',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          if (!state.isEmpty)
            IconButton(
              tooltip: 'Nueva conversación',
              icon: const Icon(Icons.add_comment_outlined),
              onPressed: () => ref.read(assistantProvider.notifier).reset(),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: state.isEmpty && !state.sending
                ? _EmptyState(onSuggestion: _send)
                : _MessageList(
                    scroll: _scroll,
                    state: state,
                    onConfirm: (id) =>
                        ref.read(assistantProvider.notifier).confirmPending(id),
                    onCancel: (id) =>
                        ref.read(assistantProvider.notifier).cancelPending(id),
                  ),
          ),
          _InputBar(
            controller: _controller,
            focus: _focus,
            canSend: _hasText && !state.sending,
            onSend: _send,
          ),
        ],
      ),
    );
  }
}

// ── Empty state ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final void Function(String) onSuggestion;
  const _EmptyState({required this.onSuggestion});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      children: [
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 34),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Hola, soy tu asistente',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: context.appText,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Pregúntame en lenguaje natural sobre tus facturas, gastos e impuestos. '
          'También puedo dejarte lista una factura o un gasto para que los confirmes tú.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: context.appTextMuted,
                height: 1.4,
              ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            for (final s in _AssistantScreenState._suggestions)
              _SuggestionChip(label: s, onTap: () => onSuggestion(s)),
          ],
        ),
      ],
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SuggestionChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: context.appPrimarySoft,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.appPrimary.withValues(alpha: 0.2)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: context.appPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ── Message list ─────────────────────────────────────────────────────────────

class _MessageList extends StatelessWidget {
  final ScrollController scroll;
  final AssistantState state;
  final void Function(String id) onConfirm;
  final void Function(String id) onCancel;

  const _MessageList({
    required this.scroll,
    required this.state,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final count = state.messages.length + (state.sending ? 1 : 0);
    return ListView.builder(
      controller: scroll,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      itemCount: count,
      itemBuilder: (context, i) {
        if (state.sending && i == state.messages.length) {
          return const _TypingBubble();
        }
        final message = state.messages[i];
        final confirmationId = message.confirmationId;
        return _MessageBubble(
          message: message,
          confirmation:
              confirmationId != null ? state.confirmations[confirmationId] : null,
          onConfirm: onConfirm,
          onCancel: onCancel,
        );
      },
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final PendingConfirmationView? confirmation;
  final void Function(String id) onConfirm;
  final void Function(String id) onCancel;

  const _MessageBubble({
    required this.message,
    required this.confirmation,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;

    final bg = isUser
        ? context.appPrimary
        : message.isError
            ? context.statusDangerSoft
            : context.appSurfaceRaised;
    final fg = isUser
        ? Colors.white
        : message.isError
            ? context.statusDanger
            : context.appText;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isUser) ...[
                _Avatar(isError: message.isError),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isUser ? 16 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 16),
                    ),
                    border: isUser
                        ? null
                        : Border.all(
                            color: message.isError
                                ? context.statusDanger.withValues(alpha: 0.25)
                                : context.appBorder,
                          ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (isUser || message.isError)
                          ? Text(
                              message.text,
                              style:
                                  TextStyle(color: fg, fontSize: 15, height: 1.4),
                            )
                          : MarkdownText(text: message.text, color: fg),
                      // Cuando hay una confirmacion, la tarjeta es el foco: se
                      // omiten las fuentes RAG (ruido en ese momento).
                      if (!isUser &&
                          confirmation == null &&
                          message.sources.isNotEmpty)
                        _SourcesRow(sources: message.sources),
                      if (!isUser && confirmation != null)
                        _ConfirmationCard(
                          confirmation: confirmation!,
                          onConfirm: onConfirm,
                          onCancel: onCancel,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SourcesRow extends StatelessWidget {
  final List<ChatSource> sources;
  const _SourcesRow({required this.sources});

  @override
  Widget build(BuildContext context) {
    // Varios chunks pueden venir del mismo documento: se agrupan por título
    // para no repetir la misma fuente varias veces.
    final titles = <String>{for (final s in sources) s.title};
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        spacing: 6,
        runSpacing: 6,
        children: [
          for (final title in titles)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: context.appBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: context.appBorder),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.menu_book_outlined,
                      size: 11, color: context.appTextSubtle),
                  const SizedBox(width: 4),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 11,
                      color: context.appTextSubtle,
                      fontWeight: FontWeight.w500,
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

// ── Tarjeta de confirmación (escrituras, Fase 8) ────────────────────────────

/// Tarjeta de confirmación de una escritura. Diseñada para ser inequívoca a
/// simple vista (letra grande, un solo total destacado, dos botones claros):
/// el usuario debe entender QUÉ va a crear y decidir sin ambigüedad.
class _ConfirmationCard extends StatelessWidget {
  final PendingConfirmationView confirmation;
  final void Function(String id) onConfirm;
  final void Function(String id) onCancel;

  const _ConfirmationCard({
    required this.confirmation,
    required this.onConfirm,
    required this.onCancel,
  });

  bool get _isExpense => confirmation.operation == 'create_expense_draft';

  String get _thing => _isExpense ? 'gasto' : 'factura';

  // Nombre de la contraparte (cliente o proveedor), mostrado en grande arriba.
  String? get _partyName =>
      confirmation.summary['customer'] ?? confirmation.summary['supplier'];

  // Filas de detalle: se omite el nombre (ya va en el encabezado), el total
  // (se muestra destacado aparte) y campos de ruido para una persona mayor.
  static const _hiddenKeys = {
    'customer',
    'supplier',
    'total',
    'currency',
    'line_count',
  };

  String _label(String key) {
    return switch (key) {
      'tax' => 'Impuesto',
      'tax_amount' => 'Importe del impuesto',
      'subtotal' => 'Base',
      'category' => 'Categoría',
      'issue_date' => 'Fecha',
      'expense_date' => 'Fecha',
      'due_date' => 'Vencimiento',
      _ => key,
    };
  }

  // El gateway ya envía el total formateado con símbolo (p. ej. "104,00 €").
  String _total() => confirmation.summary['total'] ?? '';

  @override
  Widget build(BuildContext context) {
    final status = confirmation.status;
    final resolved = status == ConfirmationUiStatus.confirmed ||
        status == ConfirmationUiStatus.cancelled;

    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: resolved
              ? context.appBorder
              : context.appPrimary.withValues(alpha: 0.4),
          width: resolved ? 1 : 1.5,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (resolved)
            _ResolvedHeader(confirmation: confirmation, thing: _thing)
          else
            _PendingBody(
              title: _isExpense ? '¿Registrar este gasto?' : '¿Crear esta factura?',
              partyName: _partyName,
              partyLabel: _isExpense ? 'Proveedor' : 'Cliente',
              detailRows: [
                for (final entry in confirmation.summary.entries)
                  if (!_hiddenKeys.contains(entry.key))
                    (_label(entry.key), entry.value),
              ],
              total: _total(),
              working: status == ConfirmationUiStatus.working,
              onConfirm: () => onConfirm(confirmation.id),
              onCancel: () => onCancel(confirmation.id),
            ),
          if (status == ConfirmationUiStatus.failed)
            _FailedBanner(
              message: confirmation.errorMessage ?? 'No se pudo completar.',
            ),
        ],
      ),
    );
  }
}

class _PendingBody extends StatelessWidget {
  final String title;
  final String? partyName;
  final String partyLabel;
  final List<(String, String)> detailRows;
  final String total;
  final bool working;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const _PendingBody({
    required this.title,
    required this.partyName,
    required this.partyLabel,
    required this.detailRows,
    required this.total,
    required this.working,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: context.appText,
            ),
          ),
          if (partyName != null) ...[
            const SizedBox(height: 12),
            Text(
              partyLabel.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: context.appTextSubtle,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              partyName!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: context.appText,
              ),
            ),
          ],
          if (detailRows.isNotEmpty) ...[
            const SizedBox(height: 14),
            for (final (label, value) in detailRows)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 15,
                          color: context.appTextMuted,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: context.appText,
                      ),
                    ),
                  ],
                ),
              ),
          ],
          if (total.isNotEmpty) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: context.appPrimarySoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: context.appText,
                    ),
                  ),
                  Text(
                    total,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: context.appPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          // Botón principal grande y explícito; el usuario mayor lee "crear
          // factura", no un genérico "Confirmar".
          SizedBox(
            height: 52,
            child: FilledButton.icon(
              onPressed: working ? null : onConfirm,
              style: FilledButton.styleFrom(
                backgroundColor: context.appPrimary,
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              icon: working
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.check_rounded, size: 22),
              label: Text(
                working
                    ? 'Creando…'
                    : (partyLabel == 'Proveedor'
                        ? 'Sí, registrar gasto'
                        : 'Sí, crear factura'),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 48,
            child: TextButton(
              onPressed: working ? null : onCancel,
              style: TextButton.styleFrom(
                foregroundColor: context.appTextMuted,
                textStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              child: const Text('No, cancelar'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResolvedHeader extends StatelessWidget {
  final PendingConfirmationView confirmation;
  final String thing;

  const _ResolvedHeader({required this.confirmation, required this.thing});

  @override
  Widget build(BuildContext context) {
    final confirmed = confirmation.status == ConfirmationUiStatus.confirmed;
    final color = confirmed ? context.statusSuccess : context.appTextSubtle;
    final bg = confirmed ? context.statusSuccessSoft : context.appSurfaceRaised;

    return Container(
      color: bg,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            confirmed ? Icons.check_circle_rounded : Icons.cancel_outlined,
            size: 28,
            color: color,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  confirmed
                      ? (thing == 'gasto' ? 'Gasto registrado' : 'Factura creada')
                      : 'Cancelado',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: context.appText,
                  ),
                ),
                if (confirmed) ...[
                  const SizedBox(height: 2),
                  Text(
                    confirmation.resultLine != null
                        ? '${confirmation.resultLine} · guardado en tus borradores'
                        : 'Guardado en tus borradores',
                    style: TextStyle(fontSize: 13, color: context.appTextMuted),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FailedBanner extends StatelessWidget {
  final String message;
  const _FailedBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.statusDangerSoft,
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, size: 20, color: context.statusDanger),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: context.statusDanger,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final bool isError;
  const _Avatar({this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        gradient: isError
            ? null
            : const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
              ),
        color: isError ? context.statusDangerSoft : null,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Icon(
        isError ? Icons.error_outline : Icons.auto_awesome,
        size: 16,
        color: isError ? context.statusDanger : Colors.white,
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const _Avatar(),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: context.appSurfaceRaised,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(16),
              ),
              border: Border.all(color: context.appBorder),
            ),
            child: const _TypingDots(),
          ),
        ],
      ),
    );
  }
}

class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
        ..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      height: 8,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (i) {
              final t = (_c.value - i * 0.2) % 1.0;
              final scale = 0.6 + 0.4 * (1 - (t - 0.5).abs() * 2).clamp(0.0, 1.0);
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: context.appTextSubtle,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

// ── Input bar ────────────────────────────────────────────────────────────────

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final bool canSend;
  final void Function([String?]) onSend;

  const _InputBar({
    required this.controller,
    required this.focus,
    required this.canSend,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appSurface,
        border: Border(top: BorderSide(color: context.appBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Micrófono — la voz llega en una fase posterior.
              IconButton(
                icon: const Icon(Icons.mic_none_rounded),
                color: context.appTextMuted,
                tooltip: 'Voz (próximamente)',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🎤 La voz llegará muy pronto'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  decoration: BoxDecoration(
                    color: context.appBackground,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: context.appBorder),
                  ),
                  child: TextField(
                    controller: controller,
                    focusNode: focus,
                    minLines: 1,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
                    style: TextStyle(color: context.appText, fontSize: 15),
                    decoration: InputDecoration(
                      hintText: 'Escribe tu mensaje…',
                      hintStyle: TextStyle(color: context.appTextSubtle),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _SendButton(enabled: canSend, onTap: () => onSend()),
            ],
          ),
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onTap;
  const _SendButton({required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: enabled ? context.appPrimary : context.appBorder,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_upward_rounded),
        color: enabled ? Colors.white : context.appTextSubtle,
        onPressed: enabled ? onTap : null,
      ),
    );
  }
}

// ── Markdown ligero ───────────────────────────────────────────────────────────
// Renderiza el subconjunto de Markdown que suele devolver el LLM: **negrita**,
// *cursiva*, `código`, títulos (#/##/###) y listas con - o *. Sin dependencias.

class MarkdownText extends StatelessWidget {
  final String text;
  final Color color;
  const MarkdownText({super.key, required this.text, required this.color});

  static final _inlineRe =
      RegExp(r'\*\*(.+?)\*\*|`(.+?)`|\*(.+?)\*|_(.+?)_');
  static final _headingRe = RegExp(r'^(#{1,6})\s+(.*)$');
  static final _bulletRe = RegExp(r'^\s*[-*]\s+(.*)$');

  List<InlineSpan> _inline(String input, TextStyle base) {
    final spans = <InlineSpan>[];
    var last = 0;
    for (final m in _inlineRe.allMatches(input)) {
      if (m.start > last) {
        spans.add(TextSpan(text: input.substring(last, m.start), style: base));
      }
      if (m.group(1) != null) {
        spans.add(TextSpan(
          text: m.group(1),
          style: base.copyWith(fontWeight: FontWeight.w700),
        ));
      } else if (m.group(2) != null) {
        spans.add(TextSpan(
          text: m.group(2),
          style: base.copyWith(
            fontFamily: 'monospace',
            fontSize: (base.fontSize ?? 15) - 1,
          ),
        ));
      } else if (m.group(3) != null) {
        spans.add(TextSpan(
          text: m.group(3),
          style: base.copyWith(fontStyle: FontStyle.italic),
        ));
      } else if (m.group(4) != null) {
        spans.add(TextSpan(
          text: m.group(4),
          style: base.copyWith(fontStyle: FontStyle.italic),
        ));
      }
      last = m.end;
    }
    if (last < input.length) {
      spans.add(TextSpan(text: input.substring(last), style: base));
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final base = TextStyle(color: color, fontSize: 15, height: 1.4);
    final lines = text.split('\n');
    final children = <Widget>[];

    for (final raw in lines) {
      final line = raw.trimRight();

      if (line.trim().isEmpty) {
        children.add(const SizedBox(height: 6));
        continue;
      }

      final heading = _headingRe.firstMatch(line);
      if (heading != null) {
        final level = heading.group(1)!.length;
        final size = level <= 1 ? 18.0 : (level == 2 ? 16.5 : 15.5);
        children.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text.rich(TextSpan(
            children: _inline(
              heading.group(2)!,
              base.copyWith(fontWeight: FontWeight.w800, fontSize: size),
            ),
          )),
        ));
        continue;
      }

      final bullet = _bulletRe.firstMatch(line);
      if (bullet != null) {
        children.add(Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('•  ', style: base),
              Expanded(
                child: Text.rich(TextSpan(children: _inline(bullet.group(1)!, base))),
              ),
            ],
          ),
        ));
        continue;
      }

      children.add(Text.rich(TextSpan(children: _inline(line, base))));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
