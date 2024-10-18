enum Env {
  dev(
    'https://partnext.bitango.co.il/',
  ),
  prod(
    'https://partnext.bitango.co.il/',
  );

  const Env(
    this.baseUrl,
  );

  final String baseUrl;
}
