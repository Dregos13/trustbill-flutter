import '../../core/api/ai_gateway_client.dart';
import '../../core/models/chat.dart';
import '../../core/models/confirmation.dart';
import '../../core/models/conversation_history.dart';

/// Acceso al gateway de IA (`trustcore-ai`): un turno de chat, el ciclo de
/// vida de una confirmación de escritura, y la lectura del historial (Fase
/// H.1). Ninguna API key de IA vive aquí ni en el cliente: la identidad viaja
/// en el JWT que ya usa el resto de la app.
class AssistantRepository {
  final AiGatewayClient _client;

  AssistantRepository(this._client);

  Future<ChatResponse> sendMessage({
    required String message,
    String? conversationId,
  }) async {
    final res = await _client.post(
      '/api/v1/chat',
      data: {
        'message': message,
        'conversation_id': ?conversationId,
      },
    );
    return ChatResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<ConfirmationActionResponse> confirm(String confirmationId) async {
    final res = await _client.post(
      '/api/v1/confirmations/$confirmationId/confirm',
    );
    return ConfirmationActionResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<ConfirmationActionResponse> cancel(String confirmationId) async {
    final res = await _client.post(
      '/api/v1/confirmations/$confirmationId/cancel',
    );
    return ConfirmationActionResponse.fromJson(res.data as Map<String, dynamic>);
  }

  Future<List<ConversationSummary>> listConversations({
    int limit = 20,
    int offset = 0,
  }) async {
    final res = await _client.get(
      '/api/v1/conversations?limit=$limit&offset=$offset',
    );
    final raw =
        (res.data as Map<String, dynamic>)['conversations'] as List<dynamic>? ??
        const [];
    return raw
        .map((e) => ConversationSummary.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ConversationDetail> getConversation(String conversationId) async {
    final res = await _client.get('/api/v1/conversations/$conversationId');
    return ConversationDetail.fromJson(res.data as Map<String, dynamic>);
  }
}
