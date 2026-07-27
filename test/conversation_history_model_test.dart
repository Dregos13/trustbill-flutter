import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/core/models/conversation_history.dart';

void main() {
  test('parses a conversation summary', () {
    final summary = ConversationSummary.fromJson({
      'conversation_id': 'a5f2b5b0-0000-0000-0000-000000000001',
      'title': 'Cuanto pague el ultimo trimestre?',
      'updated_at': '2026-07-27T10:00:00Z',
      'message_count': 4,
    });

    expect(summary.conversationId, 'a5f2b5b0-0000-0000-0000-000000000001');
    expect(summary.title, 'Cuanto pague el ultimo trimestre?');
    expect(summary.messageCount, 4);
  });

  test('parses a conversation detail with plain and confirmation messages', () {
    final detail = ConversationDetail.fromJson({
      'conversation_id': 'a5f2b5b0-0000-0000-0000-000000000002',
      'title': 'Hazme una factura de 100 euros',
      'created_at': '2026-07-24T10:00:00Z',
      'updated_at': '2026-07-24T10:01:00Z',
      'messages': [
        {
          'role': 'user',
          'content': 'Hazme una factura de 100 euros',
          'created_at': '2026-07-24T10:00:00Z',
        },
        {
          'role': 'assistant',
          'content': 'Confirmalo en la tarjeta.',
          'created_at': '2026-07-24T10:00:05Z',
          'confirmation': {
            'id': 'c1a2b3c4-0000-0000-0000-000000000003',
            'operation': 'create_invoice_draft',
            'summary': {'total': '100,00 €'},
            'expires_at': '2026-07-24T10:10:05Z',
          },
        },
      ],
    });

    expect(detail.messages, hasLength(2));
    expect(detail.messages.first.isUser, isTrue);
    expect(detail.messages.first.confirmation, isNull);

    final assistantMessage = detail.messages.last;
    expect(assistantMessage.isUser, isFalse);
    expect(assistantMessage.confirmation, isNotNull);
    expect(
      assistantMessage.confirmation!.id,
      'c1a2b3c4-0000-0000-0000-000000000003',
    );
    expect(assistantMessage.confirmation!.summary['total'], '100,00 €');
  });

  test('missing confirmation and messages default to empty/null', () {
    final detail = ConversationDetail.fromJson({
      'conversation_id': 'a5f2b5b0-0000-0000-0000-000000000004',
      'title': 'Nueva conversación',
      'created_at': '2026-07-24T10:00:00Z',
      'updated_at': '2026-07-24T10:00:00Z',
    });

    expect(detail.messages, isEmpty);
  });
}
