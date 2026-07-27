/// Contrato de `POST /api/v1/chat` contra el gateway trustcore-ai.
///
/// A diferencia del antiguo `/assistant/chat` (ver `assistant.dart`), aquí el
/// servidor lleva el historial por `conversation_id`: el cliente no reenvía
/// nada opaco, solo el mensaje y (si ya existe) el id de la conversación.
library;

enum ChatStatus {
  completed,
  blocked,
  failed;

  static ChatStatus fromJson(String value) => switch (value) {
        'completed' => ChatStatus.completed,
        'blocked' => ChatStatus.blocked,
        'failed' => ChatStatus.failed,
        _ => ChatStatus.failed,
      };
}

/// Acción semántica que el cliente puede ejecutar (hoy solo navegación).
class ChatAction {
  final String type;
  final String screen;
  final Map<String, String> params;

  const ChatAction({
    required this.type,
    required this.screen,
    this.params = const {},
  });

  factory ChatAction.fromJson(Map<String, dynamic> json) {
    final rawParams = json['params'] as Map<String, dynamic>? ?? const {};
    return ChatAction(
      type: json['type'] as String? ?? 'navigate',
      screen: json['screen'] as String? ?? '',
      params: rawParams.map((k, v) => MapEntry(k, v.toString())),
    );
  }
}

/// Confirmación pendiente creada por una tool `prepare_*`. El payload
/// validado nunca sale del servidor: solo vemos id + resumen + caducidad.
class ChatConfirmation {
  final String id;
  final String operation;
  final Map<String, String> summary;
  final DateTime expiresAt;

  const ChatConfirmation({
    required this.id,
    required this.operation,
    required this.summary,
    required this.expiresAt,
  });

  factory ChatConfirmation.fromJson(Map<String, dynamic> json) {
    final rawSummary = json['summary'] as Map<String, dynamic>? ?? const {};
    return ChatConfirmation(
      id: json['id'] as String,
      operation: json['operation'] as String? ?? '',
      summary: rawSummary.map((k, v) => MapEntry(k, v.toString())),
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );
  }
}

/// Fuente de conocimiento (RAG) usada en la respuesta.
class ChatSource {
  final String title;
  final String source;
  final String? section;
  final String? version;

  const ChatSource({
    required this.title,
    required this.source,
    this.section,
    this.version,
  });

  factory ChatSource.fromJson(Map<String, dynamic> json) {
    return ChatSource(
      title: json['title'] as String? ?? '',
      source: json['source'] as String? ?? '',
      section: json['section'] as String?,
      version: json['version'] as String?,
    );
  }
}

/// Consumo agregado de la request; solo informativo, no se muestra en la UI
/// hoy pero queda disponible para depuración/telemetría futura.
class ChatUsage {
  final int llmCalls;
  final int inputTokens;
  final int outputTokens;
  final double? estimatedCostUsd;

  const ChatUsage({
    this.llmCalls = 0,
    this.inputTokens = 0,
    this.outputTokens = 0,
    this.estimatedCostUsd,
  });

  factory ChatUsage.fromJson(Map<String, dynamic> json) {
    return ChatUsage(
      llmCalls: json['llm_calls'] as int? ?? 0,
      inputTokens: json['input_tokens'] as int? ?? 0,
      outputTokens: json['output_tokens'] as int? ?? 0,
      estimatedCostUsd: (json['estimated_cost_usd'] as num?)?.toDouble(),
    );
  }
}

class ChatResponse {
  final String requestId;
  // null solo cuando la peticion se bloqueo antes de abrir conversacion.
  final String? conversationId;
  final ChatStatus status;
  final String answer;
  final List<ChatAction> actions;
  final List<ChatSource> sources;
  final ChatConfirmation? confirmation;
  final String? errorCode;
  final ChatUsage usage;

  const ChatResponse({
    required this.requestId,
    required this.conversationId,
    required this.status,
    required this.answer,
    this.actions = const [],
    this.sources = const [],
    this.confirmation,
    this.errorCode,
    this.usage = const ChatUsage(),
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    final rawActions = json['actions'] as List<dynamic>? ?? const [];
    final rawSources = json['sources'] as List<dynamic>? ?? const [];
    final rawConfirmation = json['confirmation'] as Map<String, dynamic>?;
    final rawUsage = json['usage'] as Map<String, dynamic>?;
    return ChatResponse(
      requestId: json['request_id'] as String? ?? '',
      conversationId: json['conversation_id'] as String?,
      status: ChatStatus.fromJson(json['status'] as String? ?? 'failed'),
      answer: json['answer'] as String? ?? '',
      actions: rawActions
          .map((e) => ChatAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      sources: rawSources
          .map((e) => ChatSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      confirmation: rawConfirmation != null
          ? ChatConfirmation.fromJson(rawConfirmation)
          : null,
      errorCode: json['error_code'] as String?,
      usage: rawUsage != null ? ChatUsage.fromJson(rawUsage) : const ChatUsage(),
    );
  }
}
