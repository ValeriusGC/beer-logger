import 'package:beer_logger/core/di/clicker_settings_repository.cg.dart';
import 'package:beer_logger/l10n/app_localizations.dart';
import 'package:beer_logger/bounded_contexts/portion/portion.dart';
import 'package:beer_ledger_core/beer_ledger_core.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _StubSettings implements ClickerSettingsRepository {
  var saves = 0;

  @override
  Future<Result<void>> saveClicker(Clicker clicker) async {
    saves++;
    return const Right<Failure, void>(null);
  }

  @override
  Stream<Clicker> watchClicker(ClickerId id) => Stream.value(beerHalfLiter());
}

void main() {
  testWidgets('мусор в ккал — ошибка поля, save не зовётся', (tester) async {
    final settings = _StubSettings();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentClickerProvider.overrideWith(
            (ref) => Stream.value(beerHalfLiter()),
          ),
          clickerSettingsRepositoryProvider.overrideWithValue(settings),
        ],
        child: const MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: SettingsPage(),
        ),
      ),
    );
    await tester.pump();

    await tester.enterText(find.byKey(const Key('settings-energy')), 'abc');
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Enter calories from 50 to 250'), findsOneWidget);
    expect(settings.saves, 0);
  });
}
