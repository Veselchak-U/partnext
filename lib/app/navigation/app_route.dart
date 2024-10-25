class AppRoute {
  static const initial = AppRoute('initial', '/');
  static const welcome = AppRoute('welcome', '/welcome');

  // Auth
  static const login = AppRoute('login', '/login');
  static const signUp = AppRoute('signUp', '/signUp');
  static const questionnaire = AppRoute('questionnaire', '/questionnaire');
  static const successRegistration = AppRoute('successRegistration', '/successRegistration');

  static const home = AppRoute('home', '/home');

  final String name;
  final String path;

  const AppRoute(this.name, this.path);
}
