import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ru'),
    Locale('en'),
  ];

  /// Application name in the window title and home app bar
  ///
  /// In en, this message translates to:
  /// **'Pivomer'**
  String get appTitle;

  /// Axis label for today's volume on the home balance card
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get todayBalanceVolumeLabel;

  /// Axis label for today's energy on the home balance card
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get todayBalanceEnergyLabel;

  /// Axis label for today's money on the home balance card
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get todayBalanceMoneyLabel;

  /// Axis label for today's joy on the home balance card
  ///
  /// In en, this message translates to:
  /// **'Joy'**
  String get todayBalanceJoyLabel;

  /// User-visible error when todayBalanceProvider fails on home
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load today\'s totals'**
  String get todayBalanceLoadError;

  /// Label on the home button that records one beer tap. Volume is the current portion in liters.
  ///
  /// In en, this message translates to:
  /// **'Beer {volume}'**
  String recordBeerTap(String volume);

  /// User-visible error when recordClickProvider fails on home
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save the tap'**
  String get recordClickError;

  /// Section title for today's tap list on home
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayClicksTitle;

  /// Empty state when clicksForToday is an empty list, not an error
  ///
  /// In en, this message translates to:
  /// **'No taps today'**
  String get todayClicksEmpty;

  /// User-visible error when clicksForTodayProvider fails on home
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load today\'s taps'**
  String get todayClicksLoadError;

  /// Label on the home button that undoes the globally last tap
  ///
  /// In en, this message translates to:
  /// **'Undo last tap'**
  String get undoLastTap;

  /// User-visible error when undoLastClickProvider fails on home
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t undo the tap'**
  String get undoLastTapError;

  /// Tooltip on the home app bar button that opens portion settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get homeSettingsTooltip;

  /// Title of the portion settings screen
  ///
  /// In en, this message translates to:
  /// **'Portion'**
  String get settingsTitle;

  /// Label of the volume field on portion settings
  ///
  /// In en, this message translates to:
  /// **'Volume (L)'**
  String get settingsVolumeLabel;

  /// Label of the calories field on portion settings
  ///
  /// In en, this message translates to:
  /// **'Calories (kcal)'**
  String get settingsEnergyLabel;

  /// Label of the price field on portion settings
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get settingsMoneyLabel;

  /// Label of the joy field on portion settings
  ///
  /// In en, this message translates to:
  /// **'Joy'**
  String get settingsJoyLabel;

  /// Helper under the calories field: user estimate, not a USDA value
  ///
  /// In en, this message translates to:
  /// **'your averages, not USDA'**
  String get settingsEnergyHelper;

  /// Button that saves the current portion
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingsSave;

  /// Error when the volume field is empty, not a number, or outside 0.1 to 3
  ///
  /// In en, this message translates to:
  /// **'Enter a volume from 0.1 to 3 L'**
  String get settingsVolumeRangeError;

  /// Error when the calories field is empty, not a number, or outside 50 to 250
  ///
  /// In en, this message translates to:
  /// **'Enter calories from 50 to 250'**
  String get settingsEnergyRangeError;

  /// Error when the price field is empty, not a number, or outside 0 to 10000
  ///
  /// In en, this message translates to:
  /// **'Enter a price from 0 to 10000'**
  String get settingsMoneyRangeError;

  /// Error when the joy field is empty, not a number, or outside 0 to 10
  ///
  /// In en, this message translates to:
  /// **'Enter joy from 0 to 10'**
  String get settingsJoyRangeError;

  /// SnackBar when saving portion settings fails in the database
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save settings'**
  String get settingsSaveError;

  /// Title of the home week chart for volume
  ///
  /// In en, this message translates to:
  /// **'Volume, last 7 days'**
  String get weekChartVolumeTitle;

  /// Title of the home week chart for energy
  ///
  /// In en, this message translates to:
  /// **'Energy, last 7 days'**
  String get weekChartEnergyTitle;

  /// Title of the home week chart for money
  ///
  /// In en, this message translates to:
  /// **'Money, last 7 days'**
  String get weekChartMoneyTitle;

  /// Title of the home week chart for joy
  ///
  /// In en, this message translates to:
  /// **'Joy, last 7 days'**
  String get weekChartJoyTitle;

  /// User-visible error when weekAxisChartsForLast7DaysProvider fails on home
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load the week charts'**
  String get weekChartLoadError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
