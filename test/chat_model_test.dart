import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/core/models/chat.dart';

void main() {
  test('parses a completed chat response with a navigate action and sources', () {
    final response = ChatResponse.fromJson({
      'request_id': 'a5f2b5b0-0000-0000-0000-000000000001',
      'conversation_id': 'a5f2b5b0-0000-0000-0000-000000000002',
      'status': 'completed',
      'answer': 'Tienes 2 facturas pendientes.',
      'actions': [
        {
          'type': 'navigate',
          'screen': 'trustinfacts.invoices.list',
          'params': <String, dynamic>{},
        },
      ],
      'sources': [
        {
          'title': 'IPSI en Ceuta y Melilla',
          'source': 'knowledge/fiscalidad-ipsi.md',
          'section': 'Declaracion',
          'version': '1.0.0',
        },
      ],
      'confirmation': null,
      'error_code': null,
      'usage': {
        'llm_calls': 2,
        'input_tokens': 500,
        'output_tokens': 80,
        'estimated_cost_usd': 0.0044,
      },
    });

    expect(response.status, ChatStatus.completed);
    expect(response.answer, 'Tienes 2 facturas pendientes.');
    expect(response.conversationId, 'a5f2b5b0-0000-0000-0000-000000000002');
    expect(response.actions.single.screen, 'trustinfacts.invoices.list');
    expect(response.sources.single.title, 'IPSI en Ceuta y Melilla');
    expect(response.confirmation, isNull);
    expect(response.usage.estimatedCostUsd, 0.0044);
  });

  test('parses a blocked response with null conversation_id', () {
    final response = ChatResponse.fromJson({
      'request_id': 'a5f2b5b0-0000-0000-0000-000000000003',
      'conversation_id': null,
      'status': 'blocked',
      'answer': 'No puedo ayudarte con esa peticion.',
      'error_code': 'FORBIDDEN_REQUEST_SECRETS',
    });

    expect(response.status, ChatStatus.blocked);
    expect(response.conversationId, isNull);
    expect(response.errorCode, 'FORBIDDEN_REQUEST_SECRETS');
    expect(response.actions, isEmpty);
    expect(response.sources, isEmpty);
  });

  test('parses a response carrying a pending confirmation', () {
    final response = ChatResponse.fromJson({
      'request_id': 'a5f2b5b0-0000-0000-0000-000000000004',
      'conversation_id': 'a5f2b5b0-0000-0000-0000-000000000005',
      'status': 'completed',
      'answer': 'Te dejo el borrador listo para confirmar.',
      'confirmation': {
        'id': 'c1a2b3c4-0000-0000-0000-000000000006',
        'operation': 'create_invoice_draft',
        'summary': {'customer': 'Clinica Dental', 'total': '312.00'},
        'expires_at': '2026-07-24T07:52:07.633363Z',
      },
    });

    final confirmation = response.confirmation;
    expect(confirmation, isNotNull);
    expect(confirmation!.id, 'c1a2b3c4-0000-0000-0000-000000000006');
    expect(confirmation.operation, 'create_invoice_draft');
    expect(confirmation.summary['total'], '312.00');
    expect(confirmation.expiresAt.isUtc, isTrue);
  });

  test('missing status falls back to failed', () {
    final response = ChatResponse.fromJson({
      'request_id': 'a5f2b5b0-0000-0000-0000-000000000007',
      'conversation_id': null,
      'answer': '',
    });

    expect(response.status, ChatStatus.failed);
  });
}
