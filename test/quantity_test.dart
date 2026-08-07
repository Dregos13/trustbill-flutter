import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/core/utils/number_parsing.dart';

/// Cantidad decimal en las lineas.
///
/// El campo "Cant." era digitsOnly: no dejaba ni teclear la coma, asi que
/// "5,5 horas" o "12,75 metros" —corrientes en el escritorio, donde la columna
/// es numeric(14,3)— eran imposibles desde el movil. Al escribir "2.5" el campo
/// se comia el punto y guardaba 25.

void main() {
  group('hasValidQuantityPrecision', () {
    test('acepta hasta tres decimales', () {
      for (final value in [1.0, 2.5, 12.75, 0.001, 1234.567]) {
        expect(
          hasValidQuantityPrecision(value),
          isTrue,
          reason: '$value cabe en numeric(14,3)',
        );
      }
    });

    test('rechaza el cuarto decimal', () {
      // Postgres lo redondearia en silencio, asi que se para en la entrada.
      expect(hasValidQuantityPrecision(1.2345), isFalse);
      expect(hasValidQuantityPrecision(0.0001), isFalse);
    });

    test('la tolerancia absorbe el ruido de la coma flotante', () {
      // 1.1 * 1000 da 1100.0000000000002; comparar exacto lo daria por invalido.
      expect(hasValidQuantityPrecision(1.1), isTrue);
      expect(hasValidQuantityPrecision(2.2), isTrue);
      expect(hasValidQuantityPrecision(8.7), isTrue);
    });

    test('rechaza lo que no es finito', () {
      expect(hasValidQuantityPrecision(double.nan), isFalse);
      expect(hasValidQuantityPrecision(double.infinity), isFalse);
    });
  });

  group('formatQuantity', () {
    test('una cantidad entera no arrastra decimales', () {
      expect(formatQuantity(2), '2');
      expect(formatQuantity(2.0), '2');
      expect(formatQuantity(150), '150');
    });

    test('los decimales salen con coma, sin ceros de relleno', () {
      expect(formatQuantity(2.5), '2,5');
      expect(formatQuantity(12.75), '12,75');
      expect(formatQuantity(0.125), '0,125');
    });
  });

  group('parseLocalizedDecimal', () {
    test('entiende la coma y el punto como separador decimal', () {
      expect(parseLocalizedDecimal('2,5'), 2.5);
      expect(parseLocalizedDecimal('2.5'), 2.5);
    });

    test('un valor vacio cae al fallback', () {
      expect(parseLocalizedDecimal('', fallback: 1), 1);
    });

    test('ida y vuelta: lo que se pinta se vuelve a leer igual', () {
      for (final value in [1.0, 2.5, 12.75, 0.125]) {
        expect(parseLocalizedDecimal(formatQuantity(value)), value);
      }
    });
  });
}
