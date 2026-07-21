import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/core/models/expense.dart';
import 'package:trustinfacts_mobile/core/models/scan_result.dart';
import 'package:trustinfacts_mobile/features/scan/scan_provider.dart';
import 'package:trustinfacts_mobile/features/scan/scan_review_screen.dart';

void main() {
  testWidgets('allows editing detected expense lines before confirming', (
    tester,
  ) async {
    SupplierInvoiceConfirmPayload? submitted;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          scanProvider.overrideWith(
            () => _ReviewScanNotifier(
              onConfirm: (payload) => submitted = payload,
            ),
          ),
        ],
        child: const MaterialApp(home: ScanReviewScreen()),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Líneas detectadas (1)'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(find.text('Tornillo OCR'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('scan-line-description-0')),
      'Tornillo corregido',
    );
    await tester.enterText(
      find.byKey(const ValueKey('scan-line-quantity-0')),
      '2',
    );
    await tester.enterText(
      find.byKey(const ValueKey('scan-line-unit-price-0')),
      '12,50',
    );
    await tester.enterText(
      find.byKey(const ValueKey('scan-line-tax-rate-0')),
      '10',
    );

    await tester.scrollUntilVisible(
      find.text('Registrar factura'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Registrar factura'));
    await tester.pump();

    expect(submitted, isNotNull);
    expect(submitted!.lines, hasLength(1));
    expect(submitted!.lines.first['description'], 'Tornillo corregido');
    expect(submitted!.lines.first['base'], 25);
    expect(submitted!.lines.first['taxRate'], 10);
    expect(submitted!.lines.first['taxAmount'], 2.5);
  });

  testWidgets('parses European thousands and decimal separators in amounts', (
    tester,
  ) async {
    SupplierInvoiceConfirmPayload? submitted;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          scanProvider.overrideWith(
            () => _ReviewScanNotifier(
              onConfirm: (payload) => submitted = payload,
            ),
          ),
        ],
        child: const MaterialApp(home: ScanReviewScreen()),
      ),
    );

    await tester.scrollUntilVisible(
      find.widgetWithText(TextFormField, 'Total'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Total'),
      '1.234,56',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Impuesto / IVA'),
      '234,56',
    );
    await tester.scrollUntilVisible(
      find.text('Líneas detectadas (1)'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('scan-line-quantity-0')),
      '1',
    );
    await tester.enterText(
      find.byKey(const ValueKey('scan-line-unit-price-0')),
      '1.234,56',
    );
    await tester.enterText(
      find.byKey(const ValueKey('scan-line-tax-rate-0')),
      '21',
    );

    await tester.scrollUntilVisible(
      find.text('Registrar factura'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Registrar factura'));
    await tester.pump();

    expect(submitted, isNotNull);
    expect(submitted!.total, 1493.82);
    expect(submitted!.tax, 259.26);
    expect(submitted!.lines.first['base'], 1234.56);
  });

  testWidgets('sends payment date when OCR expense is marked as paid', (
    tester,
  ) async {
    SupplierInvoiceConfirmPayload? submitted;

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          scanProvider.overrideWith(
            () => _ReviewScanNotifier(
              onConfirm: (payload) => submitted = payload,
            ),
          ),
        ],
        child: const MaterialApp(home: ScanReviewScreen()),
      ),
    );

    await tester.scrollUntilVisible(
      find.text('Pendiente'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pendiente').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pagada').last);
    await tester.pumpAndSettle();

    expect(find.widgetWithText(TextFormField, 'Fecha de pago'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Registrar factura'),
      500,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Registrar factura'));
    await tester.pump();

    expect(submitted, isNotNull);
    expect(submitted!.status, 'PAID');
    expect(submitted!.paidAt, '2026-07-10T12:00:00.000Z');
  });
}

class _ReviewScanNotifier extends ScanNotifier {
  _ReviewScanNotifier({required this.onConfirm});

  final void Function(SupplierInvoiceConfirmPayload payload) onConfirm;

  @override
  ScanState build() => ScanState(
    result: const ScanResult(
      supplierName: 'Proveedor Test',
      invoiceNumber: 'F-1',
      date: '2026-07-10T12:00:00.000Z',
      lines: [
        OcrLineItem(
          description: 'Tornillo OCR',
          quantity: 1,
          unitPrice: 10,
          taxRate: 21,
          total: 12.1,
        ),
      ],
      total: 12.1,
      taxAmount: 2.1,
      confidence: 0.7,
    ),
    imageBytes: Uint8List.fromList([1, 2, 3]),
    imageMimeType: 'image/jpeg',
  );

  @override
  Future<void> confirmExpense(SupplierInvoiceConfirmPayload payload) async {
    onConfirm(payload);
  }
}
