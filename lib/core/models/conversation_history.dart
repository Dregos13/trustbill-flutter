/// Contrato de `GET /api/v1/conversations` y `GET /api/v1/conversations/{id}`
/// del gateway trustcore-ai (Fase H.1). Solo lectura: no dispara ninguna
/// llamada al LLM, así que listar y releer no cuesta nada.
library;

import 'chat.dart';

class ConversationSummary {
  final String conversationId;
  final String title;
  final DateTime updatedAt;
  final int messageCount;

  const ConversationSummary({
    required this.conversationId,
    required this.title,
    required this.updatedAt,
    required this.messageCount,
  });

  factory ConversationSummary.fromJson(Map<String, dynamic> json) {
    return ConversationSummary(
      conversationId: json['conversation_id'] as String,
      title: json['title'] as String? ?? '',
      updatedAt: DateTime.parse(json['updated_at'] as String),
      messageCount: json['message_count'] as int? ?? 0,
    );
  }
}

/// Un mensaje ya guardado, tal como lo devuelve el servidor. Solo `user` y
/// `assistant`: los de rol `tool` nunca salen del servidor.
class ConversationMessage {
  final String role;
  final String content;
  final DateTime createdAt;
  // La tarjeta de una confirmación de escritura que se creó en este turno,
  // si la hubo. Su `expiresAt` casi siempre ya pasó (TTL de 600 s): el
  // cliente es quien decide deshabilitar el botón, el servidor no la oculta.
  final ChatConfirmation? confirmation;

  const ConversationMessage({
    required this.role,
    required this.content,
    required this.createdAt,
    this.confirmation,
  });

  bool get isUser => role == 'user';

  factory ConversationMessage.fromJson(Map<String, dynamic> json) {
    final rawConfirmation = json['confirmation'] as Map<String, dynamic>?;
    return ConversationMessage(
      role: json['role'] as String? ?? 'user',
      content: json['content'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      confirmation: rawConfirmation != null
          ? ChatConfirmation.fromJson(rawConfirmation)
          : null,
    );
  }
}

class ConversationDetail {
  final String conversationId;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ConversationMessage> messages;

  const ConversationDetail({
    required this.conversationId,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.messages,
  });

  factory ConversationDetail.fromJson(Map<String, dynamic> json) {
    final rawMessages = json['messages'] as List<dynamic>? ?? const [];
    return ConversationDetail(
      conversationId: json['conversation_id'] as String,
      title: json['title'] as String? ?? '',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      messages: rawMessages
          .map((e) => ConversationMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
