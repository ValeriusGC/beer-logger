// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Пивомер';

  @override
  String get todayBalanceVolumeLabel => 'Объём';

  @override
  String get todayBalanceEnergyLabel => 'Ккал';

  @override
  String get todayBalanceMoneyLabel => 'Деньги';

  @override
  String get todayBalanceJoyLabel => 'Радость';

  @override
  String get todayBalanceLoadError => 'Не удалось загрузить итог за сегодня';

  @override
  String recordBeerTap(String volume) {
    return 'Пиво $volume';
  }

  @override
  String get recordClickError => 'Не удалось записать тап';

  @override
  String get todayClicksTitle => 'Сегодня';

  @override
  String get todayClicksEmpty => 'Пока нет записей за сегодня';

  @override
  String get todayClicksLoadError => 'Не удалось загрузить записи за сегодня';

  @override
  String get undoLastTap => 'Отменить последний тап';

  @override
  String get undoLastTapError => 'Не удалось отменить тап';

  @override
  String get homeSettingsTooltip => 'Настройки';

  @override
  String get settingsTitle => 'Порция';

  @override
  String get settingsVolumeLabel => 'Объём (L)';

  @override
  String get settingsEnergyLabel => 'Ккал';

  @override
  String get settingsMoneyLabel => 'Цена';

  @override
  String get settingsJoyLabel => 'Радость';

  @override
  String get settingsEnergyHelper => 'ваши усреднённые значения, не USDA';

  @override
  String get settingsSave => 'Сохранить';

  @override
  String get settingsVolumeRangeError => 'Введите объём от 0,1 до 3 L';

  @override
  String get settingsEnergyRangeError => 'Введите ккал от 50 до 250';

  @override
  String get settingsMoneyRangeError => 'Введите цену от 0 до 10000';

  @override
  String get settingsJoyRangeError => 'Введите радость от 0 до 10';

  @override
  String get settingsSaveError => 'Не удалось сохранить настройки';

  @override
  String get weekChartTitle => 'Объём за 7 дней';

  @override
  String get weekChartLoadError => 'Не удалось загрузить график за неделю';
}
