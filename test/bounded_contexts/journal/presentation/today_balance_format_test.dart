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

void main() {
  group('formatTodayBalanceCompact', () {
    test('ru — литры без мл, знаки как на карточке, слеш', () {
      final line = formatTodayBalanceCompact(
        _balances(
          milliliters: 2500,
          calories: 500000,
          kopecks: -75000,
          joy: 10,
        ),
        languageCode: 'ru',
      );

      expect(line, '2,5L/+500kcal/-750₽/+10pt');
    });

    test('en — точка в литрах, те же знаки', () {
      final line = formatTodayBalanceCompact(
        _balances(
          milliliters: 2500,
          calories: 500000,
          kopecks: -75000,
          joy: 10,
        ),
        languageCode: 'en',
      );

      expect(line, '2.5L/+500kcal/-750₽/+10pt');
    });

    test('нули — без плюса и без минус-нуля', () {
      expect(
        formatTodayBalanceCompact(_balances(), languageCode: 'en'),
        '0L/0kcal/0₽/0pt',
      );
    });
  });
}
