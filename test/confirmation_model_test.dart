import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/core/models/confirmation.dart';

void main() {
  test('parses a confirmed action response with a created invoice draft', () {
    final response = ConfirmationActionResponse.fromJson({
      'confirmation': {
        'id': 'c1a2b3c4-0000-0000-0000-000000000006',
        'operation': 'create_invoice_draft',
        'status': 'confirmed',
        'summary': {'customer': 'Clinica Dental', 'total': '312.00'},
        'created_at': '2026-07-24T07:42:07.633363Z',
        'expires_at': '2026-07-24T07:52:07.633363Z',
        'confirmed_at': '2026-07-24T07:42:07.916870Z',
        'cancelled_at': null,
      },
      // El gateway serializa Decimal como STRING; el cliente debe aceptarlo.
      'result': {
        'id': '43',
        'kind': 'invoice',
        'status': 'draft',
        'total': '312.00',
        'currency': 'EUR',
      },
    });

    expect(response.confirmation.status, 'confirmed');
    expect(response.confirmation.confirmedAt, isNotNull);
    expect(response.confirmation.cancelledAt, isNull);
    expect(response.result, isNotNull);
    expect(response.result!.kind, 'invoice');
    expect(response.result!.total, 312.0);
    expect(response.result!.currency, 'EUR');
  });

  test('accepts a numeric total too (defensive)', () {
    final response = ConfirmationActionResponse.fromJson({
      'confirmation': {
        'id': 'c1a2b3c4-0000-0000-0000-000000000099',
        'operation': 'create_expense_draft',
        'status': 'confirmed',
        'summary': {'total': '42.30'},
        'created_at': '2026-07-24T07:42:07.633363Z',
        'expires_at': '2026-07-24T07:52:07.633363Z',
        'confirmed_at': '2026-07-24T07:42:07.916870Z',
      },
      'result': {'id': '88', 'kind': 'expense', 'status': 'recorded', 'total': 42.3},
    });

    expect(response.result!.total, 42.3);
  });

  test('parses a cancelled action response with a null result', () {
    final response = ConfirmationActionResponse.fromJson({
      'confirmation': {
        'id': 'c1a2b3c4-0000-0000-0000-000000000007',
        'operation': 'create_expense_draft',
        'status': 'cancelled',
        'summary': {'supplier': 'Suministros SL', 'total': '42.30'},
        'created_at': '2026-07-24T07:42:07.633363Z',
        'expires_at': '2026-07-24T07:52:07.633363Z',
        'confirmed_at': null,
        'cancelled_at': '2026-07-24T07:43:00.000000Z',
      },
      'result': null,
    });

    expect(response.confirmation.status, 'cancelled');
    expect(response.confirmation.cancelledAt, isNotNull);
    expect(response.result, isNull);
  });

  test('parses a bare confirmation view', () {
    final view = ConfirmationView.fromJson({
      'id': 'c1a2b3c4-0000-0000-0000-000000000008',
      'operation': 'create_invoice_draft',
      'status': 'pending',
      'summary': {'total': '100.00'},
      'created_at': '2026-07-24T07:42:07.633363Z',
      'expires_at': '2026-07-24T07:52:07.633363Z',
    });

    expect(view.status, 'pending');
    expect(view.summary['total'], '100.00');
    expect(view.confirmedAt, isNull);
  });
}
