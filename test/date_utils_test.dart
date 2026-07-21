import 'package:flutter_test/flutter_test.dart';
import 'package:trustinfacts_mobile/core/utils/date.dart';

void main() {
  test('parseDisplayDateToApiIso keeps the civil day stable', () {
    expect(parseDisplayDateToApiIso('15/07/2026'), '2026-07-15T12:00:00.000Z');
  });

  test('parseDisplayDateToApiIso fallback also uses noon UTC', () {
    final iso = parseDisplayDateToApiIso('not a date');
    expect(iso.endsWith('T12:00:00.000Z'), isTrue);
  });

  test('formatIsoDateForDisplay reads the encoded civil date', () {
    expect(formatIsoDateForDisplay('2026-07-15T12:00:00.000Z'), '15/07/2026');
  });
}
