import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../core/env.dart';

const _tokenKey = 'auth_token';

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (_) => const FlutterSecureStorage(),
);

final apiClientProvider = Provider<ApiClient>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return ApiClient(
    baseUrl: Env.apiBaseUrl,
    storage: storage,
  );
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage(ref.watch(secureStorageProvider));
});

class ApiClient {
  final String baseUrl;
  final FlutterSecureStorage storage;

  ApiClient({
    required this.baseUrl,
    required this.storage,
  });

  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<Map<String, String>> _getHeadersWithAuth() async {
    final token = await storage.read(key: _tokenKey);
    return {
      ..._getHeaders(),
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> get(String endpoint) async {
    final headers = await _getHeadersWithAuth();
    return await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    ).timeout(const Duration(seconds: 30));
  }

  Future<http.Response> post(String endpoint, {dynamic body}) async {
    final headers = await _getHeadersWithAuth();
    return await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: body,
    ).timeout(const Duration(seconds: 30));
  }

  Future<http.Response> put(String endpoint, {dynamic body}) async {
    final headers = await _getHeadersWithAuth();
    return await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: body,
    ).timeout(const Duration(seconds: 30));
  }

  Future<http.Response> delete(String endpoint) async {
    final headers = await _getHeadersWithAuth();
    return await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    ).timeout(const Duration(seconds: 30));
  }

  Future<http.Response> patch(String endpoint, {dynamic body}) async {
    final headers = await _getHeadersWithAuth();
    return await http.patch(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: body,
    ).timeout(const Duration(seconds: 30));
  }
}

class TokenStorage {
  const TokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  Future<void> save(String token) => _storage.write(key: _tokenKey, value: token);
  Future<void> clear() => _storage.delete(key: _tokenKey);
  Future<String?> read() => _storage.read(key: _tokenKey);
}
