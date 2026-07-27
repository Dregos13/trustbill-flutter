import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/models/conversation_history.dart';

/// Historial de conversaciones (Fase H.1): solo lectura, sin coste de LLM.
final conversationHistoryListProvider =
    FutureProvider.autoDispose<List<ConversationSummary>>((ref) {
      return ref.read(assistantRepositoryProvider).listConversations();
    });

final conversationDetailProvider = FutureProvider.autoDispose
    .family<ConversationDetail, String>((ref, conversationId) {
      return ref
          .read(assistantRepositoryProvider)
          .getConversation(conversationId);
    });
