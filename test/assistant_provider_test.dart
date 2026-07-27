import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trustinfacts_mobile/core/api/ai_gateway_client.dart';
import 'package:trustinfacts_mobile/core/api/api_client.dart';
import 'package:trustinfacts_mobile/core/auth/auth_provider.dart';
import 'package:trustinfacts_mobile/core/models/chat.dart';
import 'package:trustinfacts_mobile/core/models/conversation_history.dart';
import 'package:trustinfacts_mobile/core/theme/theme_controller.dart';
import 'package:trustinfacts_mobile/features/assistant/assistant_provider.dart';
import 'package:trustinfacts_mobile/features/assistant/assistant_repository.dart';

const _storageKey = 'assistant_conversation_id';

/// No pega a la red: solo devuelve lo que cada test deja preparado. Se
/// construye sobre un [AiGatewayClient] real (barato, sin efectos hasta que
/// se le pida hacer una request) porque `AssistantRepository` no define una
/// interfaz separada para eso.
class _FakeAssistantRepository extends AssistantRepository {
  _FakeAssistantRepository() : super(AiGatewayClient(ApiClient()));

  ChatResponse? nextSendResponse;
  ConversationDetail? conversationToReturn;

  @override
  Future<ChatResponse> sendMessage({
    required String message,
    String? conversationId,
  }) async => nextSendResponse!;

  @override
  Future<ConversationDetail> getConversation(String conversationId) async {
    final detail = conversationToReturn;
    if (detail == null) throw StateError('conversation not found');
    return detail;
  }
}

ProviderContainer _buildContainer(
  _FakeAssistantRepository repo,
  SharedPreferences prefs,
) {
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      assistantRepositoryProvider.overrideWithValue(repo),
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
