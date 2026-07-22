/// Respuesta de `POST /assistant/chat`.
///
/// `history` es el formato de cable (mensajes internos incluyendo tool calls +
/// firmas de Gemini). Lo tratamos como opaco: lo guardamos tal cual y lo
/// reenviamos en el siguiente turno. La UI NO lo interpreta; usa sus propios
/// mensajes de burbuja (ver ChatMessage en assistant_provider.dart).
class AssistantChatResponse {
  final String reply;
  final List<String> toolsUsed;
  final List<dynamic> history;
  final int? remaining;

  const AssistantChatResponse({
    required this.reply,
    required this.toolsUsed,
    required this.history,
    this.remaining,
  });

  factory AssistantChatResponse.fromJson(Map<String, dynamic> json) {
    return AssistantChatResponse(
      reply: (json['reply'] as String? ?? '').trim(),
      toolsUsed: (json['toolsUsed'] as List<dynamic>? ?? const <dynamic>[])
          .map((e) => e.toString())
          .toList(),
      history: json['history'] as List<dynamic>? ?? const <dynamic>[],
      remaining: json['remaining'] as int?,
    );
  }
}
