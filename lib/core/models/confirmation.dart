/// Contrato de `GET/POST /api/v1/confirmations/{id}` (confirm/cancel) del
/// gateway trustcore-ai. El payload validado de la escritura nunca sale del
/// servidor: solo vemos el resumen legible y el resultado tras confirmar.
library;

class ConfirmationView {
  final String id;
  final String operation;
  final String status;
  final Map<String, String> summary;
  final DateTime createdAt;
  final DateTime expiresAt;
  final DateTime? confirmedAt;
  final DateTime? cancelledAt;

  const ConfirmationView({
    required this.id,
    required this.operation,
    required this.status,
    required this.summary,
    required this.createdAt,
    required this.expiresAt,
    this.confirmedAt,
    this.cancelledAt,
  });

  factory ConfirmationView.fromJson(Map<String, dynamic> json) {
    final rawSummary = json['summary'] as Map<String, dynamic>? ?? const {};
    return ConfirmationView(
      id: json['id'] as String,
      operation: json['operation'] as String? ?? '',
      status: json['status'] as String? ?? '',
      summary: rawSummary.map((k, v) => MapEntry(k, v.toString())),
      createdAt: DateTime.parse(json['created_at'] as String),
      expiresAt: DateTime.parse(json['expires_at'] as String),
      confirmedAt: (json['confirmed_at'] as String?) != null
          ? DateTime.parse(json['confirmed_at'] as String)
          : null,
      cancelledAt: (json['cancelled_at'] as String?) != null
          ? DateTime.parse(json['cancelled_at'] as String)
          : null,
    );
  }
}

/// Resultado de confirmar una escritura: hoy siempre un borrador
/// (`CreatedDraft` en el gateway) — factura o gasto, nunca emitido.
class CreatedDraftResult {
  final String? id;
  final String? kind;
  final String? status;
  final num? total;
  final String? currency;

  const CreatedDraftResult({
    this.id,
    this.kind,
    this.status,
    this.total,
    this.currency,
  });

  factory CreatedDraftResult.fromJson(Map<String, dynamic> json) {
    return CreatedDraftResult(
      id: json['id']?.toString(),
      kind: json['kind'] as String?,
      status: json['status'] as String?,
      // El gateway serializa Decimal como STRING (p. ej. "104.00"); tambien
      // podria llegar como numero. Se acepta cualquiera de los dos.
      total: _parseNum(json['total']),
      currency: json['currency'] as String?,
    );
  }

  static num? _parseNum(dynamic value) {
    if (value == null) return null;
    if (value is num) return value;
    if (value is String) return num.tryParse(value);
    return null;
  }
}

class ConfirmationActionResponse {
  final ConfirmationView confirmation;
  final CreatedDraftResult? result;

  const ConfirmationActionResponse({required this.confirmation, this.result});

  factory ConfirmationActionResponse.fromJson(Map<String, dynamic> json) {
    final rawResult = json['result'];
    return ConfirmationActionResponse(
      confirmation: ConfirmationView.fromJson(
        json['confirmation'] as Map<String, dynamic>,
      ),
      result: rawResult is Map<String, dynamic>
          ? CreatedDraftResult.fromJson(rawResult)
          : null,
    );
  }
}
