import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustinfacts_mobile/core/api/ai_gateway_client.dart';
import 'package:trustinfacts_mobile/core/api/api_client.dart';
import 'package:trustinfacts_mobile/core/api/api_error.dart';
import 'package:trustinfacts_mobile/core/auth/auth_provider.dart';
import 'package:trustinfacts_mobile/core/cache/cache_providers.dart';
import 'package:trustinfacts_mobile/core/models/chat.dart';
import 'package:trustinfacts_mobile/core/models/conversation_history.dart';
import 'package:trustinfacts_mobile/core/theme/theme_controller.dart';
import 'package:trustinfacts_mobile/features/assistant/assistant_provider.dart';
import 'package:trustinfacts_mobile/features/assistant/assistant_repository.dart';

/// El id persistido se guarda **por empresa**: `assistant_conversation_id:<scope>`,
/// donde el scope es el mismo `tenant:companyId` que usa la cache. Antes era una
/// sola clave global, asi que al cambiar de empresa se seguia enviando el id de
/// la conversacion de la anterior.
const _scopeEmpresaA = 'tenant-a:3';
const _scopeEmpresaB = 'tenant-a:4';
const _storageKey = 'assistant_conversation_id:$_scopeEmpresaA';

/// No pega a la red: solo devuelve lo que cada test deja preparado. Se
/// construye sobre un [AiGatewayClient] real (barato, sin efectos hasta que
/// se le pida hacer una request) porque `AssistantRepository` no define una
/// interfaz separada para eso.
class _FakeAssistantRepository extends AssistantRepository {
  _FakeAssistantRepository() : super(AiGatewayClient(ApiClient()));

  ChatResponse? nextSendResponse;
  ConversationDetail? conversationToReturn;
  /// Error concreto que devuelve `getConversation`, para distinguir "no existe"
  /// (se descarta el id) de un fallo de red (se conserva).
  Object? getConversationError;

  @override
  Future<ChatResponse> sendMessage({
    required String message,
    String? conversationId,
  }) async => nextSendResponse!;

  @override
  Future<ConversationDetail> getConversation(String conversationId) async {
    final error = getConversationError;
    if (error != null) throw error;
    final detail = conversationToReturn;
    if (detail == null) throw StateError('conversation not found');
    return detail;
  }
}

