/// Cómo se lee cada confirmación del asistente según lo que va a hacer.
///
/// Antes esto era un binario dentro de la tarjeta: `isExpense ? gasto : factura`.
/// Cualquier operación que no fuera un gasto se anunciaba como factura, así que
/// al confirmar una TAREA el botón decía "Sí, crear factura", y lo mismo pasaba
/// con los cobros.
///
/// Port de `apps/mobile-web/src/assistant/confirmationCopy.ts` (TrustBill-Mobile):
/// los dos clientes consumen el mismo gateway y tienen que anunciar lo mismo.
/// **Al añadir una tool de escritura nueva en el gateway, añadir su entrada aquí
/// y en la de la web**; hay un test a cada lado que comprueba que no falta
/// ninguna.
library;

class ConfirmationCopy {
  /// Pregunta grande de la tarjeta viva.
  final String question;

  /// Texto del botón principal.
  final String confirm;

  /// Botón mientras la llamada está en vuelo.
  final String working;

  /// Encabezado cuando la operación ya se ejecutó.
  final String done;

  /// Cómo se llama la contraparte de esta operación.
  final String partyLabel;

  /// Nombre de la cosa, para el historial ("Propuesta de tarea").
  final String thing;

  /// Solo cuando el resultado acaba en la bandeja de borradores.
  final bool savesToDrafts;

  const ConfirmationCopy({
    required this.question,
    required this.confirm,
    required this.working,
    required this.done,
    required this.partyLabel,
    required this.thing,
    required this.savesToDrafts,
  });
}

const Map<String, ConfirmationCopy> confirmationCopyByOperation = {
  'create_invoice_draft': ConfirmationCopy(
    question: '¿Crear esta factura?',
    confirm: 'Sí, crear factura',
    working: 'Creando…',
    done: 'Factura creada',
    partyLabel: 'Cliente',
    thing: 'factura',
    savesToDrafts: true,
  ),
  'create_budget': ConfirmationCopy(
    question: '¿Crear este presupuesto?',
    confirm: 'Sí, crear presupuesto',
    working: 'Creando…',
    done: 'Presupuesto creado',
    partyLabel: 'Cliente',
    thing: 'presupuesto',
    savesToDrafts: true,
  ),
  'create_expense_draft': ConfirmationCopy(
    question: '¿Registrar este gasto?',
    confirm: 'Sí, registrar gasto',
    working: 'Registrando…',
    done: 'Gasto registrado',
    partyLabel: 'Proveedor',
    thing: 'gasto',
    savesToDrafts: true,
  ),
  'register_payment': ConfirmationCopy(
    question: '¿Registrar este cobro?',
    confirm: 'Sí, registrar cobro',
    working: 'Registrando…',
    done: 'Cobro registrado',
    partyLabel: 'Cliente',
    thing: 'cobro',
    savesToDrafts: false,
  ),
  'create_task': ConfirmationCopy(
    question: '¿Crear esta tarea?',
    confirm: 'Sí, crear tarea',
    working: 'Creando…',
    done: 'Tarea creada',
    partyLabel: 'Cliente',
    thing: 'tarea',
    savesToDrafts: false,
  ),
  'reschedule_task': ConfirmationCopy(
    question: '¿Mover esta tarea?',
    confirm: 'Sí, moverla',
    working: 'Moviendo…',
    done: 'Tarea movida',
    partyLabel: 'Cliente',
    thing: 'cambio de hora',
    savesToDrafts: false,
  ),
  'set_task_status': ConfirmationCopy(
    question: '¿Cambiar el estado de esta tarea?',
    confirm: 'Sí, cambiarlo',
    working: 'Guardando…',
    done: 'Estado actualizado',
    partyLabel: 'Cliente',
    thing: 'cambio de estado',
    savesToDrafts: false,
  ),
};

/// Texto para una operación que esta versión de la app no conoce todavía.
///
/// No afirma nada: es preferible un "¿Confirmar esta operación?" soso a que el
/// gateway despliegue una tool nueva y la app la anuncie como si fuera otra
/// cosa. La app instalada no se actualiza sola, así que este caso es normal,
/// no excepcional.
const ConfirmationCopy genericConfirmationCopy = ConfirmationCopy(
  question: '¿Confirmar esta operación?',
  confirm: 'Sí, confirmar',
  working: 'Guardando…',
  done: 'Hecho',
  partyLabel: 'Cliente',
  thing: 'operación',
  savesToDrafts: false,
);

ConfirmationCopy confirmationCopyFor(String operation) {
  return confirmationCopyByOperation[operation] ?? genericConfirmationCopy;
}

/// Claves del resumen que no van a las filas de detalle: el nombre de la
/// contraparte ya va en el encabezado, el total se muestra destacado aparte y
/// el resto es ruido para quien solo quiere saber qué va a crear.
const Set<String> hiddenSummaryKeys = {
  'customer',
  'supplier',
  'total',
  'currency',
  'line_count',
};

/// Etiqueta legible de cada clave del resumen que manda el gateway
/// (`summary` de las tools `prepare_*`). Sin esto, la tarjeta enseña la clave
/// en crudo: "when", "duration", "pending_after".
const Map<String, String> summaryLabels = {
  'tax': 'Impuesto',
  'tax_amount': 'Importe del impuesto',
  'subtotal': 'Base',
  'category': 'Categoría',
  'issue_date': 'Fecha',
  'expense_date': 'Fecha',
  'due_date': 'Vencimiento',
  'lines': 'Líneas',
  'method': 'Método',
  'invoice': 'Factura',
  'amount': 'Importe',
  'pending_after': 'Queda pendiente',
  'paid_at': 'Fecha de cobro',
  'task': 'Tarea',
  'when': 'Cuándo',
  'duration': 'Duración',
  'client': 'Cliente',
  'task_id': 'Tarea',
  'new_when': 'Nueva hora',
  'new_duration': 'Nueva duración',
  'new_status': 'Nuevo estado',
};

String summaryLabel(String key) => summaryLabels[key] ?? key;
