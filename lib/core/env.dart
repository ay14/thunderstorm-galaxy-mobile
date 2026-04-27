const String _apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:8000/api',
);

const String _appEnv = String.fromEnvironment(
  'APP_ENV',
  defaultValue: 'development',
);

abstract final class Env {
  static String get apiBaseUrl => _apiBaseUrl;
  static String get appEnv => _appEnv;
  static bool get isProduction => _appEnv == 'production';
}
