import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/core/api/company_tax_kind.dart';

/// Regimen fiscal por defecto al abrir un documento nuevo.
///
/// Las pantallas arrancaban siempre en IVA. Una empresa de Ceuta o Melilla
/// trabaja en IPSI y tenia que cambiarlo a mano cada vez; si se le olvidaba, el
/// documento salia con el regimen equivocado.

void main() {
  group('defaultTaxRateFor', () {
    test('IVA usa el tipo general del 21%', () {
      expect(defaultTaxRateFor('IVA'), 21);
    });

    test('IPSI no usa el 21%: ese tipo no existe en IPSI', () {
      // El 21% identifica IVA de forma inequivoca en
      // TrustBill/packages/shared/src/taxKind.ts, asi que proponerlo en una
      // empresa de IPSI marcaria el documento como del regimen contrario.
      expect(defaultTaxRateFor('IPSI'), isNot(21));
    });

    test('un valor desconocido no cae en el tipo de IVA', () {
      // Solo 'IVA' devuelve 21. Cualquier otra cosa se trata como IPSI, que es
      // el mismo criterio que aplica el provider al normalizar la respuesta.
      expect(defaultTaxRateFor('lo que sea'), isNot(21));
    });
  });
}
