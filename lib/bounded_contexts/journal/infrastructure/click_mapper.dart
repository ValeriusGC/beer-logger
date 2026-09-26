import 'package:beer_logger/bounded_contexts/journal/domain/click/axis_contribution.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/click_id.dart';
import 'package:beer_logger/bounded_contexts/journal/domain/click/signed_base_delta.dart';
import 'package:beer_logger/bounded_contexts/journal/infrastructure/ledger_axis_kind_wire.dart';
import 'package:beer_logger/bounded_contexts/portion/domain/clicker/clicker_id.dart';
import 'package:beer_logger/core/persistence/app_database.dart';
import 'package:drift/drift.dart';

/// UTC ms для колонки `clicks.at_utc_ms`.
int clickAtUtcMs(DateTime at) => at.toUtc().millisecondsSinceEpoch;

/// Восстанавливает [Click.at] в local из UTC ms при чтении из БД.
DateTime clickAtFromUtcMs(int atUtcMs) =>
    DateTime.fromMillisecondsSinceEpoch(atUtcMs, isUtc: true).toLocal();

/// Собирает domain [Click] из строк drift (join contributions отдельно).
Click clickFromRows({
  required ClickRow row,
  required List<ClickContributionRow> contributions,
}) {
  final mappedContributions = [
    for (final row in contributions)
      AxisContribution(
        delta: SignedBaseDelta.fromKind(
          ledgerAxisKindFromWire(row.kind),
          row.signedBaseDelta,
        ),
        enteredInId: row.enteredInId,
      ),
  ]..sort((a, b) => a.kind.index.compareTo(b.kind.index));

  return Click(
    id: ClickId.known(row.id),
    clickerId: ClickerId.known(row.clickerId),
    at: clickAtFromUtcMs(row.atUtcMs),
    factor: row.factor,
    contributions: mappedContributions,
  );
}

/// Строка `clicks` для INSERT из domain [Click].
ClicksCompanion clickToCompanion(Click click) {
  return ClicksCompanion.insert(
    id: click.id.value,
    clickerId: click.clickerId.value,
    atUtcMs: clickAtUtcMs(click.at),
    factor: Value(click.factor),
  );
}

/// Строки `click_contributions` для batch INSERT из domain [Click].
List<ClickContributionsCompanion> contributionsToCompanions(Click click) {
  return [
    for (final contribution in click.contributions)
      ClickContributionsCompanion.insert(
        clickId: click.id.value,
        kind: ledgerAxisKindToWire(contribution.kind),
        signedBaseDelta: contribution.delta.signedBase,
        enteredInId: contribution.enteredInId,
      ),
  ];
}
