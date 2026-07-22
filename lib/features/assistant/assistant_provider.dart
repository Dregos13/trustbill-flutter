import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/utils/error_messages.dart';

enum ChatRole { user, assistant }

/// Un mensaje tal como se pinta en pantalla (desacoplado del formato de cable).
class ChatMessage {
  final ChatRole role;
  final String text;
  final bool isError;
  final List<String> toolsUsed;

  const ChatMessage({
    required this.role,
    required this.text,
    this.isError = false,
    this.toolsUsed = const [],
  });
}

class AssistantState {
  /// Mensajes visibles (burbujas).
  final List<ChatMessage> messages;

  /// Historial de cable devuelto por el servidor; se reenvía en cada turno.
  final List<dynamic> history;

  final bool sending;
  final int? remaining;

  const AssistantState({
    this.messages = const [],
    this.history = const [],
    this.sending = false,
    this.remaining,
  });

  bool get isEmpty => messages.isEmpty;

  AssistantState copyWith({
    List<ChatMessage>? messages,
    List<dynamic>? history,
    bool? sending,
    int? remaining,
  }) {
    return AssistantState(
      messages: messages ?? this.messages,
      history: history ?? this.history,
      sending: sending ?? this.sending,
      remaining: remaining ?? this.remaining,
    );
  }
}

final assistantProvider =
    NotifierProvider<AssistantNotifier, AssistantState>(AssistantNotifier.new);

class AssistantNotifier extends Notifier<AssistantState> {
  @override
  AssistantState build() => const AssistantState();

  /// Envía un mensaje del usuario y añade la respuesta del asistente.
  Future<void> send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.sending) return;

    // Optimista: pinta la burbuja del usuario y activa "escribiendo…".
    state = state.copyWith(
      messages: [...state.messages, ChatMessage(role: ChatRole.user, text: trimmed)],
      sending: true,
    );

    try {
      final res = await ref.read(endpointsProvider).assistantChat(
            message: trimmed,
            history: state.history,
          );
      final reply = ChatMessage(
        role: ChatRole.assistant,
        text: res.reply.isEmpty ? '(sin respuesta)' : res.reply,
        toolsUsed: res.toolsUsed,
      );
      state = state.copyWith(
        messages: [...state.messages, reply],
        history: res.history,
        sending: false,
        remaining: res.remaining,
      );
    } catch (e) {
      state = state.copyWith(
        messages: [
          ...state.messages,
          ChatMessage(
            role: ChatRole.assistant,
            text: friendlyError(e),
            isError: true,
          ),
        ],
        sending: false,
      );
    }
  }

  /// Empieza una conversación nueva (limpia burbujas e historial).
  void reset() => state = const AssistantState();
}
