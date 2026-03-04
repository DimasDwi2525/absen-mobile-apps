import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthSessionHelper {
  AuthSessionHelper._();

  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _loginDataKey = 'login_data';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setBool(_isLoggedInKey, token.isNotEmpty);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, token);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<void> saveLoginData(Map<String, dynamic> loginData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loginDataKey, jsonEncode(loginData));
  }

  static Future<Map<String, dynamic>?> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_loginDataKey);
    if (raw == null || raw.isEmpty) {
      return null;
    }

    final parsed = jsonDecode(raw);
    if (parsed is Map<String, dynamic>) {
      return parsed;
    }

    return null;
  }

  static Future<void> saveLoginSession({
    required String token,
    String? refreshToken,
    Map<String, dynamic>? loginData,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_tokenKey, token);
    await prefs.setBool(_isLoggedInKey, token.isNotEmpty);

    if (refreshToken != null) {
      await prefs.setString(_refreshTokenKey, refreshToken);
    }

    if (loginData != null) {
      await prefs.setString(_loginDataKey, jsonEncode(loginData));
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final storedFlag = prefs.getBool(_isLoggedInKey) ?? false;
    return storedFlag && token != null && token.isNotEmpty;
  }

  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_loginDataKey);
    await prefs.setBool(_isLoggedInKey, false);
  }
}
