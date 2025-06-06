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
/// import 'generated/app_localizations.dart';
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

  /// No description provided for @who_am_i.
  ///
  /// In he, this message translates to:
  /// **'מי אני'**
  String get who_am_i;

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

  /// No description provided for @add_least_2_photos_to_continue.
  ///
  /// In he, this message translates to:
  /// **'הוסף לפחות 2 תמונות להמשך'**
  String get add_least_2_photos_to_continue;

  /// No description provided for @registration_complete.
  ///
  /// In he, this message translates to:
  /// **'רישום\nשלם'**
  String get registration_complete;

  /// No description provided for @registration_complete_description.
  ///
  /// In he, this message translates to:
  /// **'להחליק זכות לדבר עסקים\nזה יהיה התאמה אם שניכם להחליק ימינה.\nהחלק שמאלה אם אינך חושב שהשותף המוצג הוא התאמה טובה.'**
  String get registration_complete_description;

  /// No description provided for @start_browsing.
  ///
  /// In he, this message translates to:
  /// **'התחל לגלוש'**
  String get start_browsing;

  /// No description provided for @lot_of_swipes_today.
  ///
  /// In he, this message translates to:
  /// **'וואו, זה הרבה החלקות היום!'**
  String get lot_of_swipes_today;

  /// No description provided for @no_recommendations_today.
  ///
  /// In he, this message translates to:
  /// **'אין המלצות להיום.'**
  String get no_recommendations_today;

  /// No description provided for @check_back_soon.
  ///
  /// In he, this message translates to:
  /// **'בדוק שוב בקרוב,\nיהיו לנו פרופילים חדשים להראות לך'**
  String get check_back_soon;

  /// No description provided for @about_yourself.
  ///
  /// In he, this message translates to:
  /// **'על עצמך'**
  String get about_yourself;

  /// No description provided for @what_partnership_are_you_looking.
  ///
  /// In he, this message translates to:
  /// **'איזה סוג של שותפות אתה מחפש?'**
  String get what_partnership_are_you_looking;

  /// No description provided for @share.
  ///
  /// In he, this message translates to:
  /// **'שיתוף'**
  String get share;

  /// No description provided for @upgrade.
  ///
  /// In he, this message translates to:
  /// **'שדרוג'**
  String get upgrade;

  /// No description provided for @send_feedback.
  ///
  /// In he, this message translates to:
  /// **'שלח משוב'**
  String get send_feedback;

  /// No description provided for @edit_profile.
  ///
  /// In he, this message translates to:
  /// **'עריכת פרופיל'**
  String get edit_profile;

  /// No description provided for @logout.
  ///
  /// In he, this message translates to:
  /// **'התנתקות'**
  String get logout;

  /// No description provided for @ok.
  ///
  /// In he, this message translates to:
  /// **'בסדר'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In he, this message translates to:
  /// **'ביטול'**
  String get cancel;

  /// No description provided for @yes.
  ///
  /// In he, this message translates to:
  /// **'כן'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In he, this message translates to:
  /// **'לא'**
  String get no;

  /// No description provided for @sing_out.
  ///
  /// In he, this message translates to:
  /// **'יציאה'**
  String get sing_out;

  /// No description provided for @sure_to_logout.
  ///
  /// In he, this message translates to:
  /// **'האם אתה בטוח שברצונך לצאת?'**
  String get sure_to_logout;

  /// No description provided for @profile.
  ///
  /// In he, this message translates to:
  /// **'פרופיל'**
  String get profile;

  /// No description provided for @questionnaire_init_error.
  ///
  /// In he, this message translates to:
  /// **'שגיאת אתחול שאלון'**
  String get questionnaire_init_error;

  /// No description provided for @save.
  ///
  /// In he, this message translates to:
  /// **'שמור'**
  String get save;

  /// No description provided for @date_of_birth.
  ///
  /// In he, this message translates to:
  /// **'תאריך לידה'**
  String get date_of_birth;

  /// No description provided for @search.
  ///
  /// In he, this message translates to:
  /// **'חיפוש'**
  String get search;

  /// No description provided for @no_result_found.
  ///
  /// In he, this message translates to:
  /// **'לא נמצאה תוצאה'**
  String get no_result_found;

  /// No description provided for @add_photos.
  ///
  /// In he, this message translates to:
  /// **'הוסף תמונות'**
  String get add_photos;

  /// No description provided for @confirmation.
  ///
  /// In he, this message translates to:
  /// **'אישור'**
  String get confirmation;

  /// No description provided for @all_unsaved_data_will_be_lost.
  ///
  /// In he, this message translates to:
  /// **'אתה באמת רוצה לצאת? כל הנתונים שלא נשמרו יאבדו.'**
  String get all_unsaved_data_will_be_lost;

  /// No description provided for @message_is_too_short.
  ///
  /// In he, this message translates to:
  /// **'ההודעה קצרה מדי.'**
  String get message_is_too_short;

  /// No description provided for @your_opinion_is_important.
  ///
  /// In he, this message translates to:
  /// **'דעתך חשובה לנו! נשמח לקבל משוב ממך.'**
  String get your_opinion_is_important;

  /// No description provided for @send.
  ///
  /// In he, this message translates to:
  /// **'שלח'**
  String get send;

  /// No description provided for @feedback_accepted.
  ///
  /// In he, this message translates to:
  /// **'משוב\nהתקבל'**
  String get feedback_accepted;

  /// No description provided for @thank_you_for_taking_time.
  ///
  /// In he, this message translates to:
  /// **'תודה שהקדשת מזמנך\nכדי לשלוח לנו משוב'**
  String get thank_you_for_taking_time;

  /// No description provided for @continue_browsing.
  ///
  /// In he, this message translates to:
  /// **'המשך גלישה'**
  String get continue_browsing;

  /// No description provided for @continue_label.
  ///
  /// In he, this message translates to:
  /// **'המשך'**
  String get continue_label;

  /// No description provided for @who_wanted_create_business_with_you.
  ///
  /// In he, this message translates to:
  /// **'ראה מי רצה ליצור איתך הזדמנות עסקית'**
  String get who_wanted_create_business_with_you;

  /// No description provided for @start_conversation_with_partners.
  ///
  /// In he, this message translates to:
  /// **'התחל שיחה עם שותפים עסקיים פוטנציאליים'**
  String get start_conversation_with_partners;

  /// No description provided for @unlimited_business_collaborations.
  ///
  /// In he, this message translates to:
  /// **'שיתופי פעולה עסקיים ללא הגבלה'**
  String get unlimited_business_collaborations;

  /// No description provided for @total.
  ///
  /// In he, this message translates to:
  /// **'סך הכל: {total}₪'**
  String total(String total);

  /// No description provided for @cancel_this_plan.
  ///
  /// In he, this message translates to:
  /// **'בטל תוכנית זו'**
  String get cancel_this_plan;

  /// No description provided for @our_plans.
  ///
  /// In he, this message translates to:
  /// **'התוכניות שלנו'**
  String get our_plans;

  /// No description provided for @payment.
  ///
  /// In he, this message translates to:
  /// **'תשלום'**
  String get payment;

  /// No description provided for @payment_desc.
  ///
  /// In he, this message translates to:
  /// **'אלא אם תבטל לפחות 24 שעות לפני סיום המנוי שלך, אמצעי התשלום שלך יתחדש אוטומטית באותה תקופה ומחיר.'**
  String get payment_desc;

  /// No description provided for @confirm_purchase.
  ///
  /// In he, this message translates to:
  /// **'אשר רכישה'**
  String get confirm_purchase;

  /// No description provided for @payment_timeout.
  ///
  /// In he, this message translates to:
  /// **'פסק זמן תשלום'**
  String get payment_timeout;

  /// No description provided for @payment_timeout_in.
  ///
  /// In he, this message translates to:
  /// **'פסק זמן תשלום ב'**
  String get payment_timeout_in;

  /// No description provided for @thank_you.
  ///
  /// In he, this message translates to:
  /// **'תודה!'**
  String get thank_you;

  /// No description provided for @lets_find_out_your_opportunities.
  ///
  /// In he, this message translates to:
  /// **'בואו לגלות את ההזדמנויות שלך :)'**
  String get lets_find_out_your_opportunities;

  /// No description provided for @purchase_timeout.
  ///
  /// In he, this message translates to:
  /// **'פסק זמן לרכישה'**
  String get purchase_timeout;

  /// No description provided for @please_select_pricing_plan.
  ///
  /// In he, this message translates to:
  /// **'אנא בחר תוכנית תמחור.'**
  String get please_select_pricing_plan;

  /// No description provided for @cancel_upgrade.
  ///
  /// In he, this message translates to:
  /// **'בטל את השדרוג'**
  String get cancel_upgrade;

  /// No description provided for @cancel_upgrade_desc.
  ///
  /// In he, this message translates to:
  /// **'האם אתה בטוח שברצונך לבטל את השדרוג? עם תום תקופת השדרוג, השדרוג לא יתחדש אוטומטית.'**
  String get cancel_upgrade_desc;

  /// No description provided for @keep_upgrading.
  ///
  /// In he, this message translates to:
  /// **'המשך לשדרג'**
  String get keep_upgrading;

  /// No description provided for @upgrade_was_canceled.
  ///
  /// In he, this message translates to:
  /// **'השדרוג בוטל!'**
  String get upgrade_was_canceled;

  /// No description provided for @upgrade_was_canceled_desc.
  ///
  /// In he, this message translates to:
  /// **'לא תחויב שוב אוטומטית לאחר שתוקף השדרוג שלך יפוג.'**
  String get upgrade_was_canceled_desc;

  /// No description provided for @partnext_grow.
  ///
  /// In he, this message translates to:
  /// **'לגדול Partnext'**
  String get partnext_grow;

  /// No description provided for @your_growth_can_accelerate.
  ///
  /// In he, this message translates to:
  /// **'הצמיחה שלך יכולה להאיץ עם החיבורים שאתה משיג כאן!\nראה מי רוצה להתחבר אליך.'**
  String get your_growth_can_accelerate;

  /// No description provided for @lets_talk_business.
  ///
  /// In he, this message translates to:
  /// **'בואו נדבר על עסקים'**
  String get lets_talk_business;

  /// No description provided for @leave_your_ego_aside.
  ///
  /// In he, this message translates to:
  /// **'עזוב את שלך\nאגו בצד'**
  String get leave_your_ego_aside;

  /// No description provided for @keep_positive_attitude.
  ///
  /// In he, this message translates to:
  /// **'שמור על חיובי\nגישה'**
  String get keep_positive_attitude;

  /// No description provided for @keep_it_simple.
  ///
  /// In he, this message translates to:
  /// **'שמור את זה\nפשוט'**
  String get keep_it_simple;

  /// No description provided for @upgrade_to_premium.
  ///
  /// In he, this message translates to:
  /// **'שדרג לפרמיום'**
  String get upgrade_to_premium;

  /// No description provided for @write_message.
  ///
  /// In he, this message translates to:
  /// **'כתוב הודעה...'**
  String get write_message;

  /// No description provided for @image.
  ///
  /// In he, this message translates to:
  /// **'תמונה'**
  String get image;

  /// No description provided for @document.
  ///
  /// In he, this message translates to:
  /// **'מסמך'**
  String get document;

  /// No description provided for @file.
  ///
  /// In he, this message translates to:
  /// **'קובץ'**
  String get file;

  /// No description provided for @no_chats.
  ///
  /// In he, this message translates to:
  /// **'עדיין אין לך צ \' אטים.'**
  String get no_chats;

  /// No description provided for @chats.
  ///
  /// In he, this message translates to:
  /// **'צ \' אטים'**
  String get chats;

  /// No description provided for @attachment_max_size.
  ///
  /// In he, this message translates to:
  /// **'גודל הקבצים שהועלו לא יעלה על {size} מגה בייט.'**
  String attachment_max_size(int size);

  /// No description provided for @chats_ad_title.
  ///
  /// In he, this message translates to:
  /// **'הזדמנויות עסקיות פוטנציאליות'**
  String get chats_ad_title;

  /// No description provided for @chats_ad_desc.
  ///
  /// In he, this message translates to:
  /// **'התחל איתם שיחה עסקית עכשיו!'**
  String get chats_ad_desc;

  /// No description provided for @no_messages.
  ///
  /// In he, this message translates to:
  /// **'עדיין אין לך הודעות.'**
  String get no_messages;

  /// No description provided for @you.
  ///
  /// In he, this message translates to:
  /// **'אתה'**
  String get you;

  /// No description provided for @report.
  ///
  /// In he, this message translates to:
  /// **'דוח'**
  String get report;

  /// No description provided for @unmatch.
  ///
  /// In he, this message translates to:
  /// **'בטל התאמה'**
  String get unmatch;

  /// No description provided for @sure_to_unmatch.
  ///
  /// In he, this message translates to:
  /// **'האם אתה מאשר שברצונך לבטל התאמה עם המשתמש?\n\nכל ההודעות והקבצים הקשורים בצ \' אט זה יימחקו לצמיתות!'**
  String get sure_to_unmatch;

  /// No description provided for @report_user.
  ///
  /// In he, this message translates to:
  /// **'דווח על משתמש'**
  String get report_user;

  /// No description provided for @details.
  ///
  /// In he, this message translates to:
  /// **'פרטים'**
  String get details;

  /// No description provided for @thank_you_for_reporting_user.
  ///
  /// In he, this message translates to:
  /// **'תודה שדיווחת על משתמש'**
  String get thank_you_for_reporting_user;

  /// No description provided for @your_report_will_be_reviewed.
  ///
  /// In he, this message translates to:
  /// **'הפרופיל המדווח שלך ייבדק\nותינקט פעולה.'**
  String get your_report_will_be_reviewed;

  /// No description provided for @back_to_chats.
  ///
  /// In he, this message translates to:
  /// **'חזרה לצ \' אטים'**
  String get back_to_chats;

  /// No description provided for @no_photo.
  ///
  /// In he, this message translates to:
  /// **'אין תמונה'**
  String get no_photo;

  /// No description provided for @per_month.
  ///
  /// In he, this message translates to:
  /// **'לחודש'**
  String get per_month;

  /// No description provided for @per_week.
  ///
  /// In he, this message translates to:
  /// **'בשבוע'**
  String get per_week;

  /// No description provided for @delete_account.
  ///
  /// In he, this message translates to:
  /// **'מחק חשבון'**
  String get delete_account;

  /// No description provided for @sure_to_delete_account.
  ///
  /// In he, this message translates to:
  /// **'האם אתה מאשר שברצונך למחוק לצמיתות את חשבונך ואת כל הנתונים הקשורים אליו?\n\nשחזור נתונים יהיה בלתי אפשרי לאחר המחיקה!'**
  String get sure_to_delete_account;

  /// No description provided for @delete.
  ///
  /// In he, this message translates to:
  /// **'מחק'**
  String get delete;

  /// No description provided for @confirm.
  ///
  /// In he, this message translates to:
  /// **'אישור'**
  String get confirm;
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
