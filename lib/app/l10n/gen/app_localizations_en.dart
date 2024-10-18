import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get page_not_found => 'Page not found';

  @override
  String get to_initial_screen => 'To initial screen';

  @override
  String get go_to_login_screen => 'Unauthorized user - go to the login screen';

  @override
  String get authorization => 'Authorization';

  @override
  String get invalid_code => 'Invalid OTP code';

  @override
  String get no_internet_connection => 'No internet connection';

  @override
  String get server_timeout => 'Server timeout';

  @override
  String get no_data => 'No data';

  @override
  String get auth_failed => 'Authentication error';

  @override
  String get wrong_code => 'Wrong code. Try again...';

  @override
  String get user_phone_exist => 'User with this phone number exist!';

  @override
  String field_not_unique(String name) {
    return 'This field is not unique: $name';
  }

  @override
  String field_required(String name) {
    return 'This field is required: $name';
  }
}
