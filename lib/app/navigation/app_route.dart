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
  static const profile = AppRoute('profile', '/profile');
  static const sendFeedback = AppRoute('sendFeedback', 'sendFeedback');
  static const feedbackAccepted = AppRoute('feedbackAccepted', '/feedbackAccepted');

  final String name;
  final String path;

  const AppRoute(this.name, this.path);
}
