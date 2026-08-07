import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/auth_provider.dart';

/// Regimen fiscal por defecto de la empresa activa: 'IVA' o 'IPSI'.
///
/// Las pantallas de documento nuevo arrancaban siempre en IVA. Una empresa de
/// Ceuta o Melilla, que trabaja en IPSI, tenia que cambiarlo a mano cada vez —
/// y si se le olvidaba, el documento salia con el regimen equivocado.
///
/// `CompanySettings.defaultTaxKind` es la fuente de verdad y `GET /company` ya
/// lo devuelve, asi que aqui solo se consume.
///
/// Cae a 'IVA' cuando no hay respuesta o el valor no se reconoce: es el
/// comportamiento de antes, y equivale al mismo fallback que aplica la API en
/// `getCompanyDefaultTaxKind`.
/// Tipo impositivo con el que nace una linea segun el regimen.
///
/// Estaba triplicado como `v == 'IVA' ? 21 : 10` en las pantallas de factura,
/// presupuesto y venta. Vive aqui para que cambiarlo sea un solo sitio.
double defaultTaxRateFor(String taxKind) => taxKind == 'IVA' ? 21 : 10;

final companyDefaultTaxKindProvider = FutureProvider<String>((ref) async {
  final endpoints = ref.watch(endpointsProvider);
  try {
    final settings = await endpoints.getCompanySettings();
    final kind = settings['defaultTaxKind'];
    return kind == 'IPSI' ? 'IPSI' : 'IVA';
  } catch (_) {
    // Sin red o sin permiso: no es motivo para bloquear la pantalla.
    return 'IVA';
  }
});
