# Cambios de API a sincronizar desde la PWA

Este documento resume los cambios y criterios de API aplicados durante la recuperación de la PWA para mantener alineadas las apps Flutter, escritorio y web.

## Fiscalidad e historial fiscal

- La PWA debe mostrar modelos presentados desde el historial fiscal persistido, no recalcularlos para el listado historico.
- El importe mostrado de cada modelo presentado debe salir de sus casillas resultado persistidas:
  - Modelo 001: usar la casilla de importe a ingresar/resultante del propio modelo presentado.
  - Modelo 130: usar la casilla 19 como resultado final cuando exista.
  - El mismo criterio debe aplicarse al resto de modelos: no sumar campos intermedios ni reutilizar totales obsoletos.
- Se normalizaron periodos legacy del Modelo 130 para que `1`, `1T`, `T1` y variantes equivalentes resuelvan al mismo trimestre.
- El endpoint de historial debe poder devolver modelos presentados aunque el calculador actual no los recalculase en ese momento.
- Para empresas IPSI, la UI no debe sugerir modelos IVA como Modelo 303 salvo que el historico real de esa empresa los contenga.
- En la empresa de prueba `TrustCore`, el regimen efectivo es IPSI aunque algun campo legacy pueda seguir diciendo IVA. Priorizar `defaultTaxKind = IPSI` o el campo fiscal mas especifico frente a valores legacy genericos.

## Contrato esperado por clientes

- Las pantallas fiscales deben consumir el historico presentado como fuente de verdad para importes cerrados.
- Los modelos en borrador pueden seguir usando endpoints de calculo, pero los modelos presentados deben mostrar el snapshot guardado.
- Si un modelo tiene casillas calculadas, esas casillas deben estar disponibles en el historial fiscal o en el detalle del modelo presentado para evitar discrepancias entre escritorio, Flutter y PWA.
- Los filtros de ejercicio, modelo y estado deben operar sobre el historico fiscal real de la empresa activa.

## Facturacion y flujo comercial

- El flujo de documentos queda alineado como:
  1. Presupuesto
  2. Venta
  3. Factura
- La PWA ya usa endpoints separados para presupuestos, ventas y facturas. Flutter debe mantener el mismo orden conceptual y las mismas transiciones.
- Convertir a factura final bloquea la numeracion final, pero no implica envio automatico a AEAT desde la PWA.

## Gastos y compras

- La PWA lista compras por meses y estados (`UNPAID`, `PAID`) usando el listado de compras.
- La creacion de compra usa confirmacion de recibo/factura de proveedor con lineas, adjunto, proveedor, regimen fiscal y estado.
- Los adjuntos se envian como base64 con MIME real del fichero.

## Sesion y empresa activa

- La PWA persiste sesion con refresh token local para sobrevivir a recargas.
- El nombre visible de empresa debe salir de `/company` (`tradeName` o `name`) y no solo del nombre generico que pueda llegar en la respuesta de autenticacion.
- La empresa activa y sus datos fiscales deben refrescarse tras login, cambio de empresa o recarga.

## Commits de referencia en API/PWA

- `5b944b1 fix(tax): merge legacy modelo 130 periods`
- `30a1bff fix(tax): standardize tax return period history`
- `978a0aa fix(tax): normalize modelo 130 filing period` en escritorio
- `359c2b5 docs: add desktop lint cleanup task` en escritorio

## Pendiente recomendado

- Revisar Flutter para confirmar que el listado fiscal usa historico presentado antes que recalculo.
- Verificar que el Modelo 130 lee la casilla 19 cuando exista.
- Verificar que las empresas IPSI no muestran Modelo 303 como proximo modelo salvo dato historico real.
- Anadir pruebas de contrato para periodos fiscales normalizados y modelos presentados.
