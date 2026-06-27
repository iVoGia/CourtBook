import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/api_config.dart';

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<Map<String, dynamic>?> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_userKey);
    if (raw == null) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> setSession(String? token, Map<String, dynamic>? user) async {
    final prefs = await SharedPreferences.getInstance();
    if (token == null) {
      await prefs.remove(_tokenKey);
      await prefs.remove(_userKey);
    } else {
      await prefs.setString(_tokenKey, token);
      if (user != null) await prefs.setString(_userKey, jsonEncode(user));
    }
  }

  Future<void> setToken(String? token) => setSession(token, null);

  Future<Map<String, String>> _headers({bool auth = false}) async {
    final headers = <String, String>{'Content-Type': 'application/json'};
    if (auth) {
      final token = await getToken();
      if (token != null) headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Future<List<dynamic>> getList(String path, {bool auth = false}) async {
    final res = await _client.get(
      Uri.parse('${ApiConfig.apiPrefix}$path'),
      headers: await _headers(auth: auth),
    );
    final data = _decodeBody(res);
    if (data is List) return data;
    throw ApiException(res.statusCode, 'INVALID_RESPONSE');
  }

  Future<Map<String, dynamic>> get(String path, {bool auth = false}) async {
    final res = await _client.get(
      Uri.parse('${ApiConfig.apiPrefix}$path'),
      headers: await _headers(auth: auth),
    );
    final data = _decodeBody(res);
    if (data is Map<String, dynamic>) return data;
    return {'data': data};
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    bool auth = false,
  }) async {
    final res = await _client.post(
      Uri.parse('${ApiConfig.apiPrefix}$path'),
      headers: await _headers(auth: auth),
      body: body != null ? jsonEncode(body) : null,
    );
    final data = _decodeBody(res);
    if (data is Map<String, dynamic>) return data;
    return {'data': data};
  }

  Future<Map<String, dynamic>> patch(
    String path, {
    Map<String, dynamic>? body,
    bool auth = false,
  }) async {
    final res = await _client.patch(
      Uri.parse('${ApiConfig.apiPrefix}$path'),
      headers: await _headers(auth: auth),
      body: body != null ? jsonEncode(body) : null,
    );
    final data = _decodeBody(res);
    if (data is Map<String, dynamic>) return data;
    return {'data': data};
  }

  Future<void> delete(String path, {bool auth = false}) async {
    final res = await _client.delete(
      Uri.parse('${ApiConfig.apiPrefix}$path'),
      headers: await _headers(auth: auth),
    );
    _decodeBody(res);
  }

  dynamic _decodeBody(http.Response res) {
    final data = jsonDecode(res.body.isEmpty ? 'null' : res.body);
    if (res.statusCode >= 400) {
      final code = data is Map ? data['error']?.toString() : res.body;
      throw ApiException(res.statusCode, code);
    }
    return data;
  }
}

class ApiException implements Exception {
  ApiException(this.statusCode, this.code);
  final int statusCode;
  final String? code;

  String localizedMessage() {
    const map = {
      'AUTH_INVALID': 'Email hoặc mật khẩu không đúng',
      'BOOKING_CONFLICT': 'Khung giờ đã được đặt',
      'CANCEL_24H': 'Không thể hủy trong vòng 24 giờ',
      'ADMIN_FORBIDDEN': 'Không có quyền quản trị',
    };
    return map[code] ?? code ?? 'Lỗi API $statusCode';
  }

  @override
  String toString() => localizedMessage();
}
