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
}
