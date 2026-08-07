import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/api/api_error.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/cache/cache_providers.dart';
import '../../core/models/chat.dart';
import '../../core/models/confirmation.dart';
import '../../core/models/conversation_history.dart';
import '../../core/theme/theme_controller.dart' show sharedPreferencesProvider;
import '../../core/utils/error_messages.dart';
import 'assistant_repository.dart';

enum ChatRole { user, assistant }

/// Fase H.2: el id vive también en disco, no solo en memoria del provider,
/// para que un reinicio en frío de la app pueda recuperar la conversación
/// (releer su historial cuesta $0, no hay llamada al LLM de por medio).
const _conversationIdStorageKeyPrefix = 'assistant_conversation_id';

/// Clave del id persistido, **por empresa**.
///
/// Antes era una sola clave global: al cambiar de empresa se seguia enviando
/// el id de la conversacion de la anterior. El gateway acota el historial por
/// (tenant, usuario, empresa), asi que ese id ya no es valido aqui — y guardar
/// uno por empresa es ademas lo que espera el usuario: cada empresa, su chat.
String _conversationIdKey(String scope) => '$_conversationIdStorageKeyPrefix:$scope';

/// Estado de una confirmación de escritura pendiente en el chat (Fase 8 del
/// gateway): el usuario ve el resumen y confirma o cancela desde la propia
/// burbuja; nada se ejecuta hasta que él lo decide.
enum ConfirmationUiStatus { pending, working, confirmed, cancelled, failed }

class PendingConfirmationView {
  final String id;
  final String operation;
  final Map<String, String> summary;
  final DateTime expiresAt;
  final ConfirmationUiStatus status;
  final String? resultLine;
  final String? errorMessage;

  const PendingConfirmationView({
    required this.id,
    required this.operation,
    required this.summary,
    required this.expiresAt,
    this.status = ConfirmationUiStatus.pending,
    this.resultLine,
    this.errorMessage,
  });

