import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get page_not_found => 'הדף לא נמצא';

  @override
  String get to_initial_screen => 'למסך ראשי';

  @override
  String get go_to_login_screen => 'משתמש לא מורשה-עבור למסך הכניסה';

  @override
  String get authorization => 'אישור';

  @override
  String get invalid_code => 'קוד לא תקין';

  @override
  String get no_internet_connection => 'אין חיבור לאינטרנט';

  @override
  String get server_timeout => 'השרת הפסיק לעבוד';

  @override
  String get no_data => 'אין נתונים';

  @override
  String get auth_failed => 'שגיאת אימות';

  @override
  String get wrong_code => 'קוד שגוי. נסה שוב...';

  @override
  String get user_phone_exist => 'קיים כבר משתמש עם מספר הטלפון הזה!';

  @override
  String field_not_unique(String name) {
    return 'שדה זה אינו ייחודי: $name';
  }

  @override
  String field_required(String name) {
    return 'שדה חובה: $name';
  }

  @override
  String get welcome_label => 'הזדמנויות | שותפויות | קשרים';

  @override
  String get start => 'התחל';

  @override
  String get already_have_account => 'כבר יש לך חשבון?';

  @override
  String get login => 'התחברות';

  @override
  String get invalid_phone_number => 'מספר טלפון לא חוקי, אנא נסה שוב :)';

  @override
  String get terms_must_accepted => 'כדי להירשם, עליך להסכים לתנאים וההגבלות';

  @override
  String get registration => 'רישום';

  @override
  String get full_name => 'שם מלא';

  @override
  String get phone_number => 'מספר טלפון';

  @override
  String get next => 'הבא';

  @override
  String get i_accept => 'אני מקבל';

  @override
  String get terms_and_conditions => 'תנאים והגבלות';

  @override
  String get and => 'ו';

  @override
  String get privacy_policy => 'מדיניות פרטיות';

  @override
  String get do_not_have_account => 'עדיין אין לך חשבון?';

  @override
  String get password_must_contain => 'הסיסמה חייבת להכיל 6 ספרות';

  @override
  String get enter_validation_code => 'נא להזין את קוד האימות ששלחנו לך';

  @override
  String get did_not_get_code => 'לא קיבלת את הקוד?';

  @override
  String get resend_code => 'לשלוח שוב קוד';
}
