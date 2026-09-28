// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pivomer';

  @override
  String get todayBalanceVolumeLabel => 'Volume';

  @override
  String get todayBalanceEnergyLabel => 'Calories';

  @override
  String get todayBalanceMoneyLabel => 'Money';

  @override
  String get todayBalanceJoyLabel => 'Joy';

  @override
  String get todayBalanceLoadError => 'Couldn\'t load today\'s totals';

  @override
  String recordBeerTap(String volume) {
    return 'Beer $volume';
  }

  @override
  String get recordClickError => 'Couldn\'t save the tap';

  @override
  String get todayClicksTitle => 'Today';

  @override
  String get todayClicksEmpty => 'No taps today';

  @override
  String get todayClicksLoadError => 'Couldn\'t load today\'s taps';

  @override
  String get undoLastTap => 'Undo last tap';

  @override
  String get undoLastTapError => 'Couldn\'t undo the tap';

  @override
  String get homeSettingsTooltip => 'Settings';

  @override
  String get settingsTitle => 'Portion';

  @override
  String get settingsVolumeLabel => 'Volume (L)';

  @override
  String get settingsEnergyLabel => 'Calories (kcal)';

  @override
  String get settingsMoneyLabel => 'Price';

  @override
  String get settingsJoyLabel => 'Joy';

  @override
  String get settingsEnergyHelper => 'your averages, not USDA';

  @override
  String get settingsSave => 'Save';

  @override
  String get settingsVolumeRangeError => 'Enter a volume from 0.1 to 3 L';

  @override
  String get settingsEnergyRangeError => 'Enter calories from 50 to 250';

  @override
  String get settingsMoneyRangeError => 'Enter a price from 0 to 10000';

  @override
  String get settingsJoyRangeError => 'Enter joy from 0 to 10';

  @override
  String get settingsSaveError => 'Couldn\'t save settings';

  @override
  String get weekChartVolumeTitle => 'Volume, last 7 days';

  @override
  String get weekChartEnergyTitle => 'Energy, last 7 days';

  @override
  String get weekChartMoneyTitle => 'Money, last 7 days';

  @override
  String get weekChartJoyTitle => 'Joy, last 7 days';

  @override
  String get weekChartLoadError => 'Couldn\'t load the week charts';
}
