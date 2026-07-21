import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/core/models/dashboard.dart';

void main() {
  test('parses mobile dashboard summary sections', () {
    final summary = MobileDashboardSummary.fromJson({
      'month': {
        'label': '01/01 - 31/01',
        'facturado': 1000,
        'facturadoPrev': 500,
        'cobrado': 600,
        'pendiente': 400,
        'gastos': 200,
        'facturasCount': 2,
      },
      'history': [
        {'m': 'Ene', 'ingresos': 1000, 'gastos': 200},
      ],
      'upcoming': [
        {
          'id': 1,
          'invoiceId': 'F-0001',
          'client': 'Cliente Test',
          'amount': 400,
          'dueDate': '2026-01-20T00:00:00.000Z',
          'dueIn': 3,
          'status': 'soon',
        },
      ],
      'topClients': [
        {'id': 1, 'name': 'Cliente Test', 'amount': 1000, 'pct': 100},
      ],
    });

    expect(summary.month.facturado, 1000);
    expect(summary.history.single.gastos, 200);
    expect(summary.upcoming.single.invoiceId, 'F-0001');
    expect(summary.topClients.single.pct, 100);
  });
}
