import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/models/chat.dart';
import '../../core/models/conversation_history.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../widgets/loading_indicator.dart';
import 'assistant_provider.dart';
import 'assistant_screen.dart' show MarkdownText;
import 'conversation_history_provider.dart';

/// Fase H.2: lectura de una conversación pasada, con opción de seguir
/// escribiendo desde donde se quedó.
class ConversationDetailScreen extends ConsumerWidget {
  final String conversationId;
  const ConversationDetailScreen({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(conversationDetailProvider(conversationId));

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: context.appPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          detailAsync.asData?.value.title ?? 'Conversación',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: detailAsync.when(
        loading: () => const LoadingIndicator(),
        error: (error, _) => const Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Text('No se pudo abrir esta conversación.'),
          ),
        ),
        data: (detail) => _DetailBody(detail: detail),
      ),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  final ConversationDetail detail;
  const _DetailBody({required this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            itemCount: detail.messages.length,
            itemBuilder: (context, i) =>
                _ReadOnlyBubble(message: detail.messages[i]),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.appSurface,
            border: Border(top: BorderSide(color: context.appBorder)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: context.appPrimary,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: const Text('Seguir conversando'),
                  onPressed: () async {
                    await ref
                        .read(assistantProvider.notifier)
                        .continueConversation(detail);
                    if (context.mounted) context.push('/assistant');
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ReadOnlyBubble extends StatelessWidget {
  final ConversationMessage message;
  const _ReadOnlyBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final bg = isUser ? context.appPrimary : context.appSurfaceRaised;
    final fg = isUser ? Colors.white : context.appText;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
                border: isUser ? null : Border.all(color: context.appBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  isUser
                      ? Text(
                          message.content,
                          style: TextStyle(color: fg, fontSize: 15, height: 1.4),
                        )
                      : MarkdownText(text: message.content, color: fg),
                  if (message.confirmation != null)
                    _ExpiredConfirmationCard(
                      confirmation: message.confirmation!,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// La tarjeta de una confirmación de escritura de una conversación vieja.
/// Nunca es accionable aquí: es lectura del historial, y su TTL de 600s ya
/// pasó de sobra — el botón sale siempre deshabilitado, nunca se intenta la
/// llamada y por tanto nunca puede fallar al pulsarlo.
class _ExpiredConfirmationCard extends StatelessWidget {
  final ChatConfirmation confirmation;
  const _ExpiredConfirmationCard({required this.confirmation});

  String get _thing =>
      confirmation.operation == 'create_expense_draft' ? 'gasto' : 'factura';

  @override
  Widget build(BuildContext context) {
    final total = confirmation.summary['total'];
    final party =
        confirmation.summary['customer'] ?? confirmation.summary['supplier'];
    final when = DateFormat(
      'dd/MM/yyyy HH:mm',
      'es_ES',
    ).format(confirmation.expiresAt.toLocal());

    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.appBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 16,
                color: context.appTextSubtle,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  party != null
                      ? 'Propuesta de $_thing · $party'
                      : 'Propuesta de $_thing',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: context.appText,
                  ),
                ),
              ),
              if (total != null)
                Text(
                  total,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: context.appPrimary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: FilledButton(
              // Deshabilitado siempre: una confirmación vieja no se puede
              // reactivar desde aquí, caducó hace tiempo.
              onPressed: null,
              style: FilledButton.styleFrom(
                disabledBackgroundColor: context.appBorder,
                disabledForegroundColor: context.appTextSubtle,
              ),
              child: Text('Caducó el $when'),
            ),
          ),
        ],
      ),
    );
  }
}
