import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/api/api_client.dart' show ApiClient, TokenStorage, apiClientProvider, tokenStorageProvider;
import '../models/user_model.dart';

class AuthState {
  const AuthState({this.token, this.user, this.isLoading = false, this.error});

  final String? token;
  final UserModel? user;
  final bool isLoading;
  final String? error;

  AuthState copyWith({String? token, UserModel? user, bool? isLoading, String? error}) {
    return AuthState(
      token: token ?? this.token,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._apiClient, TokenStorage tokenStorage) : _tokenStorage = tokenStorage, super(const AuthState()) {
    _loadToken();
  }

  final ApiClient _apiClient;
  final TokenStorage _tokenStorage;

  Future<void> _loadToken() async {
    final token = await _tokenStorage.read();
    if (token != null) {
      state = state.copyWith(token: token);
      await fetchMe();
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    String? phone,
    String role = 'customer',
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final body = jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'phone': phone,
        'role': role,
      });
      final res = await _apiClient.post('/auth/register', body: body);
      if (res.statusCode == 200 || res.statusCode == 201) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false, error: _extractError(res.body));
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'An error occurred.');
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final body = jsonEncode({'email': email, 'password': password});
      final res = await _apiClient.post('/auth/login', body: body);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        final token = data['token'] as String;
        final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
        await _tokenStorage.save(token);
        state = state.copyWith(token: token, user: user, isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false, error: _extractError(res.body));
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'An error occurred.');
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final body = jsonEncode({'otp': otp});
      final res = await _apiClient.post('/auth/verify-otp', body: body);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        final token = data['token'] as String;
        final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
        await _tokenStorage.save(token);
        state = state.copyWith(token: token, user: user, isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false, error: _extractError(res.body));
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'An error occurred.');
      return false;
    }
  }

  Future<bool> completeOnboarding({
    String? name,
    String? phone,
    String? role,
    int? companyId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final body = jsonEncode({
        if (name != null) 'name': name,
        if (phone != null) 'phone': phone,
        if (role != null) 'role': role,
        if (companyId != null) 'company_id': companyId,
      });
      final res = await _apiClient.post('/auth/complete-onboarding', body: body);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
        state = state.copyWith(user: user, isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false, error: _extractError(res.body));
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'An error occurred.');
      return false;
    }
  }

  Future<void> fetchMe() async {
    try {
      final res = await _apiClient.get('/auth/me');
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        final user = UserModel.fromJson(data['user'] as Map<String, dynamic>);
        state = state.copyWith(user: user);
      }
    } catch (_) {}
  }

  Future<void> logout() async {
    try {
      await _apiClient.post('/auth/logout');
    } catch (_) {}
    await _tokenStorage.clear();
    state = const AuthState();
  }

  String _extractError(String responseBody) {
    try {
      final data = jsonDecode(responseBody) as Map<String, dynamic>;
      return (data['message'] as String?) ?? 'An error occurred.';
    } catch (_) {
      return 'An error occurred.';
    }
  }
}

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(apiClientProvider), ref.watch(tokenStorageProvider));
});
