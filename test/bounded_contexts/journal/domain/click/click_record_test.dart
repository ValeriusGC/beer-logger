import 'package:beer_logger/bounded_contexts/journal/journal.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/domain_fixtures.dart';

void main() {
  group('Click.record', () {
    test('четыре оси spec, factor=1 — volume 500 мл в базе', () {
      final result = Click.record(
        id: const ClickId.known('click-1'),
        clickerId: const ClickerId.known('clicker-beer'),
        at: DateTime(2026, 7, 28, 18),
        axes: axisRecordInputsFrom(beerHalfLiterClicker()),
      );

      expect(result.isRight(), isTrue);
      final click = result.getOrElse((_) => throw StateError('expected Right'));

      expect(click.contributions, hasLength(4));
      expect(
        contribution(click, LedgerAxisKind.volume)!.delta.signedBase,
        500.0,
      );
      expect(
        contribution(click, LedgerAxisKind.energy)!.delta.signedBase,
        100000.0,
      );
      expect(
        contribution(click, LedgerAxisKind.money)!.delta.signedBase,
        -15000.0,
      );
      expect(contribution(click, LedgerAxisKind.joy)!.delta.signedBase, 2.0);
    });

    test('factor=2 удваивает вклад volume', () {
      final result = Click.record(
        id: const ClickId.known('click-2'),
        clickerId: const ClickerId.known('clicker-beer'),
        at: DateTime(2026, 7, 28, 18),
        axes: axisRecordInputsFrom(beerHalfLiterClicker()),
        factor: 2,
      );

      final click = result.getOrElse((_) => throw StateError('expected Right'));
      expect(
        contribution(click, LedgerAxisKind.volume)!.delta.signedBase,
        1000.0,
      );
    });

    test('неизвестный enteredInId → Failure.unknownUnitId', () {
      final result = Click.record(
        id: const ClickId.known('click-bad'),
        clickerId: const ClickerId.known('clicker-beer'),
        at: DateTime(2026, 7, 28, 18),
        axes: const [
          AxisRecordInput(
            kind: LedgerAxisKind.volume,
            enteredValue: 1,
            enteredInId: 'volume.unknown',
            signMultiplier: 1,
          ),
        ],
      );

      expect(
        result,
        const Left<Failure, Click>(Failure.unknownUnitId(id: 'volume.unknown')),
      );
    });

    test('смена конфигурации Clicker не меняет уже записанный Click', () {
      final clicker = beerHalfLiterClicker();
      final recorded = Click.record(
        id: const ClickId.known('click-frozen'),
        clickerId: clicker.id,
        at: DateTime(2026, 7, 28, 12),
        axes: axisRecordInputsFrom(clicker),
      ).getOrElse((_) => throw StateError('expected Right'));

      final updatedClicker = clicker.copyWith(
        axes: [
          clicker.axes.first.copyWith(enteredValue: 0.33),
          ...clicker.axes.skip(1),
        ],
      );

      expect(updatedClicker.axes.first.enteredValue, 0.33);
      expect(
        contribution(recorded, LedgerAxisKind.volume)!.delta.signedBase,
        500.0,
      );
    });

    test('enteredInId на снимке — для отображения через fromBase', () {
      final click = Click.record(
        id: const ClickId.known('click-ui'),
        clickerId: const ClickerId.known('clicker-beer'),
        at: DateTime(2026, 7, 28, 12),
        axes: axisRecordInputsFrom(beerHalfLiterClicker()),
      ).getOrElse((_) => throw StateError('expected Right'));

      final volume = contribution(click, LedgerAxisKind.volume)!;
      expect(volume.enteredInId, VolumeUnit.liter.id);
      expect(fromBase(volume.delta.signedBase, VolumeUnit.liter), 0.5);
    });
  });
}