  PendingConfirmationView copyWith({
    ConfirmationUiStatus? status,
    String? resultLine,
    String? errorMessage,
  }) {
    return PendingConfirmationView(
      id: id,
      operation: operation,
      summary: summary,
      expiresAt: expiresAt,
      status: status ?? this.status,
      resultLine: resultLine ?? this.resultLine,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Acción de navegación semántica propuesta por el asistente.
class ChatNavigateAction {
  final String screen;
  final String? entityId;
  const ChatNavigateAction({required this.screen, this.entityId});
}

/// Un mensaje tal como se pinta en pantalla (desacoplado del formato de cable).
class ChatMessage {
  final ChatRole role;
  final String text;
  final bool isError;
  final List<ChatSource> sources;
  // Si no es null, la burbuja renderiza la tarjeta de confirmación viva
  // (state.confirmations[confirmationId]) bajo el texto.
  final String? confirmationId;

  const ChatMessage({
    required this.role,
    required this.text,
    this.isError = false,
    this.sources = const [],
    this.confirmationId,
  });
}

class AssistantState {
  final List<ChatMessage> messages;
  final String? conversationId;
  final bool sending;
  final Map<String, PendingConfirmationView> confirmations;
  final ChatNavigateAction? pendingNavigation;

  const AssistantState({
    this.messages = const [],
    this.conversationId,
    this.sending = false,
    this.confirmations = const {},
    this.pendingNavigation,
  });

  bool get isEmpty => messages.isEmpty;

  AssistantState copyWith({
    List<ChatMessage>? messages,
    String? conversationId,
    bool? sending,
    Map<String, PendingConfirmationView>? confirmations,
    ChatNavigateAction? pendingNavigation,
    bool clearPendingNavigation = false,
  }) {
    return AssistantState(
      messages: messages ?? this.messages,
      conversationId: conversationId ?? this.conversationId,
      sending: sending ?? this.sending,
      confirmations: confirmations ?? this.confirmations,
      pendingNavigation: clearPendingNavigation
          ? null
          : (pendingNavigation ?? this.pendingNavigation),
    );
  }
}

final assistantProvider =
    NotifierProvider<AssistantNotifier, AssistantState>(AssistantNotifier.new);

class AssistantNotifier extends Notifier<AssistantState> {
  // `late` a secas, NO `late final`: al cambiar de empresa cambia el scope y
  // Riverpod re-ejecuta `build()` sobre la MISMA instancia del notifier. Con
  // `late final`, esa segunda asignacion lanza LateInitializationError y la
  // pantalla del asistente se queda en blanco. Visto en el dispositivo.
  late AssistantRepository _repo;
  late SharedPreferences _prefs;

  /// Clave del id persistido para la empresa activa. Se resuelve en `build()`
  /// y no despues de un `await`: el `Ref` puede estar ya desechado para
  /// entonces, y ademas asi la clave no cambia a mitad de una operacion.
  late String _storageKey;

  @override
  AssistantState build() {
    _repo = ref.read(assistantRepositoryProvider);
    _prefs = ref.read(sharedPreferencesProvider);
    // `watch`, no `read`: al cambiar de empresa el scope cambia, el notifier se
    // reconstruye y el chat arranca con el hilo de la empresa nueva.
    _storageKey = _conversationIdKey(ref.watch(cacheScopeProvider));

    final storedId = _prefs.getString(_storageKey);
    if (storedId == null) return const AssistantState();

    // build() no puede ser async: el id persistido se aplica ya (para que
    // `send()` continue la conversacion correcta aunque el usuario escriba
    // antes de que termine de cargar), y las burbujas viejas llegan cuando
    // responda /api/v1/conversations/{id}.
    Future.microtask(() => _hydrateFromStorage(storedId));
    return AssistantState(conversationId: storedId);
  }

  Future<void> _hydrateFromStorage(String conversationId) async {
    // La clave de esta hidratacion, capturada antes del await: si mientras
    // tanto se cambia de empresa, el notifier se reconstruye y `_storageKey`
    // ya apunta a otra. Borrar entonces con la clave nueva tirararia el hilo
    // de la empresa equivocada.
    final key = _storageKey;
    final prefs = _prefs;
    try {
      final detail = await _repo.getConversation(conversationId);
      // El provider puede haberse reconstruido o desechado durante la espera
      // (cambio de empresa, salir de la pantalla). Tocar `state` entonces
      // lanza "Cannot use the Ref after it has been disposed".
      if (!ref.mounted) return;
      state = state.copyWith(
        messages: [..._messagesFrom(detail), ...state.messages],
        conversationId: detail.conversationId,
      );
    } on ApiError catch (e) {
      if (e.code == 'CONVERSATION_NOT_FOUND') {
        // El id guardado ya no vale: purgado, o de una empresa que ya no es la
        // activa. Conservarlo haria que el siguiente mensaje fallase, porque el
        // gateway rechaza continuar una conversacion fuera de ambito. Se tira y
        // se empieza una nueva.
        await prefs.remove(key);
        if (!ref.mounted) return;
        state = const AssistantState();
        return;
      }
      // Otro error de API: se sigue con el id, puede ser algo pasajero.
    } catch (_) {
      // Best-effort: si falla la red, se sigue con el id persistido pero sin
      // burbujas antiguas.
    }
  }

  /// Fase H.2: abre una conversación vieja en la pantalla de chat normal
  /// para seguir escribiendo. Las tarjetas de confirmación de esos mensajes
  /// no se reconstruyen aquí (su TTL de 600s ya pasó de sobra); si el
  /// usuario todavía necesita esa operación, se lo puede volver a pedir al
  /// asistente.
  Future<void> continueConversation(ConversationDetail detail) async {
    await _prefs.setString(_storageKey, detail.conversationId);
    state = AssistantState(
      conversationId: detail.conversationId,
      messages: _messagesFrom(detail),
    );
  }

  List<ChatMessage> _messagesFrom(ConversationDetail detail) {
    return [
      for (final message in detail.messages)
        ChatMessage(
          role: message.isUser ? ChatRole.user : ChatRole.assistant,
          text: message.content,
        ),
    ];
  }

  /// Envía un mensaje del usuario y añade la respuesta del asistente. El
  /// texto de `answer` ya es legible tal cual venga (completed/blocked/
  /// failed): solo los fallos de red/HTTP se pintan como burbuja de error.
  Future<void> send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.sending) return;

    state = state.copyWith(
      messages: [
        ...state.messages,
        ChatMessage(role: ChatRole.user, text: trimmed),
      ],
      sending: true,
    );

    try {
      final res = await _repo.sendMessage(
        message: trimmed,
        conversationId: state.conversationId,
      );

      final confirmations =
          Map<String, PendingConfirmationView>.from(state.confirmations);
      String? confirmationId;
      final confirmation = res.confirmation;
      if (confirmation != null) {
        confirmations[confirmation.id] = PendingConfirmationView(
          id: confirmation.id,
          operation: confirmation.operation,
          summary: confirmation.summary,
          expiresAt: confirmation.expiresAt,
        );
        confirmationId = confirmation.id;
      }

      ChatAction? navigate;
      for (final action in res.actions) {
        if (action.type == 'navigate' && action.screen.isNotEmpty) {
          navigate = action;
          break;
        }
      }

      final reply = ChatMessage(
        role: ChatRole.assistant,
        text: res.answer.isEmpty ? '(sin respuesta)' : res.answer,
        sources: res.sources,
        confirmationId: confirmationId,
      );

      final resolvedConversationId = res.conversationId ?? state.conversationId;
      if (resolvedConversationId != null) {
        await _prefs.setString(_storageKey, resolvedConversationId);
      }

      state = state.copyWith(
        messages: [...state.messages, reply],
        conversationId: res.conversationId ?? state.conversationId,
        sending: false,
        confirmations: confirmations,
        pendingNavigation: navigate != null
            ? ChatNavigateAction(
                screen: navigate.screen,
                entityId: navigate.params['entity_id'],
              )
            : null,
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

  Future<void> confirmPending(String id) async {
    _setConfirmationStatus(id, ConfirmationUiStatus.working);
    try {
      final res = await _repo.confirm(id);
      _updateConfirmation(
        id,
        status: ConfirmationUiStatus.confirmed,
        resultLine: _resultLine(res),
      );
    } catch (e) {
      _updateConfirmation(
        id,
        status: ConfirmationUiStatus.failed,
        errorMessage: _confirmationErrorMessage(e),
      );
    }
  }

  Future<void> cancelPending(String id) async {
    _setConfirmationStatus(id, ConfirmationUiStatus.working);
    try {
      await _repo.cancel(id);
      _updateConfirmation(id, status: ConfirmationUiStatus.cancelled);
    } catch (e) {
      _updateConfirmation(
        id,
        status: ConfirmationUiStatus.failed,
        errorMessage: _confirmationErrorMessage(e),
      );
    }
  }

  /// Consumida por la pantalla justo después de navegar, para no disparar la
  /// misma navegación otra vez en el siguiente rebuild.
  void consumePendingNavigation() {
    state = state.copyWith(clearPendingNavigation: true);
  }

  /// Empieza una conversación nueva (limpia burbujas, historial y confirmaciones).
  void reset() {
    _prefs.remove(_storageKey);
    state = const AssistantState();
  }

  void _setConfirmationStatus(String id, ConfirmationUiStatus status) {
    final current = state.confirmations[id];
    if (current == null) return;
    final updated = Map<String, PendingConfirmationView>.from(state.confirmations);
    updated[id] = current.copyWith(status: status);
    state = state.copyWith(confirmations: updated);
  }

  void _updateConfirmation(
    String id, {
    required ConfirmationUiStatus status,
    String? resultLine,
    String? errorMessage,
  }) {
    final current = state.confirmations[id];
    if (current == null) return;
    final updated = Map<String, PendingConfirmationView>.from(state.confirmations);
    updated[id] = current.copyWith(
      status: status,
      resultLine: resultLine,
      errorMessage: errorMessage,
    );
    state = state.copyWith(confirmations: updated);
  }

  // Importe del documento ya creado, formateado en euros (la cabecera de la
  // tarjeta ya dice "Factura creada"/"Gasto registrado", así que aquí solo
  // interesa el importe).
  String? _resultLine(ConfirmationActionResponse res) {
    final total = res.result?.total;
    if (total == null) return null;
    return '${total.toStringAsFixed(2).replaceAll('.', ',')} €';
  }
}

/// Mensajes en español para los códigos propios del ciclo de vida de una
/// confirmación; cualquier otro código (red, desconocido) cae en friendlyError.
String _confirmationErrorMessage(Object e) {
  switch (_errorCode(e)) {
    case 'CONFIRMATION_NOT_FOUND':
      return 'Esta confirmación ya no está disponible.';
    case 'CONFIRMATION_ALREADY_USED':
      return 'Esta operación ya se confirmó antes.';
    case 'CONFIRMATION_CANCELLED':
      return 'Esta operación fue cancelada.';
    case 'CONFIRMATION_EXPIRED':
      return 'El tiempo para confirmar esta operación expiró.';
    case 'CONFIRMATION_COMPANY_MISMATCH':
      return 'Esta operación no pertenece a esta empresa.';
    case 'CONFIRMATION_PAYLOAD_MISMATCH':
      return 'Los datos de la operación cambiaron; pídesela de nuevo al asistente.';
    case 'CONFIRMATION_EXECUTION_FAILED':
      return 'No se pudo completar la operación. Puedes intentarlo de nuevo.';
    default:
      return friendlyError(e);
  }
}

String? _errorCode(Object e) {
  if (e is ApiError) return e.code;
  if (e is DioException && e.error is ApiError) return (e.error as ApiError).code;
  return null;
}