ProviderContainer _buildContainer(
  _FakeAssistantRepository repo,
  SharedPreferences prefs, {
  String scope = _scopeEmpresaA,
}) {
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      assistantRepositoryProvider.overrideWithValue(repo),
      // Fijado a proposito: el scope decide bajo que clave se guarda el id, y
      // es lo que separa el chat de una empresa del de otra.
      cacheScopeProvider.overrideWithValue(scope),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('send() persists the conversation id returned by the server', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repo = _FakeAssistantRepository()
      ..nextSendResponse = const ChatResponse(
        requestId: 'r1',
        conversationId: 'conv-1',
        status: ChatStatus.completed,
        answer: 'Hola',
      );
    final container = _buildContainer(repo, prefs);

    await container.read(assistantProvider.notifier).send('Hola');

    expect(prefs.getString(_storageKey), 'conv-1');
    expect(container.read(assistantProvider).conversationId, 'conv-1');
  });

  test('reset() clears the persisted conversation id', () async {
    SharedPreferences.setMockInitialValues({_storageKey: 'conv-old'});
    final prefs = await SharedPreferences.getInstance();
    final repo = _FakeAssistantRepository();
    final container = _buildContainer(repo, prefs);
    // Deja que la hidratacion en segundo plano del id persistido termine
    // antes de resetear, para no dejar un microtask colgando.
    await Future<void>.delayed(Duration.zero);

    container.read(assistantProvider.notifier).reset();

    expect(prefs.getString(_storageKey), isNull);
    expect(container.read(assistantProvider).conversationId, isNull);
  });

  test(
    'a conversation id persisted from a previous app run is hydrated with its messages',
    () async {
      SharedPreferences.setMockInitialValues({_storageKey: 'conv-old'});
      final prefs = await SharedPreferences.getInstance();
      final repo = _FakeAssistantRepository()
        ..conversationToReturn = ConversationDetail(
          conversationId: 'conv-old',
          title: 'Cuanto pague el ultimo trimestre?',
          createdAt: DateTime.utc(2026, 7, 24),
          updatedAt: DateTime.utc(2026, 7, 24),
          messages: [
            ConversationMessage(
              role: 'user',
              content: 'Cuanto pague el ultimo trimestre?',
              createdAt: DateTime.utc(2026, 7, 24),
            ),
          ],
        );
      final container = _buildContainer(repo, prefs);

      // Justo tras construir, el id ya esta aplicado (para que send() no
      // abra una conversacion nueva) pero las burbujas aun no han llegado.
      expect(container.read(assistantProvider).conversationId, 'conv-old');
      expect(container.read(assistantProvider).messages, isEmpty);

      await Future<void>.delayed(Duration.zero);

      final hydrated = container.read(assistantProvider);
      expect(hydrated.messages, hasLength(1));
      expect(hydrated.messages.single.text, 'Cuanto pague el ultimo trimestre?');
    },
  );

  test(
    'a persisted id for a conversation that no longer exists fails silently',
    () async {
      SharedPreferences.setMockInitialValues({_storageKey: 'conv-deleted'});
      final prefs = await SharedPreferences.getInstance();
      final repo = _FakeAssistantRepository(); // conversationToReturn queda null -> lanza
      final container = _buildContainer(repo, prefs);

      await Future<void>.delayed(Duration.zero);

      final state = container.read(assistantProvider);
      expect(state.conversationId, 'conv-deleted');
      expect(state.messages, isEmpty);
    },
  );

  test('cada empresa arranca con su propio hilo, no con el de la otra', () async {
    // El id guardado por la empresa A no se aplica al abrir el chat en la B.
    SharedPreferences.setMockInitialValues({_storageKey: 'conv-de-la-a'});
    final prefs = await SharedPreferences.getInstance();
    final repo = _FakeAssistantRepository();

    final enB = _buildContainer(repo, prefs, scope: _scopeEmpresaB);
    expect(enB.read(assistantProvider).conversationId, isNull);

    // Y lo que se envie desde B se guarda bajo la clave de B, sin pisar la de A.
    repo.nextSendResponse = const ChatResponse(
      requestId: 'r1',
      conversationId: 'conv-de-la-b',
      status: ChatStatus.completed,
      answer: 'Hola',
    );
    await enB.read(assistantProvider.notifier).send('Hola');

    expect(
      prefs.getString('assistant_conversation_id:$_scopeEmpresaB'),
      'conv-de-la-b',
    );
    expect(prefs.getString(_storageKey), 'conv-de-la-a');
  });

  test('un id que el gateway ya no reconoce se descarta', () async {
    // Pasa al cambiar de empresa con un id viejo, o si la conversacion se
    // purgo. Conservarlo haria fallar el siguiente mensaje.
    SharedPreferences.setMockInitialValues({_storageKey: 'conv-de-otra-empresa'});
    final prefs = await SharedPreferences.getInstance();
    final repo = _FakeAssistantRepository()
      ..getConversationError = ApiError(
        status: 404,
        code: 'CONVERSATION_NOT_FOUND',
        message: 'no existe',
      );
    final container = _buildContainer(repo, prefs);
    // Leer monta el provider: hasta entonces `build()` no corre y la
    // hidratacion en segundo plano ni siquiera se ha programado.
    expect(container.read(assistantProvider).conversationId, 'conv-de-otra-empresa');

    await Future<void>.delayed(Duration.zero);

    expect(container.read(assistantProvider).conversationId, isNull);
    expect(prefs.getString(_storageKey), isNull);
  });

  test('continueConversation() replaces the state and persists the id', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repo = _FakeAssistantRepository();
    final container = _buildContainer(repo, prefs);

    await container.read(assistantProvider.notifier).continueConversation(
      ConversationDetail(
        conversationId: 'conv-2',
        title: 'Otra vieja',
        createdAt: DateTime.utc(2026, 7, 20),
        updatedAt: DateTime.utc(2026, 7, 20),
        messages: [
          ConversationMessage(
            role: 'user',
            content: 'Hola otra vez',
            createdAt: DateTime.utc(2026, 7, 20),
          ),
        ],
      ),
    );

    final state = container.read(assistantProvider);
    expect(state.conversationId, 'conv-2');
    expect(state.messages.single.text, 'Hola otra vez');
    expect(prefs.getString(_storageKey), 'conv-2');
  });
}
