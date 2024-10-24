import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_he.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('he')
  ];

  /// No description provided for @page_not_found.
  ///
  /// In he, this message translates to:
  /// **'הדף לא נמצא'**
  String get page_not_found;

  /// No description provided for @to_initial_screen.
  ///
  /// In he, this message translates to:
  /// **'למסך ראשי'**
  String get to_initial_screen;

  /// No description provided for @go_to_login_screen.
  ///
  /// In he, this message translates to:
  /// **'משתמש לא מורשה-עבור למסך הכניסה'**
  String get go_to_login_screen;

  /// No description provided for @authorization.
  ///
  /// In he, this message translates to:
  /// **'אישור'**
  String get authorization;

  /// No description provided for @invalid_code.
  ///
  /// In he, this message translates to:
  /// **'קוד לא תקין'**
  String get invalid_code;

  /// No description provided for @no_internet_connection.
  ///
  /// In he, this message translates to:
  /// **'אין חיבור לאינטרנט'**
  String get no_internet_connection;

  /// No description provided for @server_timeout.
  ///
  /// In he, this message translates to:
  /// **'השרת הפסיק לעבוד'**
  String get server_timeout;

  /// No description provided for @no_data.
  ///
  /// In he, this message translates to:
  /// **'אין נתונים'**
  String get no_data;

  /// No description provided for @auth_failed.
  ///
  /// In he, this message translates to:
  /// **'שגיאת אימות'**
  String get auth_failed;

  /// No description provided for @wrong_code.
  ///
  /// In he, this message translates to:
  /// **'קוד שגוי. נסה שוב...'**
  String get wrong_code;

  /// No description provided for @user_phone_exist.
  ///
  /// In he, this message translates to:
  /// **'קיים כבר משתמש עם מספר הטלפון הזה!'**
  String get user_phone_exist;

  /// No description provided for @field_not_unique.
  ///
  /// In he, this message translates to:
  /// **'שדה זה אינו ייחודי: {name}'**
  String field_not_unique(String name);

  /// No description provided for @field_required.
  ///
  /// In he, this message translates to:
  /// **'שדה חובה: {name}'**
  String field_required(String name);

  /// No description provided for @welcome_label.
  ///
  /// In he, this message translates to:
  /// **'הזדמנויות | שותפויות | קשרים'**
  String get welcome_label;

  /// No description provided for @start.
  ///
  /// In he, this message translates to:
  /// **'התחל'**
  String get start;

  /// No description provided for @already_have_account.
  ///
  /// In he, this message translates to:
  /// **'כבר יש לך חשבון?'**
  String get already_have_account;

  /// No description provided for @login.
  ///
  /// In he, this message translates to:
  /// **'התחברות'**
  String get login;

  /// No description provided for @invalid_phone_number.
  ///
  /// In he, this message translates to:
  /// **'מספר טלפון לא חוקי, אנא נסה שוב :)'**
  String get invalid_phone_number;

  /// No description provided for @terms_must_accepted.
  ///
  /// In he, this message translates to:
  /// **'כדי להירשם, עליך להסכים לתנאים וההגבלות'**
  String get terms_must_accepted;

  /// No description provided for @registration.
  ///
  /// In he, this message translates to:
  /// **'רישום'**
  String get registration;

  /// No description provided for @full_name.
  ///
  /// In he, this message translates to:
  /// **'שם מלא'**
  String get full_name;

  /// No description provided for @phone_number.
  ///
  /// In he, this message translates to:
  /// **'מספר טלפון'**
  String get phone_number;

  /// No description provided for @next.
  ///
  /// In he, this message translates to:
  /// **'הבא'**
  String get next;

  /// No description provided for @i_accept.
  ///
  /// In he, this message translates to:
  /// **'אני מקבל'**
  String get i_accept;

  /// No description provided for @terms_and_conditions.
  ///
  /// In he, this message translates to:
  /// **'תנאים והגבלות'**
  String get terms_and_conditions;

  /// No description provided for @and.
  ///
  /// In he, this message translates to:
  /// **'ו'**
  String get and;

  /// No description provided for @privacy_policy.
  ///
  /// In he, this message translates to:
  /// **'מדיניות פרטיות'**
  String get privacy_policy;

  /// No description provided for @do_not_have_account.
  ///
  /// In he, this message translates to:
  /// **'עדיין אין לך חשבון?'**
  String get do_not_have_account;

  /// No description provided for @password_must_contain.
  ///
  /// In he, this message translates to:
  /// **'הסיסמה חייבת להכיל 6 ספרות'**
  String get password_must_contain;

  /// No description provided for @enter_validation_code.
  ///
  /// In he, this message translates to:
  /// **'נא להזין את קוד האימות ששלחנו לך'**
  String get enter_validation_code;

  /// No description provided for @did_not_get_code.
  ///
  /// In he, this message translates to:
  /// **'לא קיבלת את הקוד?'**
  String get did_not_get_code;

  /// No description provided for @resend_code.
  ///
  /// In he, this message translates to:
  /// **'לשלוח שוב קוד'**
  String get resend_code;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'he'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'he': return AppLocalizationsHe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
