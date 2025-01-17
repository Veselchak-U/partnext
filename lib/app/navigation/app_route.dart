class AppRoute {
  static const initial = AppRoute('initial', '/');
  static const welcome = AppRoute('welcome', '/welcome');

  // Auth
  static const login = AppRoute('login', '/login');
  static const signUp = AppRoute('signUp', '/sign_up');
  static const phoneValidation = AppRoute('phone_validation', '/phone_validation');
  static const questionnaire = AppRoute('questionnaire', '/questionnaire');
  static const signUpSuccess = AppRoute('sign_up_success', '/sign_up_success');

  static const home = AppRoute('home', '/home');

  static const grow = AppRoute('grow', '/grow');
  static const partnerDetails = AppRoute('partner_details', 'partner_details');

  static const profile = AppRoute('profile', '/profile');
  static const upgrade = AppRoute('upgrade', 'upgrade');
  static const sendFeedback = AppRoute('send_feedback', 'send_feedback');

  static const actionResult = AppRoute('action_result', '/action_result');

  final String name;
  final String path;

  const AppRoute(this.name, this.path);
}
