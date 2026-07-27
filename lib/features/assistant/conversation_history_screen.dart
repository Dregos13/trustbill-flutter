import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/models/conversation_history.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/loading_indicator.dart';
import 'conversation_history_provider.dart';

/// Fase H.2: listado de conversaciones pasadas con el asistente. Solo
/// lectura — abrir uno de estos elementos no gasta ninguna llamada al LLM.
class ConversationHistoryScreen extends ConsumerWidget {
  const ConversationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationHistoryListProvider);

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: context.appPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Conversaciones',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async =>
            ref.invalidate(conversationHistoryListProvider),
        child: conversationsAsync.when(
          loading: () => const LoadingIndicator(),
          error: (error, _) => ListView(
            children: const [
              EmptyState(
                message: 'No se pudo cargar el historial. Desliza para reintentar.',
              ),
            ],
          ),
          data: (conversations) {
            if (conversations.isEmpty) {
              return ListView(
                children: const [
                  EmptyState(
                    message: 'Todavía no has hablado con el asistente.',
                  ),
                ],
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: conversations.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, i) =>
                  _ConversationTile(conversation: conversations[i]),
            );
          },
        ),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final ConversationSummary conversation;
  const _ConversationTile({required this.conversation});

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yyyy HH:mm', 'es_ES').format(
      conversation.updatedAt.toLocal(),
    );
    return InkWell(
      onTap: () => context.push('/assistant/history/${conversation.conversationId}'),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: context.appSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: context.appBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.appPrimarySoft,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 18,
                color: context.appPrimary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: context.appText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$date · ${conversation.messageCount} mensajes',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.appTextSubtle,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: context.appTextSubtle),
          ],
        ),
      ),
    );
  }
}
