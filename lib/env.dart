enum Env {
  dev(
    'https://api.partnext.tech/',
  ),
  prod(
    'https://api.partnext.tech/',
  );

  const Env(
    this.baseUrl,
  );

  final String baseUrl;
}
