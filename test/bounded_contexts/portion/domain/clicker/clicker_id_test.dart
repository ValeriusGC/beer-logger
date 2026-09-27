import 'package:beer_logger/bounded_contexts/journal/domain/click/click_id.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker_id.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  test('ClickerId равен себе и не является ClickId', () {
    expect(const ClickerId.known('a'), const ClickerId.known('a'));
    expect(const ClickerId.known('a'), isNot(isA<ClickId>()));
  });

  test('ClickerId.parse пустая строка — Failure.emptyId', () {
    expect(
      ClickerId.parse(''),
      const Left<Failure, ClickerId>(Failure.emptyId()),
    );
  });

  test('ClickerId.parse непустая строка — known', () {
    expect(
      ClickerId.parse('a'),
      const Right<Failure, ClickerId>(ClickerId.known('a')),
    );
  });

  test('ClickerId.parse пробел — known, не emptyId', () {
    expect(
      ClickerId.parse(' '),
      const Right<Failure, ClickerId>(ClickerId.known(' ')),
    );
  });
}
