# Release Notes

## v1.1.3 (build 13) — 2026-06-14

End-to-end document lifecycle: Presupuestos, Ventas y Facturas now flow from
quote to legally numbered invoice, fully from the phone.

### Novedades (texto para Google Play)

Novedades de esta versión:

- Presupuestos: crea, acepta o rechaza presupuestos desde el móvil.
- Ventas: convierte un presupuesto en venta y factúrala en un toque.
- Ciclo de la factura: confírmala y emítela con su número legal definitivo; las facturas emitidas quedan bloqueadas.
- Estados más claros, con etiquetas de color en presupuestos, ventas y facturas.
- Mensajes de error más comprensibles.

### Features

- **Presupuestos (budgets).** List, detail, and creation screens. From a budget
  you can now **Aceptar** or **Rechazar** (rejecting releases the reserved
  stock), and **Convertir en venta**. Rejection routes through a confirmation
  dialog and is irreversible.
- **Ventas (sales).** List, detail, and creation screens, including converting a
  budget into a sale and invoicing a sale ("Facturar venta").
- **Invoice lifecycle.** A draft invoice can be **Confirmada** (consumes stock
  server-side) and then **Emitida** ("Finalizar / Emitir"), which assigns the
  definitive legal series number (F{co}-{yy}) and locks the document. Finalizing
  is guarded by an explicit irreversible-action dialog. It does not send to AEAT.
- **DocTypeSwitcher.** Segmented control to move between Presupuestos, Ventas, and
  Facturas.

### Improvements

- **Status badges** unified across documents with colour plus label (never colour
  alone): invoices (BORRADOR / CONFIRMADA / EMITIDA / PAGADA / ANULADA), budgets
  (PENDIENTE / ACEPTADO / RECHAZADO), and sales (ABIERTA / PARCIAL / CERRADA /
  PERDIDA). EMITIDA uses a distinct indigo to separate it from CONFIRMADA.
- **Invoices filter** gains the "Emitida" (final) state.
- Lifecycle buttons show an inline loading state and disable while a request is in
  flight; all errors surface through `friendlyError()` so server messages (404 /
  409 / insufficient stock) are shown in plain language.

### Internal / notes

- No backend, schema, or numbering changes. The legal invoice number is assigned
  by the server on finalize.
- New API endpoints consumed: `POST /invoices/:id/confirm`,
  `POST /invoices/:id/finalize`, `POST /budgets/:id/accept`,
  `POST /budgets/:id/reject`.
- Verified: `flutter analyze` clean (no new issues), release APK and App Bundle
  build successfully.

### Artifacts

- APK: `build/app/outputs/flutter-apk/app-release.apk`
- App Bundle: `build/app/outputs/bundle/release/app-release.aab`
