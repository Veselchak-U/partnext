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

  /// No description provided for @previous.
  ///
  /// In he, this message translates to:
  /// **'הקודם'**
  String get previous;

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

  /// No description provided for @phone_validation.
  ///
  /// In he, this message translates to:
  /// **'אימות טלפון'**
  String get phone_validation;

  /// No description provided for @what_am_i.
  ///
  /// In he, this message translates to:
  /// **'מה אני'**
  String get what_am_i;

  /// No description provided for @i_have_idea.
  ///
  /// In he, this message translates to:
  /// **'יש לי רעיון'**
  String get i_have_idea;

  /// No description provided for @i_own_startup.
  ///
  /// In he, this message translates to:
  /// **'בבעלותי סטארט-אפ'**
  String get i_own_startup;

  /// No description provided for @i_own_business.
  ///
  /// In he, this message translates to:
  /// **'יש לי עסק'**
  String get i_own_business;

  /// No description provided for @strategic_partner.
  ///
  /// In he, this message translates to:
  /// **'שותף אסטרטגי'**
  String get strategic_partner;

  /// No description provided for @active_partner.
  ///
  /// In he, this message translates to:
  /// **'שותף פעיל'**
  String get active_partner;

  /// No description provided for @other.
  ///
  /// In he, this message translates to:
  /// **'אחרים'**
  String get other;

  /// No description provided for @grow_idea.
  ///
  /// In he, this message translates to:
  /// **'לגדל רעיון'**
  String get grow_idea;

  /// No description provided for @partnership_on_startup.
  ///
  /// In he, this message translates to:
  /// **'שותפות בסטארט-אפ'**
  String get partnership_on_startup;

  /// No description provided for @partnership_on_business.
  ///
  /// In he, this message translates to:
  /// **'שותפות על עסקים קיימים'**
  String get partnership_on_business;

  /// No description provided for @art_and_entertainment.
  ///
  /// In he, this message translates to:
  /// **'אמנות ובידור'**
  String get art_and_entertainment;

  /// No description provided for @music.
  ///
  /// In he, this message translates to:
  /// **'מוזיקה'**
  String get music;

  /// No description provided for @banking.
  ///
  /// In he, this message translates to:
  /// **'בנקאות'**
  String get banking;

  /// No description provided for @finance.
  ///
  /// In he, this message translates to:
  /// **'האוצר'**
  String get finance;

  /// No description provided for @consulting.
  ///
  /// In he, this message translates to:
  /// **'ייעוץ'**
  String get consulting;

  /// No description provided for @creatives.
  ///
  /// In he, this message translates to:
  /// **'קריאייטיבים'**
  String get creatives;

  /// No description provided for @fashion.
  ///
  /// In he, this message translates to:
  /// **'אופנה'**
  String get fashion;

  /// No description provided for @media_and_journalism.
  ///
  /// In he, this message translates to:
  /// **'מדיה ועיתונאות'**
  String get media_and_journalism;

  /// No description provided for @sales.
  ///
  /// In he, this message translates to:
  /// **'מכירות'**
  String get sales;

  /// No description provided for @government_and_politics.
  ///
  /// In he, this message translates to:
  /// **'ממשלה ופוליטיקה'**
  String get government_and_politics;

  /// No description provided for @vc_and_investment.
  ///
  /// In he, this message translates to:
  /// **'הון סיכון והשקעות'**
  String get vc_and_investment;

  /// No description provided for @education.
  ///
  /// In he, this message translates to:
  /// **'חינוך'**
  String get education;

  /// No description provided for @medicine.
  ///
  /// In he, this message translates to:
  /// **'רפואה'**
  String get medicine;

  /// No description provided for @marketing.
  ///
  /// In he, this message translates to:
  /// **'שיווק'**
  String get marketing;

  /// No description provided for @public_relations.
  ///
  /// In he, this message translates to:
  /// **'יחסי ציבור'**
  String get public_relations;

  /// No description provided for @tech.
  ///
  /// In he, this message translates to:
  /// **'טק'**
  String get tech;

  /// No description provided for @advertising.
  ///
  /// In he, this message translates to:
  /// **'פרסום'**
  String get advertising;

  /// No description provided for @insurance.
  ///
  /// In he, this message translates to:
  /// **'ביטוח'**
  String get insurance;

  /// No description provided for @real_estate.
  ///
  /// In he, this message translates to:
  /// **'נדל ן'**
  String get real_estate;

  /// No description provided for @law_and_policy.
  ///
  /// In he, this message translates to:
  /// **'חוק ומדיניות'**
  String get law_and_policy;

  /// No description provided for @travel_and_hospitality.
  ///
  /// In he, this message translates to:
  /// **'נסיעות ואירוח'**
  String get travel_and_hospitality;

  /// No description provided for @police_and_military.
  ///
  /// In he, this message translates to:
  /// **'משטרה וצבא'**
  String get police_and_military;

  /// No description provided for @constructions.
  ///
  /// In he, this message translates to:
  /// **'מבנים'**
  String get constructions;

  /// No description provided for @manufacturing.
  ///
  /// In he, this message translates to:
  /// **'ייצור'**
  String get manufacturing;

  /// No description provided for @food_and_beverage.
  ///
  /// In he, this message translates to:
  /// **'מזון ומשקאות'**
  String get food_and_beverage;

  /// No description provided for @counseling.
  ///
  /// In he, this message translates to:
  /// **'ייעוץ'**
  String get counseling;

  /// No description provided for @plus_other.
  ///
  /// In he, this message translates to:
  /// **'+ אחר'**
  String get plus_other;

  /// No description provided for @partnership_type_description.
  ///
  /// In he, this message translates to:
  /// **'כדי לקבל את האינטרס של אחרים, ודא שיש לך רעיון מפותח בכתב.\n\n · מה זה? \n · למה לקנות / להשתמש בו?\n · איזו בעיה זה פותר? \n · יתרונות וחסרונות ופרטים נוספים שאתה מוכן לשתף.'**
  String get partnership_type_description;

  /// No description provided for @i_am_looking_for.
  ///
  /// In he, this message translates to:
  /// **'אני מחפש'**
  String get i_am_looking_for;

  /// No description provided for @your_interests.
  ///
  /// In he, this message translates to:
  /// **'תחומי העניין שלך'**
  String get your_interests;

  /// No description provided for @partner_interests.
  ///
  /// In he, this message translates to:
  /// **'תחומי העניין של השותף הבא שלך'**
  String get partner_interests;

  /// No description provided for @tell_us_about_yourself.
  ///
  /// In he, this message translates to:
  /// **'ספר לנו על עצמך'**
  String get tell_us_about_yourself;

  /// No description provided for @please_do_not_mention_numbers.
  ///
  /// In he, this message translates to:
  /// **'*נא לא להזכיר מספרים'**
  String get please_do_not_mention_numbers;

  /// No description provided for @finish_registration.
  ///
  /// In he, this message translates to:
  /// **'סיום הרשמה'**
  String get finish_registration;

  /// No description provided for @your_current_position.
  ///
  /// In he, this message translates to:
  /// **'המיקום והארגון הנוכחי שלך'**
  String get your_current_position;

  /// No description provided for @kind_of_partnership_are_you_looking.
  ///
  /// In he, this message translates to:
  /// **'איזה סוג של שותפות אתה מחפש?'**
  String get kind_of_partnership_are_you_looking;

  /// No description provided for @tell_us_about_yourself_first.
  ///
  /// In he, this message translates to:
  /// **'ספר לנו על עצמך,'**
  String get tell_us_about_yourself_first;

  /// No description provided for @tell_us_about_yourself_second.
  ///
  /// In he, this message translates to:
  /// **'מה אתה נלהב? מה השגת?'**
  String get tell_us_about_yourself_second;

  /// No description provided for @years_of_experience.
  ///
  /// In he, this message translates to:
  /// **'שנים של ניסיון'**
  String get years_of_experience;

  /// No description provided for @linkedin_profile_url.
  ///
  /// In he, this message translates to:
  /// **'כתובת אתר לפרופיל לינקדאין'**
  String get linkedin_profile_url;

  /// No description provided for @select_at_least_one_item.
  ///
  /// In he, this message translates to:
  /// **'בחר פריט אחד לפחות'**
  String get select_at_least_one_item;

  /// No description provided for @specify_amount_of_experience.
  ///
  /// In he, this message translates to:
  /// **'ציין את כמות הניסיון'**
  String get specify_amount_of_experience;

  /// No description provided for @first_image_will_be.
  ///
  /// In he, this message translates to:
  /// **'התמונה הראשונה תהיה תמונת הפרופיל שלך, בעוד שכל שאר התמונות יכולות להיות שלך או קשורות לעסק שלך.'**
  String get first_image_will_be;
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
