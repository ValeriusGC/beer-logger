import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:beer_logger/bounded_contexts/journal/infrastructure/day_boundaries.dart';
import 'package:beer_logger/bounded_contexts/journal/infrastructure/click_mapper.dart';
import 'package:beer_logger/bounded_contexts/journal/infrastructure/ledger_axis_kind_wire.dart';
import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter_test/flutter_test.dart';

Click _recordClick({
  required String id,
  required DateTime at,
  double factor = 1,
}) {
  return Click.record(
    id: ClickId.known(id),
    clickerId: beerHalfLiter().id,
    at: at,
    axes: axisRecordInputsFrom(beerHalfLiter()),
    factor: factor,
  ).getOrElse((_) => throw StateError('expected Right'));
}

void main() {
  group('ledger_axis_kind_wire', () {
    test('все LedgerAxisKind round-trip через wire', () {
      for (final kind in LedgerAxisKind.values) {
        expect(ledgerAxisKindFromWire(ledgerAxisKindToWire(kind)), kind);
      }
    });
  });

  group('click_mapper round-trip', () {
    test('Click идентичен после row↔domain', () {
      final click = _recordClick(
        id: 'click-round-trip',
        at: DateTime(2026, 7, 28, 18, 30),
        factor: 2,
      );

      final clickRow = ClickRow(
        id: click.id.value,
        clickerId: click.clickerId.value,
        atUtcMs: clickAtUtcMs(click.at),
        factor: click.factor,
      );
      final contributionRows = [
        for (final companion in contributionsToCompanions(click))
          ClickContributionRow(
            clickId: companion.clickId.value,
            kind: companion.kind.value,
            signedBaseDelta: companion.signedBaseDelta.value,
            enteredInId: companion.enteredInId.value,
          ),
      ];

      final restored = clickFromRows(
        row: clickRow,
        contributions: contributionRows,
      );

      expect(restored, click);
    });

    test('clickToCompanion и contributionsToCompanions покрывают все поля', () {
      final click = _recordClick(
        id: 'click-companion',
        at: DateTime(2026, 7, 28, 12),
      );

      final companion = clickToCompanion(click);
      expect(companion.id.value, click.id.value);
      expect(companion.clickerId.value, click.clickerId.value);
      expect(companion.atUtcMs.value, clickAtUtcMs(click.at));
      expect(companion.factor.value, click.factor);

      final contributionCompanions = contributionsToCompanions(click);
      expect(contributionCompanions, hasLength(click.contributions.length));
      for (var i = 0; i < click.contributions.length; i++) {
        final source = click.contributions[i];
        final mapped = contributionCompanions[i];
        expect(mapped.clickId.value, click.id.value);
        expect(mapped.kind.value, ledgerAxisKindToWire(source.kind));
        expect(mapped.signedBaseDelta.value, source.delta.signedBase);
        expect(mapped.enteredInId.value, source.enteredInId);
      }
    });
  });

  group('localDayUtcRange', () {
    test('23:59 дня D в диапазоне, 00:01 дня D+1 — вне', () {
      final dayD = DateTime(2026, 7, 28);
      final range = localDayUtcRange(dayD);

      final tap2359Ms = clickAtUtcMs(DateTime(2026, 7, 28, 23, 59));
      expect(
        tap2359Ms >= range.startUtcMs && tap2359Ms < range.endUtcMs,
        isTrue,
      );

      final tap0001Ms = clickAtUtcMs(DateTime(2026, 7, 29, 0, 1));
      expect(
        tap0001Ms >= range.startUtcMs && tap0001Ms < range.endUtcMs,
        isFalse,
      );
    });

    test('соседние дни — смежные полуинтервалы в UTC ms', () {
      final rangeD = localDayUtcRange(DateTime(2026, 7, 28));
      final rangeDPlus1 = localDayUtcRange(DateTime(2026, 7, 29));

      expect(rangeD.endUtcMs, rangeDPlus1.startUtcMs);
      expect(rangeD.startUtcMs < rangeD.endUtcMs, isTrue);
    });
  });

  group('localDaysUtcRange', () {
    test('конец — начало toLocal, не отдельный перевод', () {
      final from = DateTime(2026, 9, 15, 18);
      final to = DateTime(2026, 9, 22, 3);
      final range = localDaysUtcRange(fromLocal: from, toLocal: to);

      expect(range.startUtcMs, localDayUtcRange(from).startUtcMs);
      expect(range.endUtcMs, localDayUtcRange(to).startUtcMs);
      expect(range.startUtcMs < range.endUtcMs, isTrue);
    });
  });
}
