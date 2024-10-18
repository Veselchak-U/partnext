class AppRoute {
  static const initial = AppRoute('initial', '/');

  // Auth
  static const signUp = AppRoute('signUp', '/signUp');
  static const verifyPhone = AppRoute('verifyPhone', '/verifyPhone');
  static const successRegistration = AppRoute('successRegistration', '/successRegistration');
  static const login = AppRoute('login', '/login');

  final String name;
  final String path;

  const AppRoute(this.name, this.path);
}
