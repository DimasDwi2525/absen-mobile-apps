import '../config/api_config.dart';

class AttendanceApi {
  const AttendanceApi();

  Uri loginUri() => Uri.parse(ApiConfig.url(ApiConfig.login));

  Uri logoutUri() => Uri.parse(ApiConfig.url(ApiConfig.logout));

  Uri profileUri() => Uri.parse(ApiConfig.url(ApiConfig.profile));

  Map<String, String> defaultHeaders({String? token}) {
    final headers = <String, String>{
      'Content-Type': ApiConfig.contentTypeJson,
      'Accept': ApiConfig.contentTypeJson,
    };

    if (token != null && token.isNotEmpty) {
      headers[ApiConfig.authorizationHeader] =
          '${ApiConfig.bearerPrefix} $token';
    }

    return headers;
  }
}
