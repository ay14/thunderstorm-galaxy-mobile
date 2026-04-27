import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/api/api_client.dart';
import '../models/company_model.dart';

final companiesProvider = FutureProvider.family<List<CompanyModel>, String>((ref, search) async {
  final apiClient = ref.watch(apiClientProvider);
  final res = await apiClient.get('/companies?search=$search&per_page=50');
  final data = jsonDecode(res.body) as Map<String, dynamic>;
  final companies = (data['data'] as List<dynamic>)
      .map((e) => CompanyModel.fromJson(e as Map<String, dynamic>))
      .toList();
  return companies;
});

class CompanySuggestionNotifier extends StateNotifier<AsyncValue<void>> {
  CompanySuggestionNotifier(this._ref) : super(const AsyncData(null));

  final Ref _ref;

  Future<bool> submit({
    required String name,
    required String category,
    String? registrationNumber,
    String? website,
  }) async {
    state = const AsyncLoading();
    try {
      final body = jsonEncode({
        'name': name,
        'category': category,
        if (registrationNumber != null && registrationNumber.isNotEmpty) 'registration_number': registrationNumber,
        if (website != null && website.isNotEmpty) 'website': website,
      });
      await _ref.read(apiClientProvider).post('/companies/suggest', body: body);
      state = const AsyncData(null);
      return true;
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      return false;
    }
  }
}

final companySuggestionProvider =
    StateNotifierProvider<CompanySuggestionNotifier, AsyncValue<void>>((ref) => CompanySuggestionNotifier(ref));
