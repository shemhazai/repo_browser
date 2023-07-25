/// A configuration for the app which depends on the environment.
enum AppEnvironment {
  development(name: 'development', baseUrl: 'https://api.github.com/');

  final String name;
  final String baseUrl;

  const AppEnvironment({
    required this.name,
    required this.baseUrl,
  });
}
