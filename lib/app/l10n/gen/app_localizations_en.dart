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

  @override
  String get welcome_label => 'Opportunities | Partnerships | Connections';

  @override
  String get start => 'Start';

  @override
  String get already_have_account => 'Already have an account?';

  @override
  String get login => 'Login';

  @override
  String get invalid_phone_number => 'Invalid phone number, please try again :)';

  @override
  String get terms_must_accepted => 'To register, you must agree to the terms and conditions';

  @override
  String get registration => 'Registration';

  @override
  String get full_name => 'Full Name';

  @override
  String get phone_number => 'Phone Number';

  @override
  String get next => 'Next';

  @override
  String get i_accept => 'I accept';

  @override
  String get terms_and_conditions => 'Terms & Conditions';

  @override
  String get and => 'and';

  @override
  String get privacy_policy => 'privacy policy';

  @override
  String get do_not_have_account => 'Don\'t have an account yet?';

  @override
  String get password_must_contain => 'The password must consist of 6 digits';

  @override
  String get enter_validation_code => 'Please enter the validation code that we sent you';

  @override
  String get did_not_get_code => 'Didn’t get the code?';

  @override
  String get resend_code => 'Resend Code';

  @override
  String get phone_validation => 'Phone Validation';

  @override
  String get what_am_i => 'What am I';
}
