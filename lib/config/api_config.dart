class ApiConfig {
  ApiConfig._();

  // Base URL backend API.
  static const String baseUrl = 'http://localhost:8000/api';

  // Global timeout settings.
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Default headers.
  static const String contentTypeJson = 'application/json';
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer';

  // Endpoints.
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String profile = '/auth/me';
  // untuk refresh token
  static const String refresh = '/auth/refresh';

  static String url(String endpoint) => '$baseUrl$endpoint';
}
