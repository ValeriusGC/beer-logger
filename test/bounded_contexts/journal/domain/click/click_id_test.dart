import 'package:beer_logger/bounded_contexts/journal/domain/click/click_id.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker_id.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  test('ClickId.known равен себе и не является ClickerId', () {
    expect(const ClickId.known('a'), const ClickId.known('a'));
    expect(const ClickId.known('a'), isNot(isA<ClickerId>()));
  });

  test('ClickId.parse пустая строка — Failure.emptyId', () {
    expect(ClickId.parse(''), const Left<Failure, ClickId>(Failure.emptyId()));
  });

  test('ClickId.parse непустая строка — known', () {
    expect(
      ClickId.parse('a'),
      const Right<Failure, ClickId>(ClickId.known('a')),
    );
  });

  test('ClickId.parse пробел — known, не emptyId', () {
    expect(
      ClickId.parse(' '),
      const Right<Failure, ClickId>(ClickId.known(' ')),
    );
  });
}
