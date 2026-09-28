import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/period_balances.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/signed_base_delta.dart';
import 'package:beer_logger/bounded_contexts/journal/presentation/today_balance_format.dart';
import 'package:flutter_test/flutter_test.dart';

PeriodBalances _balances({
  double milliliters = 0,
  double calories = 0,
  double kopecks = 0,
  double joy = 0,
}) {
  return PeriodBalances(
    totalsInBase: {
      LedgerAxisKind.volume: SignedBaseDelta.volume(milliliters),
      LedgerAxisKind.energy: SignedBaseDelta.energy(calories),
      LedgerAxisKind.money: SignedBaseDelta.money(kopecks),
      LedgerAxisKind.joy: SignedBaseDelta.joy(joy),
    },
  );
}

String _joinCompact(List<FormattedAxisValue> segments) {
  return segments.map((segment) => segment.text).join('/');
}

void main() {
  group('formatTodayBalanceLines', () {
    test('money отрицательные — isNegative true', () {
      final lines = formatTodayBalanceLines(
        _balances(kopecks: -75000),
        languageCode: 'en',
      );

      expect(lines.money.isNegative, isTrue);
      expect(lines.money.text, '-750 ₽');
      expect(lines.energy.isNegative, isFalse);
    });
  });

  group('formatTodayBalanceCompact', () {
    test('ru — литры без мл, знаки как на карточке, слеш', () {
      final segments = formatTodayBalanceCompact(
        _balances(
          milliliters: 2500,
          calories: 500000,
          kopecks: -75000,
          joy: 10,
        ),
        languageCode: 'ru',
      );

      expect(_joinCompact(segments), '2,5L/+500kcal/-750₽/+10pt');
      expect(segments[2].isNegative, isTrue);
    });

    test('en — точка в литрах, те же знаки', () {
      final segments = formatTodayBalanceCompact(
        _balances(
          milliliters: 2500,
          calories: 500000,
          kopecks: -75000,
          joy: 10,
        ),
        languageCode: 'en',
      );

      expect(_joinCompact(segments), '2.5L/+500kcal/-750₽/+10pt');
    });

    test('нули — без плюса и без минус-нуля', () {
      final segments = formatTodayBalanceCompact(
        _balances(),
        languageCode: 'en',
      );

      expect(_joinCompact(segments), '0L/0kcal/0₽/0pt');
      expect(segments.every((segment) => !segment.isNegative), isTrue);
    });
  });

  group('formatWeekChartAxisTotal', () {
    test('сумма денег за неделю — знак и единица', () {
      final total = formatWeekChartAxisTotal(
        -300,
        LedgerAxisKind.money,
        languageCode: 'en',
      );

      expect(total.text, '-300 ₽');
      expect(total.isNegative, isTrue);
    });
  });
}
